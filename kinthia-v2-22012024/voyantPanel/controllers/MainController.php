<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantPanel_MainController extends AppController
{
    const Hash_Expiry_Time = 1800;

    /**
    * Initailize controller set access privileges
    */
    public function init()
    {
        $this->acl->allow('voyant', $this->name, '*');

        $this->acl->allow('guest', $this->name, 'logIn');
        $this->acl->allow('guest', $this->name, 'lostPassword');
        $this->acl->allow('guest', $this->name, 'sendLostPassword');
        $this->acl->allow('guest', $this->name, 'passwordConfirmationSave');
        $this->acl->allow('guest', $this->name, 'passwordConfirmationForm');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect($this->moduleLink('logIn'));
        }
    }

    public function indexAction()
    {
        $voyant = $this->voyant->findByPk($this->userId);
             $voyantId = $this->userId;
          $vdo_usedtime = $this->statistic->getConsultationtime($voyantId,'webcam');
          $phone_usedtime = $this->statistic->getConsultationtime($voyantId,'phone');  
          $voyant['vdo_usedtime'] = $vdo_usedtime;
          $voyant['phone_usedtime'] = $phone_usedtime;
         
        $this->set('voyant',$voyant );
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount' => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount' => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId),
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1'),
            'answeredQuestionsEarning' => $this->statistic->getVoyantQuestionsTotalEarning($this->userId),
            
            'totalEarningPhone' => $this->statistic->getTotalEarning('phone',$this->userId),
            'totalEarningWebcam' => $this->statistic->getTotalEarning('webcam',$this->userId),

        ));  

        $k = new Criteria();
        $k->add('voyantId', $this->userId);
        $VoyantConsultationIds = $this->VoyantConsultation->findAll($k, 'consultationId');
        $consultationIds = [];
        if(isset($VoyantConsultationIds) && !empty($VoyantConsultationIds)){
            foreach($VoyantConsultationIds as $key=> $consultation){
                $consultationIds[] = $consultation['consultationId'];
            }
        }
        $consultationIds = array_values(array_unique($consultationIds));
        $this->set('consultationIds', $consultationIds); 
        /*echo "<pre>";
        print_r($voyant);
        die();*/ 
    }
    
    public function saveAvailableAction()
    {
        $display = $this->request->display;
       
       if($display == 0){
        $data = array(
           $this->request->name => $display,
           'displayPhone' =>  $display,
           'displayWebcam' => $display,
           'displayEmail' => $display,
        );
       }else{
        $data = array($this->request->name => $display);
       }
        $this->voyant->updateByPk($data, $this->userId);  
           echo $display;
           exit(); 
       //$this->redirect($this->moduleLink());
    }

    public function saveConsultationAction()
    {
        $display = 0;
        if($this->request->display > 0){ $display = $this->request->display; }
        $data = array($this->request->name => $display);
        $this->voyant->updateByPk($data, $this->userId); 
        echo $display; 
         exit();       
       // $this->redirect($this->moduleLink()); 
    }

    public function logInAction()
    {        
        if (isset($this->request->email) && isset($this->request->password)) {
            if ($this->session->loginUser($this->request->email, md5($this->request->password), 'email', 'voyant')) {
                $data = ['consultationStatus'=>'ON'];
                $this->voyant->updateByPk($data, $this->userId);
                $this->redirect($this->moduleLink());
            } else {
                $this->set('loginError', 1);
            }
        }
    }

    public function logOutAction()
    {
        $data = ['consultationStatus'=>'OF'];
        $this->voyant->updateByPk($data, $this->userId);
        $this->session->destroy();
        $this->redirect($this->moduleLink('logIn'));
    }

    /**
     * @param string $email
     * @return UserRecord
     */
    private function getUserByEmail(string $email)
    {
        $c = new Criteria();
        $c->add('email', $email);
        $c->add('role', 'voyant');

        return $this->user->find($c);
    }

    /**
     * Lost password form
     */
    public function lostPasswordAction()
    {
        $email = $this->request->email ?? null;
        if ($email) {
            $this->viewClass = 'JsonView';
            $user = $this->getUserByEmail($email);
            if (empty($user)) {
                $errorMessage = 'Aucun expert trouvé avec cet email.';
            }

            if (Config::get('captchaInContactFormEnabled')
                && empty($errorMessage)
                && !$this->captchaCode->validatePublicAndPrivateCodes($this->request)
            ) {
                $errorMessage = 'You did not guess the security code. Try again with a new one.';
            }

            if (empty($errorMessage)) {
                Mailer::getInstance()->sendEmailConfirmation(
                    'lostPasswordCon',
                    $user->email,
                    Config::get('siteRootUrl') .
                    $this->moduleLink(
                        'passwordConfirmationForm/?hash=' . $this->encodeHashByUser($user),
                        false
                    )
                );
                $this->set('status', 'ok');
            } else {
                $this->set('status', 'error');
                $this->set('message', _t($errorMessage));
            }
        }
    }

    public function passwordConfirmationFormAction()
    {
        $hash = isset($_GET['hash']) ? trim($_GET['hash']) : null;
        if (!$hash) {
            $this->redirect($this->moduleLink());
        }
        $this->set('hash', $hash);
    }

    /**
     * @return bool|void
     */
    public function passwordConfirmationSaveAction()
    {
        $this->viewClass = 'JsonView';
        $hash = $this->request->hash;
        $password = $this->request->password;
        $passwordRepeat = $this->request->passwordRepeat;
        if ($password !== $passwordRepeat) {
            $errorMessage = 'Password not match.';
        }
        if (!$hash) {
            $errorMessage = 'Hash not found';
        }
        if ($password !== $passwordRepeat) {
            $errorMessage = 'Passwords are not match';
        }
        $hashDecoded = $this->decodehash($hash);
        $timestamp = $hashDecoded['timestamp'] ?? null;
        $email = $hashDecoded['email'] ?? null;
        $token = $hashDecoded['token'] ?? null;

        if (!$token) {
            $errorMessage = 'Token not found.';
        }

        if ($timestamp < (time() - self::Hash_Expiry_Time)) {
            $errorMessage = 'Lien expiré.<br> Merci de demander un nouveau lien pour réinitialiser votre mot de passe.';
        }
        /** @var UserRecord $user */
        $user = $this->getUserByEmail($email);
        if (empty($user)) {
            $errorMessage = 'We haven\'t this email in database';
        }

        if (!$this->tokenCheck($user, $token)) {
            $errorMessage = 'Le lien n\'est plus sécurisé. <br> Merci de demander un nouveau lien pour réinitialiser votre mot de passe.';
        }

        if (empty($errorMessage)) {
            $user->changePassword($password);

            return $this->set('status', 'ok');
        }

         $this->set('status', 'no');
         $this->set('message', _t($errorMessage));
    }

    private function errorMessage($message, $redirect = false)
    {
        $this->viewClass = 'JsonView';
        $this->set('status', 'error');
        $this->set('message', $message);
        if ($redirect) {
            $this->redirect($this->moduleLink());
        }
    }

    private function decodehash($hash)
    {
        return json_decode(base64_decode($hash), true);
    }

    private function encodeHashByUser($user)
    {
        return base64_encode(json_encode([
            'token' => md5('kint' . $user->password . 'Hia'),
            'email' => $user->email,
            'timestamp' => time()
        ]));
    }

    private function tokenCheck($user, $token)
    {
        return md5('kint' . $user->password . 'Hia') === $token;
    }
    
}

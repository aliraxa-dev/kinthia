<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_MainController extends AppController
{    
    private $editMode = false;

    const Hash_Expiry_Time = 1800;
    
    /**
    * Initailize controller set access privileges
    */
    public function init()
    {        
        $this->acl->allow('user', $this->name, '*');
        
        $this->acl->allow('guest', $this->name, 'logIn');
        $this->acl->allow('guest', $this->name, 'lostPassword');
        $this->acl->allow('guest', $this->name, 'sendLostPassword');
        $this->acl->allow('guest', $this->name, 'passwordConfirmationSave');
        $this->acl->allow('guest', $this->name, 'passwordConfirmationForm');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect($this->moduleLink('logIn'));  
        }

        $this->set("action",$this->action);
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);
        
        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }
    
    /**
    * Redirect to managment panel
    */
    public function indexAction()
    {
        $this->redirect(AppRouter::getRewrittedUrl('/user/management'));
    }
    
    /**
    * Login and inscription form 
    */
    public function logInAction($urlName=NULL)
    {
        $this->set("urlName", $urlName);
        //if form was posted
        if (isset($this->request->email) && isset($this->request->password)) {
            $email = $this->request->email;
            return $this->loginAsUser($email, $this->request->password, !empty($this->request->rememberMe), $this->request->urlName, true);
        }
    }

    private function loginAsUser($email, $password, $rememberMe, $urlName, $redirect = false)
    {
        if (!$this->bannedEmail->isBanned($email)
            && !$this->bannedIp->isBanned($this->request->getIp())
            && $this->session->loginUser($email, md5($password), 'email', 'user')
        ) {
            if (!empty($rememberMe)) {
                $expire = time() + 60*60*24*30;

                $this->response->setCookie('rememberMe', true, $expire);
                $this->response->setCookie('email', $email, $expire);
                $this->response->setCookie('password', md5($password), $expire);
            }

            //if yes redirect to managment panel
            $redirectUrl = $this->session->get('redirectUrl');
            $this->session->del('redirectUrl');

            if (empty($redirectUrl)) {
                $redirectUrl = $this->moduleLink();
            }

            if ($redirect) {
                if(!empty($urlName)){

                    $this->redirect(AppRouter::getRewrittedUrl("/".$urlName));exit;
                }
                
                return $this->redirect($redirectUrl);
            } else {
                $this->set('status', 'ok');
            }
        } else {
            //if no set error message
            $this->set('loginError', 1);
        }
    }
    
    /**
    * logout webmaster 
    */
    public function logoutAction()
    {
        
        $this->session->destroy();
        $this->response->setCookie('rememberMe', '');
        $this->response->setCookie('email', '');
        $this->response->setCookie('password', '');
        $this->redirect($this->moduleLink());
    }

    /**
     * @param string $email
     * @return UserRecord
     */
    private function getUserByEmail(string $email)
    {
        $c = new Criteria();
        $c->add('email', $email);
        $c->add('role', 'user');

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
                $errorMessage = 'We haven\'t this email in database';
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
            $errorMessage = 'Confirmation link expired.';
        }
        /** @var UserRecord $user */
        $user = $this->getUserByEmail($email);
        if (empty($user)) {
            $errorMessage = 'We haven\'t this email in database';
        }

        if (!$this->tokenCheck($user, $token)) {
            $errorMessage = 'Token is not secure.';
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

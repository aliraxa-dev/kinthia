<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_RegisterController extends AppController
{    
    /**
    * Check that during user inscription email can be acceptabe (not banned and busy)
    * @return mixed AjaxJson 
    */
    public function isEmailAcceptableAction()
    {
        $valid = true;
        $email = $this->request->email;
             
        $c = new Criteria();
        $c->add('email', $email);
        
        //check is email busy
        if ($this->user->getCount($c)) {
            $valid = false;
        } else {
            //check is email banned
            if ($this->bannedEmail->isBanned($email)) {
                $valid = false;
            }
        }
        
        echo $valid ? 'true' : 'false';
        $this->autoRender = false;
    }
    
    /**
    * Validate user data
    * @return string message or false
    */
    private function validateRegistration($options = array())
    {
        if (empty($options['ignoreCaptcha'])) {
            if (Config::get('captchaInRegistrationEnabled')
               && !$this->captchaCode->validatePublicAndPrivateCodes($this->request)
            ) {
                return 'You did not guess the security code. Try again with a new one.';
            }
        }                                                                                                                     
        if (empty($this->request->email)
            || !preg_match('#^(([A-Za-z0-9_])|([\-\.]))+\@(([A-Za-z0-9_])|([\-\.]))+\.([A-Za-z]{2,4})$#',
                           $this->request->email)
        ) {
            return 'Missed email';
        } 
        if (empty($this->request->name)) {
            return 'Missed name';
        }
        
        $c = new Criteria();
        $c->add('name', $this->request->name);
        
        if ($this->user->getCount($c) > 0) {
            return 'This pseudo was used earlier';
        }

        $c = new Criteria();
        $c->add('email', $this->request->email);
        
        if ($this->user->getCount($c) > 0) {
            return 'This email was used earlier';
        } 
        if ($this->bannedEmail->isBanned($this->request->email)) {
            return 'This email is banned.';                       
        } 
        if ($this->bannedIp->isBanned($this->request->getIp())) {
           return 'Your IP is banned.';
        } 
        if (empty($this->request->password)) {
            return 'Empty password';
        }
            
        return '';
    }
    
    /**
    * Register user from ajax query 
    */
    public function registerAction()
    {
        $this->viewClass = 'JsonView';
        
        $errorMessage = $this->validateRegistration();
        
        if (!$errorMessage) {
            $user = new UserRecord();
            $user->name = $this->request->name;
            $user->email = $this->request->email;
            $user->password = md5($this->request->password);
            $user->newsletterEnabled = !empty($this->request->newsletterEnabled) ? '1' : '0';
            $user->role = 'user';
            
            if (Config::get('emailConfirmationEnabled')) {
                $user->active = 0;
            }

            $user->save();

            if (Config::get('emailConfirmationEnabled')) {
                $this->set('message', 'The registration was successful! You must confirm your email. Check your inbox.');
                $verification = $this->verification->addVerification($user->userId, 'userEmail');
                $confirmLink = Config::get('siteRootUrl') . $this->moduleLink('confirmUserEmail/' . $verification->code, false);
                Mailer::getInstance()->sendEmailConfirmation('userEmail', $user->email, $confirmLink);
            } else {
                $this->set('message', _t('The registration was successful! You can login now.'));
            }

            $this->set('status', 'ok');

        } else {
            //something is wrong with webmasterData
            $this->set('status', 'error');
            $this->set('message', _t($errorMessage));
        }
    }
    
    public function confirmUserEmailAction($confirmCode)
    {
        $verification = $this->verification->findByCodeType($confirmCode, 'userEmail');

        if (!empty($verification)) {
            $user = $this->user->findByPk($verification->itemId);

            if (!empty($user)) {
                $user->active = 1;
                $user->save();
            }
        }
    }
}

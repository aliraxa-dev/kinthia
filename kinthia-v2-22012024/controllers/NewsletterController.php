<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class NewsletterController extends AppController
{
    public function indexAction()
    {
        if (!Config::get('newsletterEnabled')) {
            $this->return404();
        }
    }

    public function setEmailAction()
    {
        $this->viewClass = 'JsonView';

        if (!Config::get('newsletterEnabled')) {
            $this->return404();
        }

        $errorMessage = $this->newsletterEmail->validate($this->request);

        if ($errorMessage) {
            $this->set('status', 'error');
            $this->set('message', _t($errorMessage));
            return;
        }

        if (!empty($this->request->addEmail)) {
            $newsletterEmail = $this->newsletterEmail->addEmail($this->request->email);

            if ($newsletterEmail) {
                $verification = $this->verification->addVerification($newsletterEmail->emailId, 'newsletterEmailAdd');
                $confirmLink = Config::get('siteRootUrl') . $this->moduleLink('confirmNewsletterEmailAdd/' . $verification->code, false);
                Mailer::getInstance()->sendEmailConfirmation('newsletterEmailAdd', $this->request->email, $confirmLink);
            }

            $this->set('message', _t('Your email was added. Check your inbox to confirm it'));
        }

        if (!empty($this->request->deleteEmail)) {
            $c = new Criteria();
            $c->add('email', $this->request->email);
            $newsletterEmail = $this->newsletterEmail->find($c);

            if (!empty($newsletterEmail)) {
                $verification = $this->verification->addVerification(null, 'newsletterEmailDel', $newsletterEmail->email);
                $confirmLink = Config::get('siteRootUrl') . $this->moduleLink('confirmNewsletterEmailDel/' . $verification->code, false);
                Mailer::getInstance()->sendEmailConfirmation('newsletterEmailDel', $this->request->email, $confirmLink);
            }

            $this->set('message', _t('Check your inbox and click on remove link'));
        }

        $this->set('status', 'ok');
        $this->set('redirectUrl', Config::get('siteRootUrl'));
    }

    public function confirmNewsletterEmailAddAction($confirmCode)
    {
        if (!Config::get('newsletterEnabled')) {
            $this->return404();
        }

        $verification = $this->verification->findByCodeType($confirmCode, 'newsletterEmailAdd');

        if (!empty($verification)) {
            $newsletterEmail = $this->newsletterEmail->findByPk($verification->itemId);

            if (!empty($newsletterEmail)) {
                $newsletterEmail->active = 1;
                $newsletterEmail->save();
            }

            $verification->del();
        }
    }

    public function confirmNewsletterEmailDelAction($confirmCode)
    {
        $verification = $this->verification->findByCodeType($confirmCode, 'newsletterEmailDel');

        if (!empty($verification)) {
            $email = $verification->data;

            $c = new Criteria();
            $c->add('email', $email);
            $newsletterEmail = $this->newsletterEmail->find($c);

            if (!empty($newsletterEmail)) {
                $newsletterEmail->del();
            }
            
            $this->user->update(array('newsletterEnabled' => 0), $c);
            
            $verification->del();
        }
    }
}

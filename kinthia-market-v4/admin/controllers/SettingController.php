<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class Admin_SettingController extends AppController
{
    /**
     * set access privileges
     */
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }
    }

    /**
     * Display most of configuration options
     */
    public function indexAction()
    {
        $this->set('languageOptions', $this->getAvailableLanguages());
        $settings = $this->setting->getArray(null, 'value');

        $admin = $this->user->findByPk($this->userId, 'email');
        $settings['adminEmail'] = $admin->email;
        $this->set('settingJSON', JsonView::php2js($settings));

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    /**
     * Get available language in language dir
     */
    private function getAvailableLanguages()
    {
        $languages = array();
        $dir = new DirectoryIterator(CODE_ROOT_DIR . 'admin/languages/');

        foreach ($dir as $file) {
            //is language file
            if ($file->isDot() || !preg_match('#^(.*)\.php$#', $file->getFilename(), $matches)) {
                continue;
            }
            //get language code basing on file name
            $languageCode = $matches[1];
            $fp = fopen('languages/' . $file->getFilename(), 'r');
            $languageName = '';

            //read lines to get languageName
            while (!feof($fp) && !$languageName) {
                $line = fgets($fp);

                //check this line contain languageName variable
                if (preg_match('#languageName = \'(.*?)\';#', $line, $matches)) {
                    //if yes save it and push this language to array
                    $languageName = $matches[1];
                    $languages[$languageCode] = $languageName;
                }
            }

            fclose($fp);

        }

        //sort alphabetically array en => English with asort
        asort($languages);
        return $languages;
    }

    /**
     * Save main settings
     */
    public function saveAction()
    {
        if (empty($this->request->urlRewriting)) {
            $this->request->advancedUrlRewritingEnabled = '0';
        }

        //foreach posted setting save it to db
        foreach ($this->request as $key => $value) {
            //if admin email changed
            if ($key == 'adminEmail') {
                $this->user->updateByPk(array(
                'email' => $value), $this->userId);
            }

            $this->setting->set($key, $value);
            Config::set($key, $value);
        }

        $cache = Cacher::getInstance();
        $cache->clean('all');

        $this->redirect($this->moduleLink());
    }

    /**
     * Save edited customMessage
     */
    public function saveEditMessageAction()
    {
        $keyId = $this->request->get('messageId');
        $fields = array('title', 'description');

        if (!empty($this->request->userText)) {
            $fields[] = 'userText';
        }

        $data = $this->request->getArray($fields);
        $this->customMessage->updateByPk($data, $keyId);

        if (in_array($keyId, array('directoryDescription', 'directoryCondition'))) {
            Cacher::getInstance()->delete($keyId);
        }

        $this->redirect($this->moduleLink('email'));
    }

    /**
     * Show forms to edit custom emails
     */
    public function emailAction()
    {
        $c = new Criteria();
        $c->add('type', 'email');
        $this->set('emails', $this->customMessage->findAll($c));

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function editEmailAction($messageId)
    {
        $message = $this->customMessage->findByPk($messageId);
        $this->set('message', $message);

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function deleteEmailAction($messageId)
    {
        $c = new Criteria();
        $c->add('messageId', $messageId);
        $c->add('userDefined', '1');
        $this->customMessage->del($c);

        $this->redirect($this->moduleLink('email'));
    }

    public function saveNewEmailAction()
    {
        $message = new CustomMessageRecord();
        $message->fromArray($this->request->getArray(array('title', 'description', 'userText')));
        $message->messageId = substr('own' . md5(rand()), 0, 20);
        $message->save();

        $this->redirect($this->moduleLink('email'));
    }

    public function skillAction()
    {
        $this->set('paymentProcessors', $this->paymentProcessor->findAll());

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function editSkillAction()
    {
        $this->set('paymentProcessors', $this->paymentProcessor->findAll());

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    /**
     * Show form to edit custom directoryDescription
     */
    public function descriptionAction()
    {
        $this->set('message', $this->customMessage->findByPk('directoryDescription'));
    }

    /**
     * Show form to edit custom directoryCondition
     */
    public function conditionAction()
    {
        $this->set('message', $this->customMessage->findByPk('directoryCondition'));
    }

    public function paymentProcessorAction()
    {
        $this->set('paymentProcessors', $this->paymentProcessor->findAll());

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function editPaymentProcessorAction($processorId)
    {
        $paymentProcessor = $this->paymentProcessor->findByPk($processorId);
        $this->set('paymentProcessor', $paymentProcessor);
        $this->set('paymentProcessorJson', JsonView::php2js($paymentProcessor));

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function savePaymentProcessorAction()
    {
        $processorId = $this->request->processorId;
        $fields = array('displayName', 'enabled', 'currency');

        if ($processorId == 'PayPal') {
            $fields = array_merge($fields, array('email', 'testMode'));
        }

        if ($processorId == "Stripe") {
            $fields = array_merge($fields, array('stripePublicKey', 'stripePrivateKey'));
        }

        $data = $this->request->getArray($fields);

        $paymentProcessor = $this->paymentProcessor->findByPk($processorId);
        $paymentProcessor->fromArray($data);
        $paymentProcessor->save();

        $this->redirect($this->moduleLink('paymentProcessor'));
    }

    public function sendTestEmailAction($messageId)
    {
        $c = new Criteria();
        $c->addOrder('RAND()');
        $c->setLimit(1);

        $site = $this->site->find($c);

        if ($site) {
            $mailer = Mailer::getInstance();
            $adminEmail = $mailer->getAdminEmail();
            $confirmLink = Config::get('siteRootUrl') . $this->moduleLink('confirmSiteEmail/testcode', false);

            switch ($messageId) {
                case 'submitSite':
                    $mailer->sendAdminNotification($site);
                    break;

                case 'webmasterSubmitSite':
                    $mailer->sendWebmasterNotification($site, $adminEmail);
                    break;

                case 'validateSite':
                    $site->status = 'validated';
                    $mailer->sendSiteStateUpdate($adminEmail, $site);
                    break;

                case 'refuseSite':
                    $site->status = 'refused';
                    $mailer->sendSiteStateUpdate($adminEmail, $site);
                    break;

                case 'newsletterEmailAdd':
                case 'newsletterEmailDel':
                case 'siteEmail':
                case 'userEmail':
                    $mailer->sendEmailConfirmation($messageId, $adminEmail, $confirmLink);
                    break;

                default:

                    $message = $this->customMessage->findByPk($messageId);

                    if ($message) {
                        $site->status = 'validated';
                        $mailer->sendSiteStateUpdate($adminEmail, $site, $message->title, $message->description);
                    }
            }
        }

        $this->redirect($this->moduleLink('email'));
    }

}

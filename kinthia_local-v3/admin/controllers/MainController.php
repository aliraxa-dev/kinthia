<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_MainController extends AppController
{
    /**
    * set access privileges
    */
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');
        $this->acl->allow('guest', $this->name, 'logIn');
        $this->acl->allow('guest', $this->name, 'lostPassword');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }
    }

    /**
    * Display admin index page
    */
    public function indexAction()
    {
        require(CODE_ROOT_DIR.'config/version.php');

        $c = new Criteria();
        $c->add('role', 'user');
        $curentdate=date('Y-m');
        // die(print_r($curentdate));


        $this->set('statistic', array(
            'currentMonth'  => date('F Y'),
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'usersCount'             => $this->user->getCount($c),
            'answeredQuestionsCount' => $this->statistic->getCountOfQuestionsWithStatus('answered'),
            'getCurrentCountOfQuestionsWithStatus' => $this->statistic->getCurrentCountOfQuestionsWithStatus('answered',$curentdate),

            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending'),
            'totaltimeonPhone'  => $this->statistic->getTotalTime('phone'),
            'totaltimeonWebcam'  => $this->statistic->getTotalTime('webcam'),
            'totaltimeonChat'  => $this->statistic->getTotalTime('chat'),
            'databaseSize'           => $this->database->getTotalSize(),
            'getVoyantQuestionsTotalEarningAllVoyant' => $this->statistic->getVoyantQuestionsTotalEarningAllVoyant(),
             'getTotalEarningAllOnPhone'  => $this->statistic->getTotalEarningAll('phone'),
            'getTotalEarningAllOnWebcam'  => $this->statistic->getTotalEarningAll('webcam'),

            'getVoyantQuestionsTotalEarningCompany' => $this->statistic->getVoyantQuestionsTotalEarningCompany(),
            'getTotalEarningCompanyOnPhone'  => $this->statistic->getTotalEarningAll('phone'),
            'getTotalEarningCompanyOnWebcam'  => $this->statistic->getTotalEarningAll('webcam'),



            'getAllConsultationtimeCurrentmonthOnPhone'  => $this->statistic->getAllConsultationtimeCurrentmonth('phone',$curentdate),
            'getAllConsultationtimeCurrentmonthOnWebcam'  => $this->statistic->getAllConsultationtimeCurrentmonth('webcam',$curentdate),
            'getAllConsultationtimeCurrentmonthOnChat'  => $this->statistic->getAllConsultationtimeCurrentmonth('chat',$curentdate),

            'getAllVoyantQuestionsTotalEarningCurrentmonth'  => $this->statistic-> getAllVoyantQuestionsTotalEarningCurrentmonth($curentdate),

            'totalAllEarningCurrentmonthOnPhone'  => $this->statistic->totalAllEarningCurrentmonth('phone',$curentdate),

            'totalAllEarningCurrentmonthOnWebcam'  => $this->statistic->totalAllEarningCurrentmonth('webcam',$curentdate),

            'totalAllEarningCurrentmonthOnChat'  => $this->statistic->totalAllEarningCurrentmonth('chat',$curentdate),


            'getCompanyQuestionsTotalEarningCurrentmonth'  => $this->statistic->getCompanyQuestionsTotalEarningCurrentmonth($curentdate),
            'totalCompanyEarningCurrentmonthOnPhone'  => $this->statistic->totalAllEarningCurrentmonth('phone',$curentdate),
            'totalCompanyEarningCurrentmonthOnWebcam'  => $this->statistic->totalAllEarningCurrentmonth('webcam',$curentdate),
            'totalCompanyEarningCurrentmonthOnChat'  => $this->statistic->totalAllEarningCurrentmonth('chat',$curentdate),



        ));
    }

    /**
    * Display login form and login admin
    */
    public function logInAction()
    {
        if (isset($this->request->login) && isset($this->request->password)) {
            if ($this->session->loginUser($this->request->login,
                                          md5($this->request->password),
                                          'login',
                                          'administrator')) {
                $this->redirect($this->moduleLink('index'));
            } else {
                $this->set('loginError', 1);
            }
        }
    }

    /**
    * Logout admin
    */
    public function logOutAction()
    {
        $this->session->destroy();
        $this->redirect($this->moduleLink());
    }

    /**
    * Display lost password form and send it to user email
    */
    public function lostPasswordAction()
    {
        //if no posta data only display form
        if (empty($this->request->email)) {
            return;
        }

        //search that email is correct
        $c = new Criteria();
        $c->add('email', $this->request->email);
        $c->add('role', 'administrator');
        $user = $this->user->find($c);

        if (empty($user)) {
            return;
        }

        //generate and send new password
        $newPassword = $user->generateNewPassword();

        Mailer::getInstance()->sendLostPassword($user->email, $newPassword);

        $this->redirect($this->moduleLink('logIn'));
    }

    /**
    * Clear directory for make data fresh
    */
    private function clearDir($path)
    {
        $iterator = new RecursiveIteratorIterator(
                        new RecursiveDirectoryIterator($path),
                        RecursiveIteratorIterator::CHILD_FIRST);

        foreach($iterator as $file) {
            if (basename($file->getFilename()) == ".htaccess" || basename($file->getFilename()) == "." || basename($file->getFilename()) == "..")
			{
                continue;
            }

            if ($file->isDir()) {
                rmdir($file->getPathname());
            } else {
                unlink($file->getPathname());
            }
        }
    }

    /**
    * Clear actions
    */
    public function clearAction()
    {
        $cmd = '';

        foreach (array('fileCache') as $opt) {
            if (!empty($this->request[$opt])) {
                $cmd = $opt;
            }
        }

        switch ($cmd) {
            case 'fileCache':
                $cache = Cacher::getInstance();
                $cache->clean('all');
                $this->clearDir(CODE_ROOT_DIR."compiled/");
                break;
        }

        $this->redirect($this->moduleLink());
    }
}

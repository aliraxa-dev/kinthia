<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_UserController extends AppController
{
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }

        $this->set("action",$this->action);
        $c = new Criteria();
        $c->add('packageDisplay', 1);
        $c->add('packagePromo', 1);
        $packages = Model::factoryInstance("package")->findAll($c);
        $promoPacks = [];
        if(isset($packages) && !empty($packages)){
             foreach ($packages as $key => $package) {
                $promoPacks[] = strip_tags(substr($package['packagePromoMsg'],0,15));
            }
        }
        $allPromoPackages = implode("&nbsp;&nbsp;", $promoPacks);
        $this->set('allPromoPackages', $allPromoPackages);
    }

    public function indexAction()
    {

    }

    public function userReviewAction($page = 1)
    {
        $c = new Criteria();
       // $c->add("validated",1,'!=');
        $c->addOrder("commentId DESC");

        //set pagination
        $perPage = 50;
        $totalCount = $this->statistic->getCountAllReview();
        $totalPages = ceil($totalCount / $perPage);

        $this->set('pageNavigation', array('baseLink' => '/admin/user/userReview/',
                                           'totalPages' => $totalPages,
                                           'currentPage' => $page));

        $c->setPagination($page, $perPage);
        $this->set('commentsCount', $totalCount);

        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $comments = $this->voyantComment->findAll($c,"*",true);
        // echo "<pre>";
        // print_r($comments);
        // die();
        $this->set('comments', $comments);
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

    public function saveNewAdminPasswordAction()
    {
        if (!empty($this->request->newPassword)
            && $this->request->newPassword == $this->request->repeatedNewPassword
        ) {
            $c = new Criteria();
            $c->add('role', 'administrator');
            $this->user->update(array('password' => md5($this->request->newPassword)), $c);
        }

        $this->redirect($this->moduleLink());
    }

    public function userAction($page = 1)
    {
        $c = new Criteria();
        $c->add('role', 'user');
        if (isset($this->request->email)) {
        	$c2 = new Criteria();
            $c2->add('email', '%' . $this->request->email . '%', 'LIKE');
            $c2->addOr('name', '%' . $this->request->email . '%', 'LIKE');
            $c->add($c2);
        }

        //set pagination
        $perPage = 50;
        $totalCount = $this->user->getCount($c);
        $totalPages = ceil($totalCount / $perPage);

        $this->set('pageNavigation', array('baseLink' => '/admin/user/user/',
                                           'totalPages' => $totalPages,
                                           'currentPage' => $page));

        $c->setPagination($page, $perPage);
        $this->set('usersCount', $totalCount);

        $userQuestionsCriteria = new Criteria();
        $userQuestionsCriteria->addGroup('userId');
        $c->addWithRelation('userQuestions', array('fields' => 'userId, count(*) as boughtCount','criteria' => $userQuestionsCriteria));


        $users = $this->user->findAll($c, 'users.userId, login, email, name');
    foreach($users as $user){
      $userId = $user['userId'];
      $rem_time = $this->statistic->getRemainingtime($userId);
      $tot_time = $this->statistic->getTotaltimesuser($userId);
      $vdo_usedtime = $this->statistic->getUserConsulttime($userId,'webcam');
      $phone_usedtime = $this->statistic->getUserConsulttime($userId,'phone');
      $chat_usedtime = $this->statistic->getUserConsulttime($userId,'chat');
      if($rem_time){
       $user['rem_time'] = $rem_time;
       $user['tot_time'] = $tot_time;
       $user['vdo_usedtime'] = $vdo_usedtime;
       $user['phone_usedtime'] = $phone_usedtime;
       $user['chat_usedtime'] = $chat_usedtime;
   }else{
    $user['rem_time'] ='00h 00m 00s';
    $user['tot_time'] ='00h 00m 00s';
    $user['vdo_usedtime'] = '00h 00m 00s';
    $user['phone_usedtime'] = '00h 00m 00s';
    $user['chat_usedtime'] = '00h 00m 00s';
   }
      $users2[] =$user;
    }


        $this->set('users', $users2);


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


    public function banIpAction()
    {
        $this->set('bannedIps', $this->bannedIp->getArray(null, 'remoteIP'));

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

    public function saveNewIpBanAction()
    {
        $bannedIps = preg_split("#\r?\n#", $this->request->bannedIps);

        foreach ($bannedIps as $ip) {
            $ip = trim($ip);
            if (empty($ip)) {
                continue;
            }

            $bannedIp = new BannedIpRecord();
            $bannedIp->remoteIp= $ip;
            $bannedIp->save();
        }

        $this->redirect($this->moduleLink('banIp'));
    }

    public function deleteIpBanAction()
    {
        if (!empty($this->request->unbanIps)) {
            $c = new Criteria();
            $c->add('banId', $this->request->unbanIps, 'IN');
            $this->bannedIp->del($c);
        }

        $this->redirect($this->moduleLink('banIp'));
    }

    public function banEmailAction()
    {
        $this->set('bannedEmails', $this->bannedEmail->getArray(null, 'email'));

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

    public function saveNewEmailBanAction()
    {
        $bannedEmails = preg_split("#\r?\n#", $this->request->bannedEmails);
        foreach ($bannedEmails as $email) {
            $email = trim($email);
            if (empty($email)) {
                continue;
            }

            $bannedEmail = new BannedEmailRecord();
            $bannedEmail->email = $email;
            $bannedEmail->save();
        }

        $this->redirect($this->moduleLink('banEmail'));
    }

    public function deleteEmailBanAction()
    {
        if (!empty($this->request->unbanEmails)) {
            $c = new Criteria();
            $c->add('banId', $this->request->unbanEmails, 'IN');
            $this->bannedEmail->del($c);
        }

        $this->redirect($this->moduleLink('banEmail'));
    }

    public function newsletterAction()
    {
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

    public function editUserAction($userId)
    {
        $user = $this->user->getUserDetails($userId);
               $rem_time = $this->statistic->getRemainingtime($userId);
      $tot_time = $this->statistic->getTotaltimesuser($userId);
      $vdo_usedtime = $this->statistic->getUserConsulttime($userId,'webcam');
      $phone_usedtime = $this->statistic->getUserConsulttime($userId,'phone');
        $chat_usedtime = $this->statistic->getUserConsulttime($userId,'chat');
            $voyantcount  =$this->statistic->getVoyantCount($userId);
          if($tot_time){
           $user['rem_time'] = $rem_time;
           $user['tot_time'] = $tot_time;
           $user['vdo_usedtime'] = $vdo_usedtime;
           $user['phone_usedtime'] = $phone_usedtime;
              $user['chat_usedtime'] = $chat_usedtime;
           $user['voyantcount'] = $voyantcount;
           $user['packageBuyCount'] = count($user->userPackages);
           $user['questionCount'] = count($user->userQuestions);
           }else{
            $user['rem_time'] ='00h 00m 00s';
            $user['tot_time'] ='00h 00m 00s';
            $user['vdo_usedtime'] = '00h 00m 00s';
            $user['phone_usedtime'] = '00h 00m 00s';
            $user['chat_usedtime'] = '00h 00m 00s';
             $user['voyantcount'] = 0;
           $user['packageBuyCount'] = 0;
           $user['questionCount'] = 0;
           }
          /* echo "<pre>";
           print_r($user);
           die();*/
        $user->itemId = $user->userId;
        $this->user->attachPhotos($user);

        $this->set('user', $user);
        $this->set('userJson', JsonView::php2js($user));

        //user private messages...
        $c = new Criteria();
        $c->addGroup("voyantmessages.userId,voyantmessages.voyantId");
        $c->addOrder("messageId DESC");

        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $voyantmessages = $this->voyantMessage->findAll($c,"max(voyantmessages.date) as date,voyantmessages.userId,voyantmessages.voyantId",true);
        $this->set('userId' , $userId);
        $this->set('voyantmessages',$voyantmessages);
       /* echo "<pre>";
        print_r($user);
        die();
*/
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

    public function deleteUserAction($userId)
    {
        $this->user->delByPk($userId);
        $this->redirect($this->moduleLink('user'));
    }

    public function saveUserAction()
    {
        $user = $this->user->findByPk($this->request->userId);
        $fields = array('name', 'firstName', 'lastName', 'birthdayDate', 'newsletterEnabled', 'email');
        $user->fromArray($this->request->getArray($fields));
        $user->save();

        $this->redirect($this->moduleLink('user'));
    }

    public function newsletterEmailAction()
    {
        $c = new Criteria();
        $c->add('active', '1');
        $this->set('newsletterEmailsCount', $this->newsletterEmail->getCount($c));

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

    public function importNewsletterEmailAction()
    {
        $csvFile = new UploadedFile('csvFile');
        if (!$csvFile->check()) {
            return;
        }

        $fileName = $csvFile->getTempName();
        $buff = file_get_contents($fileName);

        $this->newsletterEmail->del(new Criteria());

        foreach (preg_split("#[\r\n]+#", $buff) as $email) {
            $email = trim($email);
            if (empty($email)) {
                continue;
            }

            $newsletterEmail = new NewsletterEmailRecord();
            $newsletterEmail->email = $email;
            $newsletterEmail->active = '1';
            $newsletterEmail->save();
        }

        $this->redirect($this->moduleLink('newsletterEmail'));
    }

    public function exportNewsletterEmailAction()
    {
        $c = new Criteria();
        $c->add('active', '1');

        $emails = array();
        $newsletterEmails = $this->newsletterEmail->findAll($c, 'email');

        foreach ($newsletterEmails as $newsletterEmail) {
            $emails[] = $newsletterEmail['email'];
        }

        $emails = array_unique($emails);
        $content = implode("\r\n", $emails) . "\r\n";

        $this->autoRender = false;
        $fileName = 'newsletter-emails-' . date('Y-m-d') . '.csv';
        header('Content-type: application/octet-stream');
        header('Content-Disposition: attachment; filename=\'' . $fileName . '\'');
        header('Content-length: ' . strlen($content));
        echo $content;
    }

    public function reportExpertAction()
    {
          //Report list  Fetch  from  database


        $c = new Criteria();
        $c->addOrder("id DESC");
        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $allVoyantReports = $this->voyantReport->findAll($c);

        $this->set('allVoyantReports',$allVoyantReports);




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
    public function deleteReportAction($id)
     {
        $voyantReportId = $this->voyantReport->findByPk($id);

        if($voyantReportId){
            //Delete Voyant report...
             $c = new Criteria();
             $c->add('id', $id);
             Model::factoryInstance('voyantReport')->del($c);
        }
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/user/reportExpert/');
        $this->redirect($redirectUrl);
    }
}

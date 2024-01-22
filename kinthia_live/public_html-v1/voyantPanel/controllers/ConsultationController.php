<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_ConsultationController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction($requestId)
    {
        $c = new Criteria();
        $c->add('userconsultationId', $requestId);
        $userRequests = $this->userConsultation->find($c);

        if($userRequests['status']=='C' || $userRequests['status']=='A' || $userRequests['status']=='VA' || $userRequests['status']=='E') {
           $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/main')); 
        }

        $data = ['status'=>'VA'];
        $this->userConsultation->updateByPk($data, $requestId);

        $voyant = $this->voyant->findByPk($this->userId);
        // $userdata = ['name'=>$voyant['name'],'id'=>$voyant['voyantId'],'type'=>'V','room'=>'room-'.$userRequests['userId'].'-'.$voyant['voyantId'],'requestId'=>$userRequests['userconsultationId'],'userrequestId'=>$userRequests['userId'],'consultationType'=>$userRequests['type']];
        $userdata = ['name'=>$voyant['name'],'id'=>$voyant['voyantId'],'type'=>'V','room'=>'room-'.$userRequests['userId'].'-'.$voyant['voyantId'],'requestId'=>$userRequests['userconsultationId'],'userrequestId'=>$userRequests['userId'],'consultationType'=>$userRequests['type'],'status'=>'VA'];
        
        /**
        * set statistic
        */
        $this->set('voyant',$voyant);
        $this->set('userdata',json_encode($userdata));
        $this->set('userRequests',$userRequests);
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function incomingCallAction($requestId)
    {
        /**
        * set statistic
        */
        $c = new Criteria();
        $c->add('voyantId', $this->userId);
        $c->add('status', 'P');
        $c->add('userconsultationId',$requestId);
        $c->addWithRelation('user', array('fields' => 'name'));
        $pendingRequests = $this->userConsultation->find($c);
        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/consultation/index/'.$pendingRequests['userconsultationId']);
        $cancelUrl = AppRouter::getRewrittedUrl('/voyantPanel/consultation/checkcancel/'.$pendingRequests['userconsultationId']);
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('pendingRequests', $pendingRequests);
        $this->set('redirectUrl',$redirectUrl);
        $this->set('cancelUrl',$cancelUrl);
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function endedAction($requestId)
    {
        $c = new Criteria();
        $c->add('userconsultationId',$requestId);
        $c->addWithRelation('user', array('fields' => 'name'));
        $consultation = $this->userConsultation->find($c);

        $data = ['consultationStatus'=>'ON','consultationTime'=>NULL];
        $this->voyant->updateByPk($data, $this->userId);
        /**
        * set statistic
        */
        $this->set('consultation', $consultation);
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    //Get User Pending Request from DB...
    public function userConsultationRequestAction(){
        $c = new Criteria();
        $c->add('voyantId', $this->userId);
        $c->add('consultationDate', date("Y-m-d"));
        $c->add('userRequestStatus', 'P');
        $pendingRequests = $this->userConsultation->find($c)->toArray();
        //$this->set('pendingRequests',$pendingRequests);
        //echo "<pre>";print_r(json_encode($pendingRequests));die;
        echo json_encode($pendingRequests);exit;  
    }

    public function checkCancelAction($requestId) {
        
        $this->viewClass = 'JsonView';
        $c = new Criteria();
        $c->add('status', 'P');
        $c->add('voyantId', $this->userId);
        $c->add('userconsultationId',$requestId);
        $count = $this->userConsultation->getCount($c);
        $this->set('status','success');
        $this->set('count',$count);
    }

    public function consultationAction()
    {

        $this->set('voyant', $this->voyant->findByPk($this->userId));
        /**
        * set statistic
        */
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function consultationQAction()
    {
        
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        /**
        * set statistic
        */
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

}

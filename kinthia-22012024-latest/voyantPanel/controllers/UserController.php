<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_UserController extends AppController
{
    /**
    * set access privileges
    */
    public function init()
    {
        $this->acl->allow('voyant', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/main/logIn'));
        }
    }

    public function indexAction()
    {
        $users = $this->voyant->getVoyantTotalUsers($this->userId);
       /*  echo "<pre>";
         print_r($users);
         die();*/
        foreach ($users as $user) {
            $voyantId = $this->userId;
            $userId = $user['userId'];

            $user['phoneCount'] = $this->statistic->getConsultationcountBetween($voyantId,$userId,'phone');
            $user['webcamCount'] = $this->statistic->getConsultationcountBetween($voyantId,$userId,'webcam');
            $user['chatCount'] = $this->statistic->getConsultationcountBetween($voyantId,$userId,'chat');
            $items2[] =$user;
        }
        $users = $items2;

        $this->set('users', $users);
        $this->set('usersCount', count($users));

        /**
        * set statistic
        */
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function showAction($userId)
    {
        /*echo "<pre>";
        print_r($this->userId);
        die();*/
        $c = new Criteria();
        $c->add('userId', $userId);
        $c->add('voyantId', $this->userId);

        if (!$this->order->getCount($c)) {
            //$this->return404();
        }

        $user = $this->user->getUserDetails($userId);
        $user->itemId = $user->userId;
        $this->user->attachPhotos($user, array('attachOriginalPhotos' => true));

        $user->addOrder('userQuestions.orderId'); //set order
        $user->addOrder('userPackages.orderId'); //set order
        $this->set('users', $this->voyant->getVoyantUsers($this->userId));
        $this->set('voyantId', $this->userId);
        $this->set('user', $user);

        $voyant = $this->voyant->findByPk($this->userId);
        $this->set('paymentExpertPlatform', $voyant->paymentExpertPlatform);


        //For Consultations...
        $userConsultaions = [];
        $c = new Criteria();
        $c->add('userId', $userId);
        $c->add('status', 'E');
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);
        if(isset($consultations) && !empty($consultations)){
            $userConsultaions = $this->getConsultationsDetails($consultations);
        }

        $this->set('userConsultaions', $userConsultaions);

        //Private Messages...
        $c = new Criteria();
        $c->add("voyantId",$this->userId);
        $c->add("userId",$userId);
        $c->addOrder("messageId DESC");
        $voyantmessages = $this->voyantMessage->findAll($c,"*",true);
        $this->set('voyantmessages',$voyantmessages);

        /**
        * set statistic
        */
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function getConsultationsDetails($consultaionsDetail){
        $consultationData = [];
        if(isset($consultaionsDetail) && !empty($consultaionsDetail)){
            foreach($consultaionsDetail as $consult){
                    $consultationCost = 0;
                    if(!empty($consult['duration'])){

                        $durTime = $consult['duration'];
                        $duration = strtotime("1970-01-01 $durTime UTC");
                        $durationMinutes = $consult['duration'];

                    }else{

                        if(!empty($consult['start_time']) && !empty($consult['end_time'])){

                            $start_date = new DateTime($consult['start_time']);
                            $since_start = $start_date->diff(new DateTime($consult['end_time']));

                            if($since_start->h < 10){
                                $hourNumbers = "0".$since_start->h;
                            }

                            if($since_start->i < 10){
                                $minuteNumbers = "0".$since_start->i;
                            }else{
                                $minuteNumbers = $since_start->i;
                            }

                            if($since_start->s < 10){
                                $secndNumbers = "0".$since_start->s;
                            }else if($since_start->s > 9){
                                $secndNumbers = $since_start->s;
                            }else{
                                $secndNumbers = 00;
                            }

                            $durationMinutes = $hourNumbers.':'.$minuteNumbers.":".$secndNumbers;
                            $duration = strtotime("1970-01-01 $durationMinutes UTC");
                        }
                    }

                    $consultationData[] = array(
                        "userconsultationId" =>$consult['userconsultationId'],
                        "voyantId" => $consult['voyantId'],
                        "userId" => $consult['userId'],
                        "status" => $consult['status'],
                        "invoiceId" => rand ( 10000 , 99999 ),
                        "voyantName" => $consult['name'],
                        "voyantEmail" => $consult['email'],
                        "date" => $consult['date'],
                        "created_at" => $consult['created_at'],
                        "type" => $consult['type'],
                        "duration" => $duration,
                        "durationMinutes" => $durationMinutes,
                        "paidBackPhone" => $consult['paidBackPhone'],
                        "paidBackWebcam" => $consult['paidBackWebcam']
                    );
            }
            return $consultationData;
        }
    }
}

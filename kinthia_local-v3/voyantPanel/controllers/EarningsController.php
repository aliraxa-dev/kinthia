<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_EarningsController extends AppController
{
    /**
    * set access privileges
    */

    public function indexAction()
    {

       $earning['totalEarningPhone'] = $this->getTotalEarning('phone',$this->userId);
       $earning['totalEarningWebcam'] = $this->getTotalEarning('webcam',$this->userId);
         $earning['totalEarningChat'] = $this->getTotalEarning('chat',$this->userId);
        $earning['totalEarningWebcamCurrentmonth'] = $this->totalEarningWebcamCurrentmonth('webcam',date('Y-m'),$this->userId);
        $earning['totalEarningphoneCurrentmonth'] = $this->totalEarningWebcamCurrentmonth('phone',date('Y-m'),$this->userId);
        $earning['totalEarningchatCurrentmonth'] = $this->totalEarningWebcamCurrentmonth('chat',date('Y-m'),$this->userId);
        $earning['phonetimeCurrentmonth'] = $this->getConsultationtimeCurrentmonth('phone',date('Y-m'),$this->userId);
        $earning['webcamtimeCurrentmonth'] = $this->getConsultationtimeCurrentmonth('webcam',date('Y-m'),$this->userId);
        $earning['chattimeCurrentmonth'] = $this->getConsultationtimeCurrentmonth('chat',date('Y-m'),$this->userId);
      /*  echo "<pre>";
        print_r($earning);
        die();*/
        $this->set('earning', $earning);

        /**
        * set statistic
        */

        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'answeredQuestionsCountCurrentMonth' => $this->statistic->getVoyantQuestionsCountCurrentMonth($this->userId, date('Y-m')),
            'answeredQuestionsEarning' => $this->statistic->getVoyantQuestionsTotalEarning($this->userId),
            'getVoyantQuestionsTotalEarningCurrentmonth' => $this->statistic->getVoyantQuestionsTotalEarningCurrentmonth($this->userId,date('Y-m')),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId,date('Y-m')),

            'phone_usedtime'  => $this->statistic->getConsultationtime($this->userId,'phone'),
            'video_usedtime'  => $this->statistic->getConsultationtime($this->userId,'webcam'),
            'chat_usedtime'  => $this->statistic->getConsultationtime($this->userId,'chat'),
            'currentMonth'  => date('F Y')
        ));
    }
    public function getTotalEarning($type,$voyantId){
         //For Consultations Earnings...

        $userConsultaions = [];
        $duration = [];
        $c = new Criteria();
        $c->add('type', $type);
        $c->add('status', 'E');
        $c->add('userconsultations.voyantId', $voyantId);
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);

        if(isset($consultations) && !empty($consultations)){
            $userConsultaions = $this->getConsultationsDetails($consultations);
            foreach($userConsultaions as $userConsultaion) {
                $duration[] = $userConsultaion['duration'];
            }
        }
        if(isset($duration)){
         $totalEarning = array_sum($duration);
     }else{
        $totalEarning = 0;
     }

        return $totalEarning;
    }
        public function totalEarningWebcamCurrentmonth($type,$year,$voyantId){
         //For Consultations Earnings...
        $userConsultaions = [];
        $duration = [];
        $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
        $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
        $c = new Criteria();
        $c->add('type', $type);
        $c->add('status', 'E');
        $c->add('userconsultations.voyantId', $voyantId);
        $c->addOrder("date DESC");
        $c->add('date', $lastDateOfyear , "<=");
        $c->add('date', $firstDateOfyear , ">=");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);
        if(isset($consultations) && !empty($consultations)){
            $userConsultaions = $this->getConsultationsDetails($consultations);
            foreach($userConsultaions as $userConsultaion) {
                $duration[] = $userConsultaion['duration'];
            }
        }
        $totalEarning = array_sum($duration);
        return $totalEarning;
    }
            public function getConsultationtimeCurrentmonth($type,$year,$voyantId){
                $usedTime = 0;
                $e = new Criteria();
                $e->add('voyantId',$voyantId);
                $e->add('status', 'E');
                $e->add('type', $type);
                $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
                $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
                $e->add('date', $lastDateOfyear , "<=");
                $e->add('date', $firstDateOfyear , ">=");
                $userconsultation = $this->userConsultation->findAll($e);
                  if($userconsultation) {
                    foreach($userconsultation as $c_key=>$user_value) {
                        if($user_value['duration']!=NULL) {
                          $time = explode(':', $user_value['duration']);
                          $usedTime+= ($time[0]*60) + ($time[1]) + ($time[2]/60);
                        } else {
                          if($user_value['start_time']!=NULL && $user_value['end_time']!=NULL)
                          {
                            $datetime1 = new DateTime($user_value['start_time']);
                            $datetime2 = new DateTime($user_value['end_time']);
                            $interval = $datetime1->diff($datetime2);
                            $user_value['duration'] = $interval->format('%H:%I:%S');
                            $time = explode(':', $user_value['duration']);
                            $usedTime+= ($time[0]*60) + ($time[1]) + ($time[2]/60);
                          }
                        }
                    }
                }

                $totalTime = $usedTime;
                $totTime = 0;


                    $hours = floor($totalTime / 60);
                    $min = $totalTime - ($hours * 60);
                    $seconds = $totalTime - ($min*60);
                    $init = $totalTime*60; // convert min. into seconds
                    $hours = floor($init / 3600);
                    $minutes = floor(($init / 60) % 60);
                    $seconds = $init % 60;
                    $hours = ($hours ? ($hours > 9 ? $hours : "0" . $hours) : "00");
                    $minutes = ($minutes ? ($minutes > 9 ? $minutes : "0" . $minutes) : "00");
                    $seconds = ($seconds ? ($seconds > 9 ? $seconds : "0" . $seconds) : "00");
                    $totTime = $hours."h ".$minutes."m ".$seconds."s";


               return $totTime;


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

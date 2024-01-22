<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class StatisticModel extends Model
{         
    
    function __construct()
    {
        $this->cache = Cacher::getInstance();
    }
    
    function getCountOfQuestionsWithStatus($type)
    {
        $c = new Criteria();
        $c->add("status", $type);
        return $this->userQuestion->getCount($c);
    }


    function getCurrentCountOfQuestionsWithStatus($type,$current)
    {
        $c = new Criteria();
        $c->add("status", $type);
        $c->add('creationDate', '%'.$current.'%', 'LIKE');
       
        return $this->userQuestion->getCount($c);
    }
    
    function getCountOfUsersWithRole($role)
    {
        if(($data = $this->cache->load("usersWithRole".ucfirst($role))) === null)
        {
            $c = new Criteria();
            $c->add("role", $role);
            $data = $this->user->getCount($c); 
            $this->cache->save($data, null, null, array("user")); 
        }
         
        return $data;
    }
    
    function getVoyantUsersCount($voyantId)
    {
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        return $this->userQuestion->get("COUNT(DISTINCT userId)", $c);    
    }
    function getVoyantTotalUsersCount($voyantId)
    {
        $voyantTotalusers = $this->voyant->getVoyantTotalUsers($voyantId);
        return count($voyantTotalusers);    
    }
    
    function getVoyantQuestionsCountWithStatus($voyantId, $status)
    {
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add("status", $status);
        return $this->userQuestion->getCount($c);    
    }
      function getVoyantQuestionsTotalEarning($voyantId)
    {  
         
        $c = new Criteria();
        $c->add("userQuestions.voyantId", $voyantId);
        $price = $this->userQuestion->getEarning($c); 
      
        $earning = array_sum($price);   
        return $earning;
    }
    function getVoyantQuestionsTotalEarningAllVoyant()
    {
        $c = new Criteria();
        //$c->add("userQuestions.voyantId", $voyantId);
        $price = $this->userQuestion->getEarning($c); 
        $earning = array_sum($price);  
        // die(print_r($price)); 
        return $earning;
    }


    function getVoyantQuestionsTotalEarningCompany()
    {
        $c = new Criteria();
     
        $price = $this->userQuestion->getEarning($c); 
        $earning = array_sum($price);  
        // die(print_r($price)); 
        return $earning;
    }



        function getVoyantQuestionsCountCurrentMonth($voyantId,$year)
    {
         $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
        $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add('creationDate', $lastDateOfyear , "<=");
        $c->add('creationDate', $firstDateOfyear , ">=");
        $c->add("status", 'answered');
        
         return $this->userQuestion->getCount($c);
        
    }
        function getVoyantQuestionsTotalEarningCurrentmonth($voyantId,$year)
    {
         $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
        $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
        $c = new Criteria();
        $c->add("userQuestions.voyantId", $voyantId);
        $c->add('userQuestions.creationDate', $lastDateOfyear , "<=");
        $c->add('userQuestions.creationDate', $firstDateOfyear , ">=");

        $price = $this->userQuestion->getEarning($c); 
        $earning = array_sum($price);   
        return $earning;
    }
    

    function getCompanyQuestionsTotalEarningCurrentmonth($year)
    {
         $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
        $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
        $c = new Criteria();
      
        $c->add('userQuestions.creationDate', $lastDateOfyear , "<=");
        $c->add('userQuestions.creationDate', $firstDateOfyear , ">=");

        $price = $this->userQuestion->getEarning($c); 
        $earning = array_sum($price);   
        return $earning;
    }

    function getAllVoyantQuestionsTotalEarningCurrentmonth($year)
    {
         $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
        $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
        $c = new Criteria();
      
        $c->add('userQuestions.creationDate', $lastDateOfyear , "<=");
        $c->add('userQuestions.creationDate', $firstDateOfyear , ">=");

        $price = $this->userQuestion->getEarning($c); 
        $earning = array_sum($price);   
        return $earning;
    }

    public function totalAllEarningCurrentmonth($type,$year){
        //For Consultations Earnings...
       $userConsultaions = [];
       $duration = [];
       $lastDateOfyear = date('Y-m-d', strtotime($year.'-31'));
       $firstDateOfyear = date('Y-m-d', strtotime($year.'-01'));
       $c = new Criteria();
       $c->add('type', $type);
       $c->add('status', 'E');
       
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



   public function getAllConsultationtimeCurrentmonth($type,$year){
    $usedTime = 0;
    $e = new Criteria();
     
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
     
    
    function getVoyantPendingCheckOrdersCount($voyantId)
    {
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->add('status', 'pending');
        $c->add('paymentMethod', 'check');
        
        return $this->order->getCount($c);
    }
    function getVoyantCommentsCountWithStatus($voyantId, $status)
    {
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add('validated', $status);
        return $this->voyantComment->getCount($c);    
    }

    function getVoyantMessagesCountWithPending($voyantId=null)
    {
        $c = new Criteria();
        if($voyantId!=null) {
         $c->add("voyantId", $voyantId);    
        }
        $c->add('view', 0);
        $c->add('sendby','U');
        return $this->voyantMessage->getCount($c);
    }


    function getCountPendingReview()
    {
        $c = new Criteria();
        $c->add("validated",1,'!=');
        return $this->voyantComment->getCount($c);
    }
    function getCountAllReview()
    {
        $c = new Criteria();
        //$c->add("validated",1,'!=');
        return $this->voyantComment->getCount($c);
    }

    public function getCountPendingVoyantQuestion(){
        $c = new Criteria();
        $c->add("adminValidation",0);
        return $this->voyantQuestion->getCount($c);   
    }

    //Getting Promo packages...
    function promoPacks(){
        $c = new Criteria();
        $c->add('packageDisplay', 1);
        $c->add('packagePromo', 1);
        $packages = Model::factoryInstance("package")->findAll($c);
        $promoPacks = [];
        if(isset($packages) && !empty($packages)){            
             foreach ($packages as $key => $package) {
                if(!empty($package['packagePromoMsg'])){
                    $promoPacks[] = strip_tags($package['packagePromoMsg']);
                }                               
            }  
        }
        return $promoPacks;
    }


      //Get Voyant Languages....
      function voyantConsultations($voyantId){
        $d = new Criteria();
        $d->add('voyantId', $voyantId);
        $voyantConsultations = Model::factoryInstance('voyantConsultation')->findAll($d, "consultationId");
     
        $voConsId = []; $consultationIds = [];
        if(isset($voyantConsultations) && !empty($voyantConsultations)){
            foreach($voyantConsultations as $voCons){
                 $voConsId[] =  $voCons['consultationId'];
            } 
            $consultationIds = array_values(array_unique($voConsId));
         }
        return $consultationIds;
    }

    //Get Voyant Languages....
    function voyantLanguages($voyantId){
        $d = new Criteria();
        $d->add('voyantId', $voyantId);
        $voyantlanguages = Model::factoryInstance('voyantLanguage')->findAll($d, "languageId");
        $voLangId = []; $languageIds = [];
        if(isset($voyantlanguages) && !empty($voyantlanguages)){
           foreach($voyantlanguages as $voLang){
                $voLangId[] =  $voLang['languageId'];
           } 
           $languageIds = array_values(array_unique($voLangId));
        }
        return $languageIds;
    }
    //Get voyant skills...
    function voyantSkills($voyantId){
       
           
        $k = new Criteria();
        $k->add('voyantId', $voyantId);
        $voyantSkills = Model::factoryInstance('voyantSkill')->findAll($k, "skillId");
        //  echo "<pre>";
        // print_r($voyantSkills);
       
        $voSkillId = []; $skillIds = [];
        if(isset($voyantSkills) && !empty($voyantSkills)){
           foreach($voyantSkills as $voSkill){
                $voSkillId[] =  $voSkill['skillId'];
           } 
           $skillIds = array_values(array_unique($voSkillId));
        }
        return $skillIds;
         
    }


     //Get voyant ...
     function voyants($voyantId){

        $k = new Criteria();
        $k->add('voyantId', $voyantId);
        $voyants = Model::factoryInstance('Voyant')->findAll($k, "voyantId");
        
       
      
        $voVoyantId = []; $voyantIds = [];
        if(isset($voyants) && !empty($voyants)){
            
           foreach($voyants as $voVoyant){
                $voVoyantId[] =  $voVoyant['voyantId'];
           } 
           
          
           $voyantIds = array_values(array_unique($voVoyantId));
        }
        
        return $voyantIds;
        
    }
    //Getting voyant email ids...
    function getVoyantEmailIds($userId){
       if(!empty($userId)){
            $k = new Criteria();
            $voyantIds = [];
            $k->add('userId', $userId);
            $k->add('sendBy', 'V');
            $k->add('view', 0);
            $voyantss = $this->voyantMessage->findAll($k);
            foreach($voyantss as $voyant){                        
                if (!empty($voyant['voyantId'])) {
                    $voyantIds[] = $voyant['voyantId'];
                }
            }
            if(count($voyantIds) > 1){
                $voyantIds = array_values(array_unique($voyantIds));
            }
            $voyantEmails = [];$emails = [];
            if(isset($voyantIds) && !empty($voyantIds)){
                 foreach($voyantIds as $voyantId){
                    $k = new Criteria();
                    $k->add('userId', $voyantId);
                    $k->add('role', 'voyant');
                    $voyantEmails[] = Model::factoryInstance('user')->findAll($k, 'email');
                }
            }
            foreach($voyantEmails as $email){
                $emails[] = $email[0]['email'];
            }
           $emails = json_encode($emails);
           return $emails;
       }
    }
    function getTotalTime($type){
                $usedTime = 0;
                $e = new Criteria();
                $e->add('status', 'E');
                $e->add('type', $type);
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
          public function getConsultationcount($userId,$type){

                $usedTime = 0;
                $e = new Criteria();
                $e->add('voyantId',$userId);
                $e->add('status', 'E');
                $e->add('type', $type);
                $userconsultation = $this->userConsultation->findAll($e);
                  if($userconsultation) {
                   $count = count($userconsultation);
                }else{
                    $count = 0;
                }
            
                
               return $count; 
        
        }
        public function getConsultationtime($userId,$type){
                $usedTime = 0;
                $e = new Criteria();
                $e->add('voyantId',$userId);
                 
                $e->add('status', 'E');
                $e->add('type', $type);
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
     public function getUserConsulttime($userId,$type){


            
             $d = new Criteria();
                $d->add('userId',$userId);
                $d->add('status', 'paid');
                $d->add('questionStatus', 'pending');
                $d->add('title', '%Time Pack%', 'LIKE');
                $orderItemsCriteria = new Criteria();
                $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
                $orderItemsCriteria->add('packId',NULL,'!=');
                $d->addWithRelation('orderItems', array('fields' => 'orderId,packid,packages.packageTime','criteria' => $orderItemsCriteria));
                $order = $this->order->findAll($d);
               $usedTime = 0;
                $e = new Criteria();
                $e->add('userId',$userId);
                $e->add('status', 'E');
                $e->add('type', $type);
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
                $totalTime = 0;
                $totTime = 0;
                if(isset($order) && !empty($order)){
                   $packIds = [];
                   foreach($order as $torder){
                        foreach ($torder['orderItems'] as $key => $record){                    
                            $totalTime += $record['packageTime'];  
                        }
                   }

                   //echo $totalTime.'<<><>'.$usedTime;die;
                   if($totalTime >= $usedTime){
                        $totalTime = $usedTime;
                   }else{
                        $totalTime = 0;
                        $totTime = 0;
                   }

                    /*$hours = floor($totalTime / 60);
                    $min = $totalTime - ($hours * 60);
                    $seconds = $totalTime - ($min*60);*/
                    $init = $totalTime*60; // convert min. into seconds
                    $hours = floor($init / 3600);
                    $minutes = floor(($init / 60) % 60);
                    $seconds = $init % 60;
                    $hours = ($hours ? ($hours > 9 ? $hours : "0" . $hours) : "00");
                    $minutes = ($minutes ? ($minutes > 9 ? $minutes : "0" . $minutes) : "00");
                    $seconds = ($seconds ? ($seconds > 9 ? $seconds : "0" . $seconds) : "00");
                    $totTime = $hours."h ".$minutes."m ".$seconds."s";

                }
               return $totTime; 
        
    
    }
    public function getRemainingtime($userId){

            
             $d = new Criteria();
                $d->add('userId',$userId);
                $d->add('status', 'paid');
                $d->add('questionStatus', 'pending');
                $d->add('title', '%Time Pack%', 'LIKE');
                $orderItemsCriteria = new Criteria();
                $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
                $orderItemsCriteria->add('packId',NULL,'!=');
                $d->addWithRelation('orderItems', array('fields' => 'orderId,packid,packages.packageTime','criteria' => $orderItemsCriteria));
                $order = $this->order->findAll($d);
               $usedTime = 0;
                $e = new Criteria();
                $e->add('userId',$userId);
                $e->add('status', 'E');
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
                $totalTime = 0;
                $totTime = 0;
                if(isset($order) && !empty($order)){
                   $packIds = [];
                   foreach($order as $torder){
                        foreach ($torder['orderItems'] as $key => $record){                    
                            $totalTime += $record['packageTime'];  
                        }
                   }

                   //echo $totalTime.'<<><>'.$usedTime;die;
                   if($totalTime >= $usedTime){
                        $totalTime = $totalTime-$usedTime;
                   }else{
                        $totalTime = 0;
                        $totTime = 0;
                   }

                    /*$hours = floor($totalTime / 60);
                    $min = $totalTime - ($hours * 60);
                    $seconds = $totalTime - ($min*60);*/
                    $init = $totalTime*60; // convert min. into seconds
                    $hours = floor($init / 3600);
                    $minutes = floor(($init / 60) % 60);
                    $seconds = $init % 60;
                    $hours = ($hours ? ($hours > 9 ? $hours : "0" . $hours) : "00");
                    $minutes = ($minutes ? ($minutes > 9 ? $minutes : "0" . $minutes) : "00");
                    $seconds = ($seconds ? ($seconds > 9 ? $seconds : "0" . $seconds) : "00");
                    $totTime = $hours."h ".$minutes."m ".$seconds."s";

                }
               return $totTime; 
        
    }
    public function getVoyantCount($userId){


                $e = new Criteria();
                $e->add('userId',$userId);
                $e->add('status', 'E');
                $userconsultation = $this->userConsultation->findAll($e);
                  if($userconsultation) {
                  foreach ($userconsultation as $userconsult) {
                      $voyants[] =  $userconsult['voyantId'];
                  }
                 $voyantcount = array_unique($voyants);
                 $voyantcount = count($voyantcount);
                }else{
                 $voyantcount = 0;   
                }
              
               return $voyantcount; 
        
    
    }
    public function getTotaltimesuser($userId){

            
             $d = new Criteria();
                $d->add('userId',$userId);
                $d->add('status', 'paid');
                $d->add('questionStatus', 'pending');
                $d->add('title', '%Time Pack%', 'LIKE');
                $orderItemsCriteria = new Criteria();
                $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
                $orderItemsCriteria->add('packId',NULL,'!=');
                $d->addWithRelation('orderItems', array('fields' => 'orderId,packid,packages.packageTime','criteria' => $orderItemsCriteria));
                $order = $this->order->findAll($d);
               $usedTime = 0;
                $e = new Criteria();
                $e->add('userId',$userId);
                $e->add('status', 'E');
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
                $totalTime = 0;
                $totTime = 0;
                if(isset($order) && !empty($order)){
                   $packIds = [];
                   foreach($order as $torder){
                        foreach ($torder['orderItems'] as $key => $record){                    
                            $totalTime += $record['packageTime'];  
                        }
                   }

                   //echo $totalTime.'<<><>'.$usedTime;die;
                   if($totalTime >= $usedTime){
                        $totalTime = $totalTime;
                   }else{
                        $totalTime = 0;
                        $totTime = 0;
                   }

                    /*$hours = floor($totalTime / 60);
                    $min = $totalTime - ($hours * 60);
                    $seconds = $totalTime - ($min*60);*/
                    $init = $totalTime*60; // convert min. into seconds
                    $hours = floor($init / 3600);
                    $minutes = floor(($init / 60) % 60);
                    $seconds = $init % 60;
                    $hours = ($hours ? ($hours > 9 ? $hours : "0" . $hours) : "00");
                    $minutes = ($minutes ? ($minutes > 9 ? $minutes : "0" . $minutes) : "00");
                    $seconds = ($seconds ? ($seconds > 9 ? $seconds : "0" . $seconds) : "00");
                    $totTime = $hours."h ".$minutes."m ".$seconds."s";

                }
               return $totTime; 
        
    }
    public function getConsultationcountBetween($voyantId,$userId,$type){

                $usedTime = 0;
                $e = new Criteria();
                $e->add('voyantId',$voyantId);
                $e->add('userId',$userId);
                $e->add('status', 'E');
                $e->add('type', $type);
                $userconsultation = $this->userConsultation->findAll($e);
                  if($userconsultation) {
                   $count = count($userconsultation);
                }else{
                    $count = 0;
                }
            
                
               return $count; 
        
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



    public function getTotalEarningAll($type){
        //For Consultations Earnings...
       $userConsultaions = [];
       $duration = [];
       $c = new Criteria();
       $c->add('type', $type);
       $c->add('status', 'E');
    //    $c->add('userconsultations.voyantId', $voyantId);
       $c->addOrder("date DESC");
       $c->addWithRelation('voyant', array(
                               'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                            displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                            displayLastNameOnInvoice, displayTvaOnInvoice,
                                            zipCode, city'));
       $consultations = $this->userConsultation->findAll($c);
    //    echo "<pre>";
    //    die(print_r($consultations));
        
       if(isset($consultations) && !empty($consultations)){
           $userConsultaions = $this->getConsultationsDetails($consultations);
          
           foreach($userConsultaions as $userConsultaion) {
               $duration[] = $userConsultaion['duration'];
           }
        //    die(print_r($duration));
           
       }
       if(isset($duration)){
        $totalEarning = array_sum($duration);   
    }else{
       $totalEarning = 0;
    }
       
       return $totalEarning;
        
            
       
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

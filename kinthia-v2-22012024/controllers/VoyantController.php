<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantController extends AppController
{   
    
    public function detailsAction($voyantId, $urlName, $page = 1)
    {
        //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = []; 
        foreach ($voyantIdsFromUserFav as $item) {
            $userFav[]= $item['voyantId'];
        }  
        $voyantIdsFromUserFav['userFavIds'] = $userFav;
        $this->set('userid',$userid);
        $this->set('userFav',$userFav);
            
        $itemsPerPage = Config::get('voyantQuestionsPerPage');
        
        $voyantQuestionCriteria = new Criteria();
        $voyantQuestionCriteria->addOrder('position');
        $voyantQuestionCriteria->add('displayOnline',1);
     
        $voyantQuestionCriteria->add('adminValidation',1);
        $voyantQuestionCriteria->setPagination($page, $itemsPerPage);
        $voyantQuestionCriteria->setCalcFoundRows(true);

        $c = new Criteria();
        
        if (!empty($voyantId)) {
            $c->add('voyants.voyantId', $voyantId);
        } else {
            $c->add('voyants.urlName', $urlName);
        }
        
        $c->addWithRelation('voyantQuestions', array(
                                'fields'    => 'voyantId, questionId, shortDescription, title, price, urlName, imageSrc,displayOnline,adminValidation',
                                'criteria'  => $voyantQuestionCriteria,
                                'relations' => array(
                                      'voyantQuestionPrices' => array(
                                          'fields' => 'questionId, price, quantity, priceId'))));

		$c->addWithRelation('userQuestions', array(
								'fields' => 'userquestions.voyantId, userquestions.questionId, count(*) as answeredCount',
                                'relations' => array(
                                'voyantQuestion' => array(
                                'fields' => 'title'))));

        $voyant = $this->voyant->find($c, 'voyants.*');
        if (empty($voyant)) {
            $this->return404();
        }

        // Phone consultation filter criteria
        $consultations = 0;
        $phoneC = new Criteria();
        $phoneC->add('status', 'E');
        $phoneC->add('type', 'phone');
        $phoneC->add('voyantId', $voyant->voyantId);
        $pConsultations = Model::factoryInstance('userConsultation')->findAll($phoneC);

        // Camera consultation filter criteria
        $camC = new Criteria();
        $camC->add('status', 'E');
        $camC->add('type', 'webcam');
        $camC->add('voyantId', $voyant->voyantId);
        $cConsultations = Model::factoryInstance('userConsultation')->findAll($camC);

        //  total consultations for phone/webcam
        $consultations = count($pConsultations) + count($cConsultations);

        // total answered count including all types of consultations
        if (count($voyant['userQuestions'])) {
            $answeredCount = $voyant['userQuestions'][0]['answeredCount'] + $consultations;
        } else {
            $answeredCount = 0;
        }
        
	    $this->set('answeredCount', $answeredCount);

        //updated voyant profile image
    	$firstGalleryImageSrc = '';
        $p = new Criteria();
        $p->add('userId', $voyant->voyantId);
        $user = Model::factoryInstance('user')->find($p,"firstGalleryImageSrc");
        $firstGalleryImageSrc = $user['firstGalleryImageSrc'];
        $this->set('firstGalleryImageSrc', $firstGalleryImageSrc);    


        //Review
        $c = new Criteria();
        $c->add('voyantId', $voyant->voyantId);
        $c->add('validated', 1);
        $c->addOrder("commentId desc");
        $c->addWithRelation('user', array('fields' => 'name'));
        $c->setLimit(intval(Config::get('VOYANT_REVIEW_LIMIT')));

        $Reviewvoyant = $this->voyantComment->findAll($c);
        $this->set('Reviewvoyant', $Reviewvoyant);

        //get Voyant languages...
        $d = new Criteria();
        $d->add('voyantId', $voyant->voyantId);
        $voyantlanguages = Model::factoryInstance('voyantLanguage')->findAll($d, "languageId");
        $voLangId = []; $languageIds = [];
        if(isset($voyantlanguages) && !empty($voyantlanguages)){
           foreach($voyantlanguages as $voLang){
                $voLangId[] =  $voLang['languageId'];
           } 
           $languageIds = array_values(array_unique($voLangId));
        }
        $g = new Criteria();
        $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
        $this->set('voyantlanguages', $voyantlanguages);
        $this->set('languageIds', $languageIds);

//get Voyant Consultations...
$d = new Criteria();
$d->add('voyantId', $voyant->voyantId);
$voyantConsultations = Model::factoryInstance('voyantConsultation')->findAll($d, "consultationId");
 
$voConsId = []; $consultationIds = [];
if(isset($voyantConsultations) && !empty($voyantConsultations)){
   foreach($voyantConsultations as $voCons1){
        $voConsId[] =  $voCons1['consultationId'];
   } 
   $consultationIds = array_values(array_unique($voConsId));
}
$g = new Criteria();
$voyantConsultations = Model::factoryInstance('Consultation')->findAll($g);
$this->set('voyantConsultations', $voyantConsultations);
$this->set('consultationIds', $consultationIds);




//get Voyant  ...
$d = new Criteria();
$d->add('voyantId', $voyant->voyantId);
$voyants = Model::factoryInstance('Voyant')->findAll($d, "voyantId");

 
 
$voId = []; $voyantIds = [];
if(isset($voyants) && !empty($voyants)){
   foreach($voyants as $voId1){
        $voId[] =  $voId1['voyantId'];
   } 
   $voyantIds = array_values(array_unique($voId));
    
}
$g = new Criteria();
$voyants = Model::factoryInstance('Voyant')->findAll($g);
$this->set('voyants', $voyants);
$this->set('voyantIds', $voyantIds);





        //get voyant skills...
        $k = new Criteria();
        $k->add('voyantId', $voyant->voyantId);
        $voyantSkills = Model::factoryInstance('voyantSkill')->findAll($k, "skillId");
        $voSkillId = []; $skillIds = [];
        if(isset($voyantSkills) && !empty($voyantSkills)){
           foreach($voyantSkills as $voSkill){
                $voSkillId[] =  $voSkill['skillId'];
           } 
           $skillIds = array_values(array_unique($voSkillId));
        }
        $l = new Criteria();
        $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
        $this->set('voyantSkills', $voyantSkills);
        $this->set('skillIds', $skillIds);

        // find voyantId From voyantSkill
        $c1 = new Criteria();
        $c1->add('skillId', $skillIds, 'IN');
        $voyantIdFromVoyantSkills = Model::factoryInstance('voyantSkill')->findAll($c1,'voyantId');
         
       
 
        //unique VoyantIds
        $voSkillVoyantIds= [];
        foreach($voyantIdFromVoyantSkills as $voSkillVoyantId){
            $voSkillVoyantIds[] =  $voSkillVoyantId['voyantId'];
       } 
       $voSkillVoyantIds= array_values(array_unique($voSkillVoyantIds));
        
        // Find VoyantId Match In Voyant
       $c2 = new Criteria();
       $c2->add('voyantId', $voSkillVoyantIds, 'IN');
    //    $itemsPerPage = Config::get('voyantsPerPage');
    //       $c2->setPagination($page, $itemsPerPage);
       $allVoyantFromVoyantSkills = Model::factoryInstance('voyant')->findAll($c2);
        
    
        $this->set('allVoyantFromVoyantSkills', $allVoyantFromVoyantSkills); 
              
  
      

        $questionPrices = $this->voyantQuestionPrice->extractQuestionPrices($voyant['voyantQuestions']);
        $this->set('questionPrices', JsonView::php2js($questionPrices));
        $this->set('voyant', $voyant);        
        
        $totalPages = ceil($this->voyantQuestion->getFoundRowsCount() / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/voyant/details/' . $voyant->voyantId . '/' . $voyant->urlName . '/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page,
                                           'title'       => $voyant->title));

        $this->set('statistic', array(
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($voyant->voyantId, 1)
        ));

        $this->set("action",$this->action);
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
        $this->set('allPromoPackages', $promoPacks); 

        //Calander...
        $t = new Criteria();
        $t->add('voyants.urlName', $urlName);
        $voyant = $this->voyant->find($t, 'voyants.*');
      
        $type = 'next';
//$now = new DateTime();
//$now->setTimezone(new DateTimezone('Europe/Paris'));
// $sdate = $now->format('Y-m-d');
	    
 //$timezone = date_default_timezone_get();
 //$date = date('Y-m-d h:i:s', time()); 


 

	    $sdate = date('Y-m-d');
        $minutes = $this->get_minutes('00:00', '23:00');
        $this->set('minutes',$minutes);
        $this->set('type',$type);

        $dates = $this->getWeeksAction($sdate,$type);
        $this->set('dates',$dates);


         $consultObj = new Criteria();
    
        
         $consultObj->addOrder("id asc limit 1");
         $consultationTypeids = Model::factoryInstance("consultationType")->findAll($consultObj,'id');
       if($consultationTypeids){

        $consultationType = $this->consultationType->findByPk($consultationTypeids[0]['id']);	  



        if(!empty($consultationType['consultaion_type'])){
             $consultation = $this->consultation->findByPk($consultationType['consultaion_type']);
             $this->set('consulType',$consultation['name']);
             $this->set('consultationtypeId',$consultation['id']);
             $this->set('consultationtypePhoneId',$consultationType['id']);
             $this->set('consultationtypeStatus',$consultationType['status']);
       
         $record = [];
         $c = new Criteria();
	     $c->add('consultationtypeId',$consultationType['id']);	
         $c->add('voyantId', $voyant->voyantId);
         $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
       
       
         $dateArr = [];
         foreach($VoyantDateSchedules as $key=> $dateSchedule){
            $record[$key]['id'] = $dateSchedule['id'];
            $record[$key]['voyantId'] = $dateSchedule['voyantId'];
            $record[$key]['consultationtypeId'] = $dateSchedule['consultationtypeId'];
            $record[$key]['schedule_date'] = $dateSchedule['schedule_date'];
            $c = new Criteria();
            $c->add('voyantdatescheduleId', $record[$key]['id'], 'IN');
            $voyantTimeslots = Model::factoryInstance("voyantTimeslot")->getArray($c, 'timeslots');
            $record[$key]['timeslots'] = array_values($voyantTimeslots);
          
         }

        

         $result = [];
         foreach($record as $key=> $recod){
            $result['schedule_date'][$recod['schedule_date']] = $recod['timeslots'];
         }

         //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
            // foreach ($record as $current_key => $current_array) {
            //     foreach ($record as $search_key => $search_array) {
            //         if ($search_array['schedule_date'] == $current_array['schedule_date']) {
            //           if ($search_key != $current_key) {                    
            //             $result['schedule_date'][$search_array['schedule_date']] = array_merge($search_array['timeslots'],$current_array['timeslots']);
            //           }
            //         }
            //     }
            // }
       
         $this->set('result',$result);
       }


 



       
            }


        
            
         $consultObj1 = new Criteria();


     
               $consultObj1->addOrder("id asc limit 1 OFFSET 1");
         $consultationTypeid1 = Model::factoryInstance("consultationType")->findAll($consultObj1,'id');

         if($consultationTypeid1){
  $consultationType1 = $this->consultationType->findByPk($consultationTypeid1[0]['id']);        
       if(!empty($consultationType1['consultaion_type'])){
            $consultation1 = $this->consultation->findByPk($consultationType1['consultaion_type']);
            $this->set('consulType1',$consultation1['name']);
            $this->set('consultationtypeId1',$consultation1['id']);
            $this->set('consultationtypeWebId',$consultationType1['id']);

         
        $record1 = [];
        $c1 = new Criteria();
        $c1->add('consultationtypeId',$consultationType1['id']);    
        $c1->add('voyantId', $voyant->voyantId);
        $VoyantDateSchedules1 = Model::factoryInstance("VoyantDateSchedule")->findAll($c1);
 
        $dateArr = [];
        foreach($VoyantDateSchedules1 as $key=> $dateSchedule1){

        
           $record1[$key]['id'] = $dateSchedule1['id'];

          
           $record1[$key]['voyantId'] = $dateSchedule1['voyantId'];
           $record1[$key]['consultationtypeId'] = $dateSchedule1['consultationtypeId'];
           $record1[$key]['schedule_date'] = $dateSchedule1['schedule_date'];
          
           $c1 = new Criteria();
           $c1->add('voyantdatescheduleId', $record1[$key]['id'], 'IN');
           $voyantTimeslots1 = Model::factoryInstance("voyantTimeslot")->getArray($c1, 'timeslots');

         
           $record1[$key]['timeslots'] = array_values($voyantTimeslots1);
        }
     
        $result1 = [];
        foreach($record1 as $key=> $recod){
           $result1['schedule_date'][$recod['schedule_date']] = $recod['timeslots'];
        }

        //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
        //    foreach ($record1 as $current_key1 => $current_array1) {
        //        foreach ($record1 as $search_key1 => $search_array1) {
        //            if ($search_array1['schedule_date'] == $current_array1['schedule_date']) {
        //              if ($search_key1 != $current_key1) {                    
        //                $result1['schedule_date'][$search_array1['schedule_date']] = array_merge($search_array1['timeslots'],$current_array1['timeslots']);
        //              }
        //            }
        //        }
        //    }
      
        $this->set('result1',$result1);

         }

         



       
            }



           $consultObj2 = new Criteria();
    
        
         $consultObj2->addOrder("id asc limit 1 OFFSET 2");
              
         $consultationTypeid2 = Model::factoryInstance("consultationType")->findAll($consultObj2,'id');

      if($consultationTypeid2){
      $consultationType2 = $this->consultationType->findByPk($consultationTypeid2[0]['id']);	    
      if(!empty($consultationType2['consultaion_type'])){
           $consultation2 = $this->consultation->findByPk($consultationType2['consultaion_type']);
           $this->set('consulType2',$consultation2['name']);
           $this->set('consultationtypeId2',$consultation2['id']);
           $this->set('consultationtypeEmailId',$consultationType2['id']);
           

        
       $record2 = [];
       $c2 = new Criteria();
       $c2->add('consultationtypeId',$consultationType2['id']);	
       $c2->add('voyantId', $voyant->voyantId);
       $VoyantDateSchedules2 = Model::factoryInstance("VoyantDateSchedule")->findAll($c2);
      
       $dateArr = [];
       foreach($VoyantDateSchedules2 as $key=> $dateSchedule2){
          $record2[$key]['id'] = $dateSchedule2['id'];
          $record2[$key]['voyantId'] = $dateSchedule2['voyantId'];
          $record2[$key]['consultationtypeId'] = $dateSchedule2['consultationtypeId'];
          $record2[$key]['schedule_date'] = $dateSchedule2['schedule_date'];
          $c2 = new Criteria();
          $c2->add('voyantdatescheduleId', $record2[$key]['id'], 'IN');
          $voyantTimeslots2 = Model::factoryInstance("voyantTimeslot")->getArray($c2, 'timeslots');
          $record2[$key]['timeslots'] = array_values($voyantTimeslots2);
       }

       $result2 = [];
       foreach($record2 as $key=> $recod){
          $result2['schedule_date'][$recod['schedule_date']] = $recod['timeslots'];
       }

       //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
        //   foreach ($record2 as $current_key2 => $current_array2) {
        //       foreach ($record2 as $search_key2 => $search_array2) {
        //           if ($search_array2['schedule_date'] == $current_array2['schedule_date']) {
        //             if ($search_key2 != $current_key2) {                    
        //               $result2['schedule_date'][$search_array2['schedule_date']] = array_merge($search_array2['timeslots'],$current_array2['timeslots']);
        //             }
        //           }
        //       }
        //   }
     
       $this->set('result2',$result2);
     }


    

      }

       //get voyant next time for consultation...
       $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant);
       $nextTimeSlot = \TimeslotHelper::transformToCalendar($nextTimeSlot);
       $this->set('nextTimeSlot',$nextTimeSlot);

        //Get User Consultation
        $userConsObj = new Criteria();
        $userConsObj->add('userId',$userid);
        $userConsObj->add('status','E');
        $userConsObj->add('voyantId',$voyant->voyantId);
        $userConsObj->addOrder("created_at DESC LIMIT 30");
        $voyantConsFromUserCons = Model::factoryInstance("userConsultation")->findAll($userConsObj);
        $this->set('voyantConsFromUserCons', $voyantConsFromUserCons);

        $reviewLimit = intval(Config::get('VOYANT_REVIEW_LIMIT'));
        $this->set('reviewLimit', $reviewLimit);

        //Send message Tab
        $isConsultWithVoyant = $this->getCheckConsultationWithUser($voyant->voyantId);
     	$this->set('isConsultWithVoyant', $isConsultWithVoyant);

        $settings = $this->setting->getArray(null, 'value');
        $this->set('availabilityRefreshRate', isset($settings['availability_refresh_rate'])?$settings['availability_refresh_rate']:5);
        $this->set('timeStamp', strtotime($voyant->consultationTime));
    }

    public function getVoyantNextTimeSlot($voyant){
        date_default_timezone_set('Europe/Paris');
        $results = [];

        if(!empty($voyant)){
            $c = new Criteria();
            //$c->add('consultationtypeId',$consultationType['id']);
            $c->addOrder("schedule_date ASC");
            $c->add('voyantId', $voyant->voyantId);
            $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
            
            $record = [];
            foreach($VoyantDateSchedules as $key=> $dateSchedule){
                $record[$key]['id'] = $dateSchedule['id'];
                $record[$key]['schedule_date'] = $dateSchedule['schedule_date'];
                $c = new Criteria();
                $c->add('voyantdatescheduleId', $record[$key]['id'], 'IN');
                $c->addOrder("timeslots ASC");
                $voyantTimeslots = Model::factoryInstance("voyantTimeslot")->getArray($c, 'timeslots');
                $record[$key]['timeslots'] = array_values($voyantTimeslots);
            }

            //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
            if(isset($record) && !empty($record)){
                foreach ($record as $current_array) {
                    foreach ($record as $search_array) {
                        if ($search_array['schedule_date'] == $current_array['schedule_date']) {
                            $today = new DateTime();
                            $theDate = new DateTime($search_array['schedule_date']);
                            $dateDiff = intval($today->diff($theDate)->format("%r%a"));

                            // If available, only take 7 days schedule
                            if($voyant['available']){
                                if($dateDiff >= 0 && $dateDiff < 8){}
                                else{
                                    continue;
                                }
                            }

                            if(!isset($results[$search_array['schedule_date']])){
                                $results[$search_array['schedule_date']] = [];
                            }

                            foreach($current_array['timeslots'] as $timeslot){
                                $theTime = strtotime($search_array['schedule_date'] . " " . $timeslot);
                                if(!in_array($theTime, $results[$search_array['schedule_date']])){
                                    $results[$search_array['schedule_date']][] = $theTime;
                                }
                            }
                        }
                    }
                }
            }
        }

        return $results;
    }

    public function updateConsultStatusAction(){
        $this->viewClass = 'JsonView';    
        try{           
            if($this->request->consultType=='present'){
                $status = 1;
            }else{
                $status = 0;
            }

            $c = new Criteria();
            $consult_type = new ConsultationTypeRecord();
            $consult_type->id = $this->request->consulTypeId;
            $consult_type->status = $status;
            $consult_type->update();
        }catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }      
    }
    /**
    * Getting weeks
    *@param $data
    *@param $type
    *@return $weekOfdays
    */
    public function getWeeksAction($date,$type){    
        $weekOfdays = array();
        if($type=='next'){
             for($i =0; $i <= 6; $i++){
                $weekOfdays[] = date('Y-m-d', strtotime("+$i day", strtotime($date)));
            }
        }else{
            for($i =0; $i <= 6; $i++){
                $weekOfdays[] = date('Y-m-d', strtotime("-$i day", strtotime($date)));
            }
        }
        return $weekOfdays;
    }

    /**
    * Getting Minutes
    *@param $start
    *@param $end
    *@return $minutes
    */
    public function get_minutes ( $start, $end ) { 

         while ( strtotime($start) <= strtotime($end) ) {
                $minutes[date("H", strtotime( "$start" ) )][] = date("H:i", strtotime( "$start" ) ); 
                $start = date("H:i", strtotime( "$start + 30 mins")) ;     
            }
            foreach(array_values($minutes) as $key=> $min){
                 if($key=='23'){
                    $minutes[$key][] = '23:30';
                }
            }
         return array_values($minutes);
    } 



    public function saveCalanderDataAction(){
          
        $this->viewClass = 'JsonView';    
         try {
            if($this->request->type=='present'){
             
                $c = new Criteria();
                $c->add('consultationtypeId', $this->request->consultationtypeId);
                $c->add('voyantId', $this->request->voyantId);
                $c->add('schedule_date', $this->request->schedule_date);
                $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
               
               
                 if(count($VoyantDateSchedules)==0){
                    $voyant_schedule = new VoyantDateScheduleRecord();
                    $voyant_schedule->voyantId = $this->request->voyantId;
                    $voyant_schedule->schedule_date = $this->request->schedule_date;
                    $voyant_schedule->consultationtypeId = $this->request->consultationtypeId;
                    $schedule = $voyant_schedule->save();
                    $lastInsertId = $voyant_schedule->id;
                }else{
                    $lastInsertId = $VoyantDateSchedules[0]['id'];
                  
                }
               
                if(!empty($this->request->timeslots)){

                      
                    $timeslots = explode(',',$this->request->timeslots);
                    foreach($timeslots as $timeslot){
                       
                        $voyant_timeslot = new VoyantTimeslotRecord();
                        $voyant_timeslot->voyantdatescheduleId = $lastInsertId;
                        $voyant_timeslot->timeslots = $timeslot;                   
                        $voyant_timeslot->save();



                        $user_timeslot = new UserTimeSlotRecord();
                        $user_timeslot->voyantdatescheduleId = $lastInsertId;
                        $user_timeslot->voyanttimeslotId = $timeslot; 
                        $user_timeslot->userId = $this->session->get('userId');                      
                        $user_timeslot->save();


                                  $c12 = new Criteria();
              $c12->add('voyantId', $this->request->voyantId);
              $voyantEmail = Model::factoryInstance('voyant')->find($c12,"email");
              // die(print_r($voyantEmail['email']));

              Mailer::getInstance()->sendEmailSlotBook($voyantEmail['email'],'slot booked','slot booked');



                    }
                }
                echo "Time slots availability saved successfully.";
                exit;
            }

            if($this->request->type=='absent'){
         
                
                 $c = new Criteria();
                 $c->add('consultationtypeId', $this->request->consultationtypeId);
                 $c->add('voyantId', $this->request->voyantId);
                 $c->add('schedule_date', $this->request->schedule_date);
                 $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
                 
                 if(count($VoyantDateSchedules) > 0){
                    $voyantdatescheduleId = $VoyantDateSchedules[0]['id'];
                    if(!empty($this->request->timeslots)){
                        $timeslots = explode(',',$this->request->timeslots);
                        foreach($timeslots as $timeslot){
                            $c = new Criteria();
                            $c->add('voyantdatescheduleId', $voyantdatescheduleId);
                            $c->add('timeslots', $timeslot);
                           Model::factoryInstance('voyantTimeslot')->del($c);
                          

                            $c2 = new Criteria();
                            $c2->add('voyantdatescheduleId', $voyantdatescheduleId);
                            $c2->add('voyanttimeslotId', $timeslot);
                            Model::factoryInstance('userTimeSlot')->del($c2);


                            
                        }
                      echo "Added absent successfully.";exit;  
                    }
                    
                 }
            }
             
         } catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }      
    }


    /**
    * save user booking data
    */
    public function saveUserBookingDataAction(){
 
      $this->viewClass = 'JsonView';    
        try {
                if(!empty($this->request->schedule_date) && !empty($this->request->timeslots) && !empty($this->request->consultationtypeId) && !empty($this->request->voyantId) && !empty($this->request->userId)){
                      
                     $c = new Criteria();
                     $c->add('consultationtypeId', $this->request->consultationtypeId);
                     $c->add('voyantId', $this->request->voyantId);
                     $c->add('schedule_date', $this->request->schedule_date);
                     $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);                      
                     if(count($VoyantDateSchedules) > 0){ 
                        $voyantdatescheduleId = $VoyantDateSchedules[0]['id'];

                        $timeslots = explode(',',$this->request->timeslots);
                        foreach($timeslots as $timeslot){
                             $d = new Criteria();
                             $d->add('voyantdatescheduleId', $voyantdatescheduleId);
                             $d->add('timeslots', $timeslots, 'IN');
                             $voyantTimeslotIds = Model::factoryInstance("voyantTimeslot")->getArray($d, 'id');
                             $voyantTimeslotIds = array_values($voyantTimeslotIds);
                        }

                        if(isset($voyantTimeslotIds) && !empty($voyantTimeslotIds)){
                             $d = new Criteria();
                             $d->add('userId', $this->request->userId);
                             $d->add('voyantdatescheduleId', $voyantdatescheduleId);
                             $d->add('voyanttimeslotId', $voyantTimeslotIds, 'IN');
                             $userTimeslotIds = Model::factoryInstance("userTimeSlot")->getArray($d, 'id');
                             if(count($userTimeslotIds)==0){
                                foreach($voyantTimeslotIds as $timeslotId){
                                    $user_timeslot = new UserTimeSlotRecord();
                                    $user_timeslot->voyantdatescheduleId = $voyantdatescheduleId;
                                    $user_timeslot->voyanttimeslotId = $timeslotId; 
                                    $user_timeslot->userId = $this->request->userId;                      
                                    $user_timeslot->save();
                                }
                             }else{
                                echo "User already booked this timeslot on particular date.";exit;
                             }
                            
                        }
                        echo "Your time slot booked successfully. As soon as voyant will contact you.";exit;
                     }
                }
        } catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }  

    }

    public function reviewAction($voyantId = 0, $page = 0, $limit = 10)
    {
        $c = new Criteria();
        $c->add('validated', 1);
        $c->addOrder("commentId desc");
        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('voyant', array('fields' => 'headerDescription'));
        $offset = $page * $limit;
        $c->setOffset(intval($offset));
        $c->setLimit(intval($limit));
        $c->add('voyantcomments.voyantId', intval($voyantId));

        $Reviewvoyant = $this->voyantComment->findAll($c);
        $data = $this->transformReview($Reviewvoyant);
        echo json_encode($data);

        return false;
    }

    public function statusAction($voyantId = 0)
    {
        $data = $this->voyant->findByPk($voyantId);
        if($data){
            $result = ['consultationStatus' => $data['consultationStatus'], 'displayPhone' => $data['displayPhone'], 'displayWebcam' => $data['displayWebcam'], 'displayEmail' => $data['displayEmail']];
        }
        else{
            $result = ['consultationStatus' => '', 'displayPhone' => '', 'displayWebcam' => '', 'displayEmail' => ''];
        }

        echo json_encode($result);
        return false;
    }

    private function transformReview($data){
        $result = [];
        foreach($data as $val){
            $temp = [];
            $temp['name'] = $val['user']['name'];
            $temp['text'] = $val['text'];
            $temp['type'] = $val['type'];
            $temp['rating'] = $val['rating'];
            $temp['userId'] = $val['userId'];
            $temp['replyText'] = $val['replyText'];
            $temp['headerDescription'] = $val['voyant']['headerDescription'];
            $temp['date'] = date("d.m.Y", strtotime($val['date']));
            $result[] = $temp;
        }

        return $result;
    }

    private function getCheckConsultationWithUser($voyantId){
    	
    	$c = new Criteria();
        $c->add('userId', $_SESSION['userId']);
        $c->add('voyantId', $voyantId);
        $c->add('status', 'paid');
        $c->add('questionStatus', 'pending');
        $orders = $this->order->findAll($c);

        if(count($orders) > 0){
        	return true;
        }
        return false;
    }
}

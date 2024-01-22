<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class ConsultationController extends AppController
{   
    /**
    * Index Page
    *@param $voyantId
    *@param $type
    */
    public function indexAction($requestId)
    {  
        $c = new Criteria();
        $c->add('userconsultationId', $requestId);
        $userRequests = $this->userConsultation->find($c);

        if($userRequests['status']!='P') {
           $this->redirect(AppRouter::getRewrittedUrl('/')); 
        }
        $voyant = $this->voyant->findByPk($userRequests['voyantId']);
        $user = $this->user->findByPk($this->session->get('userId'));
        // $userdata = ['name'=>$user['name'],'id'=>$user['userId'],'type'=>'U','room'=>'room-'.$userRequests['userId'].'-'.$userRequests['voyantId'],'requestId'=>$userRequests['userconsultationId'],'voyantId'=>$userRequests['voyantId'],'consultationType'=>$userRequests['type']];
        $userdata = ['name'=>$user['name'],'id'=>$user['userId'],'type'=>'U','room'=>'room-'.$userRequests['userId'].'-'.$userRequests['voyantId'],'requestId'=>$userRequests['userconsultationId'],'voyantId'=>$userRequests['voyantId'],'consultationType'=>$userRequests['type'],'status'=>$userRequests['status']];

        $this->set('voyant',$voyant);
        $this->set('userRequests',$userRequests);
        $this->set('userdata',json_encode($userdata));   

        $this->set('statistic', array(
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
        ));
        
       
        $voyantIdsObj = new Criteria();
        $voyantIdsObj->add('voyantId', $userRequests['voyantId']);
        $answeredCount = Model::factoryInstance("UserQuestion")->findAll($voyantIdsObj,'voyantId');
        $answeredCount =count($answeredCount);
        $this->set('answeredCount',$answeredCount);

            //fav
            $curentUserid=$this->userId;
            $userFavObj = new Criteria();
              $userFavObj->add('userId',$curentUserid);
             $userFavObj->add('status','1');
             $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
              $userFav = []; 
                  foreach ($voyantIdsFromUserFav as $item) {
                      $userFav[]= $item['voyantId'];
                     }  
                     $voyantIdsFromUserFav['userFavIds'] = $userFav;
                 $this->set('curentUserid',$curentUserid);
                 $this->set('userFav',$userFav);


        $skillIds = $this->statistic->voyantSkills($userRequests['voyantId']);
        $this->set('skillIds',$skillIds);

          //get VoyantSkills
         $l = new Criteria();
        $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
        $this->set('voyantSkills', $voyantSkills);


        
        $languageIds = $this->statistic->voyantLanguages($userRequests['voyantId']);
        $this->set('languageIds',$languageIds);

        //lang
        $g = new Criteria();
        $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
        $this->set('voyantlanguages', $voyantlanguages);

           
        
       

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
 
              
  
         
       //get voyant next time for consultation...
       $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant->voyantId);
       $this->set('nextTimeSlot',$nextTimeSlot);

       //
       
    
       
        
    }


    public function getVoyantNextTimeSlot($voyantId){
        if(!empty($voyantId)){
         $c = new Criteria();
         //$c->add('consultationtypeId',$consultationType['id']);   
         $c->add('voyantId', $voyantId);
         $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
        
         $dateArr = []; $record = [];
         foreach($VoyantDateSchedules as $key=> $dateSchedule){
            $record[$key]['id'] = $dateSchedule['id'];
            $record[$key]['schedule_date'] = $dateSchedule['schedule_date'];
            $c = new Criteria();
            $c->add('voyantdatescheduleId', $record[$key]['id'], 'IN');
            $voyantTimeslots = Model::factoryInstance("voyantTimeslot")->getArray($c, 'timeslots');
            $record[$key]['timeslots'] = array_values($voyantTimeslots);
         }

         $result = [];
         //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
	 if(isset($record) && !empty($record)){	
	   foreach ($record as $current_key => $current_array) {
		    foreach ($record as $search_key => $search_array) {
		     if ($search_array['schedule_date'] == $current_array['schedule_date']) {
			   if ($search_key != $current_key) {                    
			   	 $result['schedule_date'][$search_array['schedule_date']] = array_merge($search_array['timeslots'],$current_array['timeslots']);
		            }
		     }
	           }
	    }
	 }
        $currentDate = date('Y-m-d');
        date_default_timezone_set('Europe/Paris'); 
        $time = date("H:i"); // time in India

        $nextTimeSlot='';
	if(isset($result) && !empty($result)){
        foreach($result['schedule_date'] as $date => $rest){
            if($date==$currentDate){
                 foreach($rest as $k => $res){
                    if(strtotime($res) > strtotime($time)){
                        $nextTimeSlot = $res;
                    }
                 }  
            }
          }
	}
         return $nextTimeSlot;
        }
    }
    /**
    * consultation type popup data...
    *@param $voyantId
    *@param $type
    */
    public function startAction($voyantId,$type)
    {
        if(!empty($voyantId) && !empty($type)){
            $voyant = $this->voyant->findByPk($voyantId);
            $this->set('expertName',$voyant['name']);
            $this->set('type',$type);
            $this->set('voyant', $voyant);
        }     
    }
    public function endedAction($requestId)
    {
        $c = new Criteria();
        $c->add('userconsultationId', $requestId);
        $c->addWithRelation('voyant', array('fields' => 'name, paidBackPhone, paidBackWebcam'));
        $consultation = $this->userConsultation->find($c);
        // echo "<pre>"; print_r($consultation['duration']); exit;

        // Extract hours, minutes, and seconds from the duration
        list($hours, $minutes, $seconds) = explode(':', $consultation['duration']);

        // Calculate the total duration in minutes
        $durationInMinutes = ($hours * 60) + $minutes + ($seconds / 60);

        $earningMultiplier = ($consultation['type'] === 'webcam') ? $consultation['paidBackWebcam'] : $consultation['paidBackPhone'];

        $expertEarning = $durationInMinutes * $earningMultiplier;

        $updateData = array('expertEarning' => $expertEarning);

        $this->userConsultation->updateByPk($updateData, $consultation['userconsultationId']);

        $this->set('consultation', $consultation);
    }

    public function incomingCallAction($requestId)
    {
        /**
        * set statistic
        */
        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'VA');
        $c->add('userconsultationId',$requestId);
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $pendingRequests = $this->userConsultation->find($c);
        $this->set('pendingRequests', $pendingRequests);
    }

    public function saveUserConsultaionRequestAction(){
        $this->viewClass = 'JsonView';
        try {
                $request_consult = new UserConsultationRecord();
                $request_consult->userId = $this->request->userId;
                $request_consult->voyantId = $this->request->voyantId;                
                $request_consult->type = $this->request->consultationType;
                $request_consult->status = 'P';
                $request_consult->date = date("Y-m-d");
                $request_consult->save();
                $this->set('status', 'success');
                $this->set('id',$request_consult['userconsultationId']);

                //Update expert status in progress mode...
                $data = array("consultationStatus" => "P");
                Model::factoryInstance("voyant")->updateByPk($data, $this->request->voyantId);               
                return;
            } catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }
    }   
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class CommentController extends AppController
{
    public function voyantCommentAction($voyantId, $commentId, $page = 1)
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


        $voyantCommentCriteria = new Criteria();
		$voyantCommentCriteria->add('voyantId', $voyantId);
        $voyantCommentCriteria->add('validated', '1');
        $voyantCommentCriteria->addOrder("date DESC"); //set order


        
		
	   //pagination
	   //$perPage = 50;
       //$totalCount = $this->voyantComment->getCount($voyantCommentCriteria);
       //$totalPages = ceil($totalCount / $perPage);

        //$this->set("pageNavigation", array("baseLink" => "/",
                                        //"totalPages" => $totalPages,
                                      //  "currentPage" => $page));

        //$voyantCommentCriteria->setPagination($page, $perPage);
		//$this->set("voyantComment", $this->voyantComment->findAll($voyantCommentCriteria));
		

        
        
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->addWithRelation('voyantComments', array(
                                'fields' => 'voyantId, rating, text, date,type, replyText',
                                'criteria' => $voyantCommentCriteria,
                                'relations' => array(
                                    'user' => array('fields' => 'name')
                                    )
                                )
        );
        $voyant = $this->voyant->find($c);
       
     
           
          
            
            
    
           
       
         

         
     
        $voyant['countAnswer'] = $this->getCountAnswer($voyant->voyantId);
       
        $this->set('voyant', $voyant);
       
        $this->set('statistic', array(
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
        ));
  
          //get voyant next time for consultation...
          $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant->voyantId);
          $this->set('nextTimeSlot',$nextTimeSlot);
        
             

        
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
              

    }
       //count QuestionAnswer
       public function getCountAnswer($voyantId1){
       
          
        $voyantIdsObj = new Criteria();
        $voyantIdsObj->add('voyantId', $voyantId1);
        $voyantIdsFromUserQuestion = Model::factoryInstance("UserQuestion")->findAll($voyantIdsObj,'voyantId');
          $voyantIdsFromUserQuestion =count($voyantIdsFromUserQuestion);
        return $voyantIdsFromUserQuestion;
       

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




}

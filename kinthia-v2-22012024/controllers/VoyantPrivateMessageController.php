<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantPrivateMessageController extends AppController
{
    public function contactAction($voyantId, $page = 1)
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
     //review list
        $Reviewvoyant = $this->UserFav->findAllFav("SELECT * FROM kinthiavoyance_voyantcomments join kinthiavoyance_users on kinthiavoyance_users.userId=kinthiavoyance_voyantcomments.userId WHERE voyantId = $voyant->voyantId  order by commentId desc" );
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
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
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

        $redirectUrl = base64_encode("contact/$voyantId");
        $this->set('redirectUrl', $redirectUrl);

     	$isConsultWithVoyant = $this->getCheckConsultationWithUser($voyantId);
     	$this->set('isConsultWithVoyant', $isConsultWithVoyant);
           //get voyant next time for consultation...
       $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant->voyantId);
       $this->set('nextTimeSlot',$nextTimeSlot);
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


    public function getCheckConsultationWithUser($voyantId){
    	
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

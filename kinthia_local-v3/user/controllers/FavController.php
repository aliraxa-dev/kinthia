<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_FavController extends AppController
{
    /**
    * Initailize controller set access privileges
    */
    public function init()
    {        
        $this->acl->allow('user', $this->name, '*');
         
        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/user'));  
        }
         $this->set("action",$this->action);
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);
         
        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }
    
    public function indexAction()
    {   

        $curentUserid=$this->userId;
       $userFavObj = new Criteria();
         $userFavObj->add('userId',$curentUserid);
         $userFavObj->addOrder("update_at DESC");
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = []; 
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }  
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('curentUserid',$curentUserid);
            $this->set('userFav',$userFav);

          
        $userFavs = $this->UserFav->findAllFav("SELECT kinthiavoyance_voyants.voyantId as voyantId, displayWebcam,consultationStatus,displayPhone ,displayEmail, displayChat ,urlName ,kinthiavoyance_userfavs.voyantId as userfavvoyantid, imageSrc, ratingAverage,shortDescription, 	contactDescription,name,headerDescription FROM kinthiavoyance_voyants INNER JOIN kinthiavoyance_userfavs ON kinthiavoyance_voyants.voyantId = kinthiavoyance_userfavs.voyantId WHERE userId = '$curentUserid' AND status = '1' ");
          //pass voyantId
            $userFav2= [];
        foreach($userFavs as $userFav){
            $voyantId = $userFav['voyantId'];
            $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
            $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
            $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
           $userFav['nextTimeSlot'] = $this->getVoyantNextTimeSlot($voyantId);
            
            $userFav2[] = $userFav;
    
           
        }
         

         
        $userFavs = $userFav2;
         
        $this->set('userFavs', $userFavs);
        
       
       $this->set('statistic', array(
        'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
    ));


    //get VoyantSkills
    $l = new Criteria();
        
    $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
    $this->set('voyantSkills', $voyantSkills);

    $g = new Criteria();
    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
    $this->set('voyantlanguages', $voyantlanguages);

         
        
        
        
    }
//End Index Function

    //count QuestionAnswer
    public function getCountAnswer($voyantId1){
       
          
        $voyantIdsObj = new Criteria();
        $voyantIdsObj->add('voyantId', $voyantId1);
        $voyantIdsFromUserQuestion = Model::factoryInstance("UserQuestion")->findAll($voyantIdsObj,'voyantId');
          $voyantIdsFromUserQuestion =count($voyantIdsFromUserQuestion);
        return $voyantIdsFromUserQuestion;
       

    }
       

    // save Data to database
    public function saveAction()
    {
        if(isset($this->request->voyantId) && !empty($this->request->voyantId))
        {
            $c = new Criteria();
             
            $c->add('voyantId', $this->request->voyantId);
            $c->add('userId', $this->request->userId);
         

            $voyantIds = Model::factoryInstance("UserFav")->findAll($c);
            //   return print_r($voyantIds[0]['status']);
            //   die();
            if($voyantIds){
                
                $c = new Criteria();
             
            $c->add('voyantId', $this->request->voyantId);
            $c->add('userId', $this->request->userId);
            $statusCheck=$voyantIds[0]['status'];
            
            // return print_r($statusCheck);
            if($statusCheck==1){
         $data = array("status" =>'no');
                 Model::factoryInstance("UserFav")->update($data,$c);
                    // return  $this->redirect(AppRouter::getRewrittedUrl(''));
                 return print_r("remove");

            }
            else{
                $data = array("status" =>'1');
                Model::factoryInstance("UserFav")->update($data,$c);
                return print_r("added");


            }
                   
     }
       else{
        $userfav = new UserFavRecord();
                $userfav->voyantId=$this->request->voyantId;
                $userfav->userId=$this->request->userId;
                $userfav->status='1';
                 
                $userfav->save();
                           return print_r("added");

       }
      

    }
       
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
        foreach ($record as $current_key => $current_array) {
            foreach ($record as $search_key => $search_array) {
                if ($search_array['schedule_date'] == $current_array['schedule_date']) {
                  if ($search_key != $current_key) {                    
                    $result['schedule_date'][$search_array['schedule_date']] = array_merge($search_array['timeslots'],$current_array['timeslots']);
                  }
                }
            }
        }

        //echo "<pre>";print_r($result['schedule_date']);die;
        $currentDate = date('Y-m-d');
        //date_default_timezone_set('Europe/Paris'); 
        $time = date("H:i"); // time in India
        $nextTimeSlot='';
        if(isset($result['schedule_date']) && !empty($result['schedule_date'])){
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

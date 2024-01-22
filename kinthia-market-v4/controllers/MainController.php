<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class MainController extends AppController
{
    public function indexAction() {
        $userid=$this->session->get('userId');

        $this->set('userid', $userid);
        $this->set('action', $this->action);

        // Header View -- topbar settings(Display promo time packs)
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        // Voyant ID array (with busy consulting status)
        $voyantIdArr = [];
        $busyStatQuery = new Criteria();
        $busyStatQuery->add('consultationStatus', 'B');
        $voyantIDs = Model::factoryInstance('Voyant')->findAll($busyStatQuery, 'voyantId');

        foreach ($voyantIDs as $values) {
            foreach ($values as $value) {
                $voyantIdArr[] = $value;
            }
        }
        $this->set('voyantIdArr', json_encode($voyantIdArr));

        // All available consultation options (to filter by voyant consultation)
        $consultations = Model::factoryInstance('Consultation')->findAll();
        $this->set('consultations', $consultations);

        // Voyant Skills available (to filter by voyant skills)
        $voyantSkills = Model::factoryInstance('Skill')->findAll();
        $this->set('voyantSkills', $voyantSkills);

        // Voyants available (to filter by voyant gender)
        $experts = Model::factoryInstance('Voyant')->findAll();
        $expertGender = [];
        foreach ($experts as $item) {
            $expertGender[] = $item['gender'];
        }
        $experts = array_values(array_unique($expertGender));
        $this->set('experts', $experts);

        // Voyant languages available (to filter by voyant languages)
        $voyantlanguages = Model::factoryInstance('Language')->findAll();
        $this->set('voyantlanguages', $voyantlanguages);
    }

    public function expertlistAction ($page = 1) {
        $itemsPerPage = Config::get('voyantsPerPage');

        // Fetch list of experts paginated into the index page from DB
        $expertListQuery = new Criteria();
        $expertListQuery->setCalcFoundRows(true);
        $expertListQuery->setPagination($page, $itemsPerPage);

        // Expert filter action
        if (isset($this->request->filterCriteria)) {
            $filterArr = $this->request->filterCriteria;

            $inputName = array_filter($filterArr, function ( $el ) {
                return $el[ 'type' ] == 'voyantName';
            });

            $expertListQuery->add('name', '%' . $inputName[ 0 ][ 'content' ] . '%', 'LIKE');
        }

        $voyantList = $this->voyant->findAll($expertListQuery);
        $multiplier = 100;

        $arrVoyants = array_map(function ($voyant) use($multiplier) {
            // Phone consulting query
            $consultations = 0;
            $phoneQuery = new Criteria();
            $phoneQuery->add('status', 'E');
            $phoneQuery->add('type', 'phone');
            $phoneQuery->add('voyantId', $voyant['voyantId']);
            $pConsultations = Model::factoryInstance('userConsultation')->findAll($phoneQuery);

            // Web camera consulting query
            $camQuery = new Criteria();
            $camQuery->add('status', 'E');
            $camQuery->add('type', 'webcam');
            $camQuery->add('voyantId', $voyant['voyantId']);
            $cConsultations = Model::factoryInstance('userConsultation')->findAll($camQuery);

            $consultations = count($pConsultations) + count($cConsultations);

            $voyant['priority'] = 0;

            // set each voyant's prior value
            if ($voyant['available'] == 1 &&
                $voyant['displayPhone'] && 
                $voyant['displayWebcam'] && 
                $voyant['displayEmail']) {

                $voyant['priority'] += 7;
            }

            else if ($voyant['available'] == 1 &&
                $voyant['displayPhone'] ||
                $voyant['displayWebcam'] &&
                $voyant['displayEmail']) {

                $voyant['priority'] += 6;
            }

            else if ($voyant['available'] == 1 &&
                $voyant['displayPhone'] ||
                $voyant['displayWebcam']||
                $voyant['displayEmail']) {

                $voyant['priority'] += 4;
            }

            else if (!$voyant['available'] &&
                $voyant['displayEmail']) {
                $voyant['priority'] += 3;
            }

            else if (!$voyant['available'] &&
                $voyant['displayEmail']) {
                $voyant['priority'] += 2;
                $voyant['priority'] *= $multiplier;

                $repository = new repository\VoyantScheduleRepository();
                $day = $repository->getNearestScheduleInDay($voyant['voyantId']);
                $voyant['priority'] += $day;
            }

            else if (!$voyant['available']) {
                $voyant['priority'] += 1;
            }
            
            // This is how to multiple the things
            if (!$voyant['available'] && $voyant['displayEmail']){}
            else{
                $voyant['priority'] *= $multiplier;
            }
            
            $voyant['answeredCount'] = repository\VoyantRepository::getConsultationCount($voyant['voyantId']);
            $voyant['voyantCommentValidatedCount'] = $this->statistic->getVoyantCommentsCountWithStatus($voyant['voyantId'], 1);

            return $voyant;
        }, $voyantList);

        $keys = array_column($arrVoyants, 'priority');
        array_multisort($keys, SORT_DESC, $arrVoyants);

        // Do sorting action
        if (isset($this->request->sortValues)) {
            // Sort by best rated 
            if($this->request->sortValues == 'bestRated') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'ratingAverage', 'desc');
            }
    
            // Sort by availability
            if($this->request->sortValues == '1') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'available', 'desc');
            }
            
            // Sort by webcam, phone and email availability
            if($this->request->sortValues == 'W' || $this->request->sortValues == 'P' || $this->request->sortValues == 'E') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'ratingAverage', 'desc');
                $arrVoyants = helper\VoyantHelper::filterByFeature($arrVoyants, $this->request->sortValues);
            }

            // Default
            if($this->request->sortValues == 'default') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'priority', 'desc');
            }
        }
        
        $this->set('voyants', $arrVoyants);

        // Initialize page naviation
        $totalPages = ceil($this->voyant->getFoundRowsCount() / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/main/index/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page,
                                           'title'       => 'Your arrow text'));
    }

    // public function indexAction($page = 1) {
    //     //get userfav
    //     $userid=$this->session->get('userId');
    //     $userFavObj = new Criteria();
    //     $userFavObj->add('userId',$userid);
    //     $userFavObj->add('status','1');
    //     $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
    //     $userFav = [];

    //     foreach ($voyantIdsFromUserFav as $item) {
    //         $userFav[]= $item['voyantId'];
    //     }

    //     $voyantIdsFromUserFav['userFavIds'] = $userFav;
    //     $this->set('userid', $userid);
    //     $this->set('userFav', $userFav);
        
    //     //$itemsPerPage =1;
    //     $itemsPerPage = Config::get('voyantsPerPage');

    //     $c = new Criteria();
    //     $c->setCalcFoundRows(true);
        
    //     $c->setPagination($page, $itemsPerPage);
    //     $c->add('name', '%' . $this->request->expert . '%', 'LIKE');

    //     // if (isset($this->request->expert)) {
    //     //     // $this->redirect(AppRouter::getRewrittedUrl('/'.$this->request->expert));
    //     //     $voayntNameObj = new Criteria();
    //     //     $voayntNameObj->add('name', '%' . $this->request->expert . '%', 'LIKE');
    //     //     $c->add('name', '%' . $this->request->expert . '%', 'LIKE');
    //     //     $voayntName = Model::factoryInstance('voyant')->findAll($voayntNameObj,'name');
    //     //     // $voyants = Model::factoryInstance('voyant')->findAll($voayntNameObj);
    //     //     if($voayntName) {
    //     //         // $this->set("voyants", $voyants);
    //     //         // $nameVoyant= str_replace(' ', '-', $voayntName[0]['name']);
    //     //         // $this->redirect(AppRouter::getRewrittedUrl('/'.$nameVoyant));
    //     //     } else {
    //     //         echo "<script>alert('Not Found this Expert')</script>";
    //     //     }
    //     // }

    //     // $arrVoyants = array_map(function($voyant) {
    //     //     // Phone consulting filter criteria
    //     //     $consultations = 0;
    //     //     $phoneC = new Criteria();
    //     //     $phoneC->add('status', 'E');
    //     //     $phoneC->add('type', 'phone');
    //     //     $phoneC->add('voyantId', $voyant['voyantId']);
    //     //     $pConsultations = Model::factoryInstance('userConsultation')->findAll($phoneC);

    //     //     // Camera consulting filter criteria
    //     //     $camC = new Criteria();
    //     //     $camC->add('status', 'E');
    //     //     $camC->add('type', 'webcam');
    //     //     $camC->add('voyantId', $voyant['voyantId']);
    //     //     $cConsultations = Model::factoryInstance('userConsultation')->findAll($camC);

    //     //     $consultations = count($pConsultations) + count($cConsultations);

    //     //     $c = new Criteria();
    //     //     $voyantQuestionCriteria = new Criteria();
    //     //     $voyantQuestionCriteria->addOrder('position');
    //     //     $voyantQuestionCriteria->setCalcFoundRows(true);
    //     //     $c->setCalcFoundRows(true);
    //     //     $c->addWithRelation('voyantQuestions', array(
    //     //         'fields'    => 'voyantId, questionId, shortDescription, title, price, urlName, imageSrc',
    //     //         'criteria'  => $voyantQuestionCriteria,
    //     //         'relations' => array(
    //     //             'voyantQuestionPrices' => array(
    //     //                 'fields' => 'questionId, price, quantity, priceId'))));

    //     //     $c->addWithRelation('userQuestions', array(
    //     //         'fields' => 'userquestions.voyantId, userquestions.questionId, count(*) as answeredCount',
    //     //         'relations' => array(
    //     //             'voyantQuestion' => array(
    //     //                 'fields' => 'title'))));

    //     //     $c->add('voyantId', $voyant['voyantId']);
    //     //     $voyant2 = $this->voyant->find($c, 'voyants.*');
    //     //     $voyant['answeredCount'] = $voyant2['userQuestions'][0]['answeredCount'] ?? 0;
    //     //     $voyant['answeredCount'] += $consultations;

    //     //     // get Voyant languages...
    //     //     $d = new Criteria();
    //     //     $d->add('voyantId', $voyant['voyantId']);
    //     //     $voyantlanguages = Model::factoryInstance('voyantLanguage')->findAll($d, "languageId");
    //     //         $voLangId = []; $languageIds = [];
    //     //         if(isset($voyantlanguages) && !empty($voyantlanguages)) {
    //     //             foreach($voyantlanguages as $voLang) {
    //     //                 $voLangId[] =  $voLang['languageId'];
    //     //             }
    //     //             $languageIds = array_values(array_unique($voLangId));
    //     //         }
    //     //         $voyant['languageIds'] = $languageIds;

    //     //         // print_r($voyant['languageIds']);
    //     //         // die();
                
    //     //         //get voyant skills...
    //     //         $k = new Criteria();
    //     //         $k->add('voyantId', $voyant['voyantId']);
    //     //         $voyantSkills = Model::factoryInstance('voyantSkill')->findAll($k, "skillId");
    //     //         $voSkillId = []; $skillIds = [];
    //     //         if(isset($voyantSkills) && !empty($voyantSkills)) {
    //     //            foreach($voyantSkills as $voSkill) {
    //     //                 $voSkillId[] =  $voSkill['skillId'];
    //     //            }
    //     //            $skillIds = array_values(array_unique($voSkillId));
    //     //         }
    //     //         $voyant['skillIds'] = $skillIds;
                 
    //     //         //get voyant fevs
    //     //         //   $userid=$this->session->get('userId');
    //     //         //   $fev_status = $this->getUserFevs($userid,$voyant['voyantId']);  
    //     //         //   die(print_r($fev_status));

    //     //         //get voyant ...
    //     //         $k = new Criteria();
    //     //         $k->add('voyantId', $voyant['voyantId']);
    //     //         $voyants = Model::factoryInstance('Voyant')->findAll($k, "voyantId");
        
    //     //         $voVoyantId = []; $voyantIds = [];
    //     //         if(isset($voyants) && !empty($voyants)) {
    //     //             foreach($voyants as $voVoyant) {
    //     //                 $voVoyantId[] =  $voVoyant['voyantId'];
    //     //             }
    //     //             $voyantIds = array_values(array_unique($voVoyantId));
    //     //         }

    //     //         $voyant['voyantIds'] = $voyantIds;

    //     //     //get voyant next time for consultation...
    //     //     $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant['voyantId']);
    //     //     $voyant['nextTimeSlot'] = $nextTimeSlot;
                
    //     //     //updated voyant profile image
    //     //     $p = new Criteria();
    //     //     $p->add('userId', $voyant['voyantId']);
    //     //     $user = Model::factoryInstance('user')->find($p,"firstGalleryImageSrc");
    //     //     $voyant['firstGalleryImageSrc'] = $user['firstGalleryImageSrc'];
                
    //     //     $voyant['priority'] = 0;

    //     //     // set each voyant's prior value
    //     //     if ($voyant['available'] == 1 &&
    //     //         $voyant['displayPhone'] && $voyant['consultationStatus']=="ON" &&
    //     //         $voyant['displayWebcam'] && 
    //     //         $voyant['displayEmail']) {

    //     //         $voyant['priority'] += 6;
    //     //     }

    //     //     else if ($voyant['available'] == 1 &&
    //     //         $voyant['displayPhone'] && $voyant['consultationStatus']=="ON" ||
    //     //         $voyant['displayWebcam'] && $voyant['consultationStatus']=="ON" &&
    //     //         $voyant['displayEmail']) {

    //     //         $voyant['priority'] += 5;
    //     //     }

    //     //     else if ($voyant['available'] == 1 &&
    //     //         $voyant['displayPhone'] && $voyant['consultationStatus']=="ON" ||
    //     //         $voyant['displayWebcam'] &&
    //     //         $voyant['displayEmail']) {

    //     //         $voyant['priority'] += 3;
    //     //     }

    //     //     else if (!$voyant['available'] &&
    //     //         $voyant['displayEmail']) {

    //     //         $voyant['priority'] += 2;
    //     //     }

    //     //     else if (!$voyant['available']) {
    //     //         $voyant['priority'] += 1;
    //     //     }
            
    //     //     return $voyant;
    //     // }, $this->voyant->findAll($c, 'voyants.*'));

    //     // $arrVoyants = $this->sortByProp($arrVoyants, 'priority', 'desc');
        
    //     // Input name filter
    //     // if (!count($arrVoyants)) {
    //     //     echo "<script>alert('No Experts Found')</script>";
    //     // }

    //     // $this->set('voyants', $arrVoyants);

    //     $voyantIdArr = [];
    //     $k = new Criteria();
    //     $k->add('consultationStatus', "B");
    //     $voyantids = Model::factoryInstance('Voyant')->findAll($k, 'voyantId');
    //     foreach ($voyantids as $key1 => $values) {
    //         foreach ($values as $key2 => $value) {
    //             $voyantIdArr[] = $value;
    //         }
    //     }

    //     $this->set('voyantIdArr', json_encode($voyantIdArr));

    //     $g = new Criteria();
    //     $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
    //     $this->set('voyantlanguages', $voyantlanguages);

    //     $l = new Criteria();
        
    //     $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
    //     $this->set('voyantSkills', $voyantSkills);

    //     // $e = new Criteria();
        
    //     // $expert = Model::factoryInstance('Voyant')->findAll($e);
            
    //     // $expertGender = []; 
    //     //     foreach ($expert as $item) {
    //     //     $expertGender[]= $item['gender'];
    //     // }
    //     // $expert=array_values(array_unique($expertGender));
              
    //     // $this->set('expert', $expert);

    //     $totalPages = ceil($this->voyant->getFoundRowsCount() / $itemsPerPage);

    //     $this->set('pageNavigation', array('baseLink'    => '/main/index/',
    //                                        'totalPages'  => $totalPages,
    //                                        'currentPage' => $page,
    //                                        'title'       => 'Your arrow text'));

    //     $this->set('statistic', array(
    //         'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
    //     ));

    //     $this->set("action",$this->action);
    //     //display promo time packs...
    //     $promoPacks = $this->statistic->promoPacks();
    //     // print_r($promoPacks);
    //     // exit();
    //     $this->set('allPromoPackages', $promoPacks);  

    //     $cons = new Criteria();
    //     $allconsultations = Model::factoryInstance('Consultation')->findAll($cons);
    //     $this->set('allconsultations', $allconsultations);
    // }

    // public function getUserFevs($userid,$voyantId){
    //     $userfavObj = new Criteria();
    //     // $userfavObj->add('voyantId', $voyantId);
    //     // $userfavObj->add('userId', $userid);
          
    //     $userFav = Model::factoryInstance('UserFav')->findAll($userfavObj);
    //     echo "1";
    //     die(print_r($userFav));
    //     return $userFav;
    // }

    public function getVoyantNextTimeSlot($voyantId) {

        if(!empty($voyantId)) {
            $c = new Criteria();
            //$c->add('consultationtypeId',$consultationType['id']);   
            $c->add('voyantId', $voyantId);
            $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
        
            $dateArr = []; $record = [];
            foreach($VoyantDateSchedules as $key=> $dateSchedule) {
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
        if(isset($result['schedule_date']) && !empty($result['schedule_date'])) {
            foreach($result['schedule_date'] as $date => $rest) {
                if($date==$currentDate) {
                     foreach($rest as $k => $res) {
                        if(strtotime($res) > strtotime($time)) {
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

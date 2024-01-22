<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class MainController extends AppController
{
    public function indexAction($page = 1) {
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
            if ($item['gender'] === null) {
                $item['gender'] = "Other";
            }
            $expertGender[] = $item['gender'];
        }
        $experts = array_values(array_unique($expertGender));
        $this->set('experts', $experts);

        // Voyant languages available (to filter by voyant languages)
        $voyantlanguages = Model::factoryInstance('Language')->findAll();
        $this->set('voyantlanguages', $voyantlanguages);

        $itemsPerPage = Config::get('voyantsPerPage');
        $duration = Config::get('expertListRefreshRate');
        if (isset($this->request->itemsPerPage)) {
            $itemsPerPage = $this->request->itemsPerPage;
        }
        $expertListQuery = $this->buildExpertListQuery($page, $itemsPerPage);
        // Expert filter action
        $this->applyExpertFilters($expertListQuery);
        $voyantList = $this->voyant->findAll($expertListQuery);
        // print_r($voyantList);
        $multiplier = 100;
        $arrVoyants = array_map(function ($voyant) use ($multiplier, $duration) {
            $consultations = $this->calculateConsultations($voyant);
            $voyant['priority'] = $this->calculatePriority($voyant, $multiplier, $duration);
            $voyant['consultations'] = $consultations;

            $voyant['answeredCount'] = $this->answeredCounsultation($voyant, $consultations);
            $voyant['voyantCommentValidatedCount'] = $this->statistic->getVoyantCommentsCountWithStatus($voyant['voyantId'], 1);
        
            return $voyant;
        }, $voyantList);
    
        $keys = array_column($arrVoyants, 'priority');
        array_multisort($keys, SORT_DESC, $arrVoyants);

        // Do sorting action
        $arrVoyants = $this->getByProp($arrVoyants);

        // exclude voyant id 0
        foreach ($arrVoyants as $key => $value) {
            if($value['voyantId'] == 0) {
                unset($arrVoyants[$key]);
            }
        }

        $this->set('voyants', $arrVoyants);
    }

    public function expertListAction($page = 1) {
        $itemsPerPage = Config::get('voyantsPerPage');
        $duration = Config::get('expertListRefreshRate');
        if (isset($this->request->itemsPerPage)) {
            $itemsPerPage = $this->request->itemsPerPage;
        }
        $expertListQuery = $this->buildExpertListQuery($page, $itemsPerPage);
        // Expert filter action
        $this->applyExpertFilters($expertListQuery);
        $voyantList = $this->voyant->findAll($expertListQuery);
        // print_r($voyantList);
        $multiplier = 100;
        $arrVoyants = array_map(function ($voyant) use ($multiplier, $duration) {
            $consultations = $this->calculateConsultations($voyant);
            $voyant['priority'] = $this->calculatePriority($voyant, $multiplier, $duration);
            $voyant['consultations'] = $consultations;

            $voyant['answeredCount'] = $this->answeredCounsultation($voyant, $consultations);
            $voyant['voyantCommentValidatedCount'] = $this->statistic->getVoyantCommentsCountWithStatus($voyant['voyantId'], 1);
        
            return $voyant;
        }, $voyantList);
    
        $keys = array_column($arrVoyants, 'priority');
        array_multisort($keys, SORT_DESC, $arrVoyants);

        // Do sorting action
        $arrVoyants = $this->getByProp($arrVoyants);


        // exclude voyant id 0
        foreach ($arrVoyants as $key => $value) {
            if($value['voyantId'] == 0) {
                unset($arrVoyants[$key]);
            }
        }

        usort($arrVoyants, function($a, $b) {
            return $b['priority'] - $a['priority'];
        });


        $this->set('voyants', $arrVoyants);
    
        // Initialize page naviation
        $totalPages = ceil($this->voyant->getFoundRowsCount() / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/main/index/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page,
                                           'title'       => 'Your arrow text'));
    }

    private function buildExpertListQuery($page, $itemsPerPage) {
        $expertListQuery = new Criteria();
        $expertListQuery->setCalcFoundRows(true);
        $expertListQuery->setPagination($page, $itemsPerPage);
    
        return $expertListQuery;
    }
    
    private function applyExpertFilters($expertListQuery) {
        if (isset($this->request->filterCriteria)) {
            $filterArr = $this->request->filterCriteria;

            $conditions = [];
            foreach ($filterArr as $filter) {
                if ($filter['type'] == 'voyantName') {
                    $columns = ['name', 'firstName', 'lastName', 'headerDescription'];
                    $filterValue = $filter['content'];
                    $conditions = [];

                    foreach ($columns as $column) {
                        $conditions[] = [$column, '%' . $filterValue . '%', 'LIKE'];
                    }
                } elseif ($filter['type'] == 'consultation') {
                    if ($filter['content'] == 'phone') {
                        $conditions[] = ['displayPhone', '%' . 1 . '%', 'LIKE'];
                    } elseif ($filter['content'] == 'webcam') {
                        $conditions[] = ['displayWebcam', '%' . 1 . '%', 'LIKE'];
                    } elseif ($filter['content'] == 'email') {
                        $conditions[] = ['displayEmail', '%' . 1 . '%', 'LIKE'];
                    } elseif ($filter['content'] == 'chat') {
                        $conditions[] = ['displayChat', '%' . 1 . '%', 'LIKE'];
                    }
                }
            }
            if (!empty($conditions)) {
                foreach ($conditions as $condition) {
                    $expertListQuery->add($condition[0], $condition[1], $condition[2], 'OR');
                }
            } else {
                return null;
            }
        }
    }

    private function answeredCounsultation($voyant, $consultations)
    {
        $c = new Criteria();
        $voyantQuestionCriteria = new Criteria();
        $voyantQuestionCriteria->addOrder('position');
        $voyantQuestionCriteria->add('displayOnline',1);
        $voyantQuestionCriteria->add('adminValidation',1);
        $voyantQuestionCriteria->setCalcFoundRows(true);

        $c->setCalcFoundRows(true);
        $c->addWithRelation('voyantQuestions', array(
            'fields'    => 'voyantId, questionId, shortDescription, title, price, urlName, imageSrc',
            'criteria'  => $voyantQuestionCriteria,
            'relations' => array(
                'voyantQuestionPrices' => array(
                    'fields' => 'questionId, price, quantity, priceId'))));

        $c->addWithRelation('userQuestions', array(
            'fields' => 'userquestions.voyantId, userquestions.questionId, count(*) as answeredCount',
            'relations' => array(
                'voyantQuestion' => array(
                    'fields' => 'title'))));

        $c->add('voyantId', $voyant['voyantId']);
        $voyant2 = $this->voyant->find($c, 'voyants.*');
        $voyant['answeredCount'] = $voyant2['userQuestions'][0]['answeredCount'] ?? 0;
        $voyant['answeredCount'] += $consultations;

        return $voyant['answeredCount'];
    }
    
    private function calculateConsultations($voyant) {
        $phoneQuery = $this->buildConsultationQuery('E', 'phone', $voyant['voyantId']);
        $webcamQuery = $this->buildConsultationQuery('E', 'webcam', $voyant['voyantId']);
        $chatQuery = $this->buildConsultationQuery('E', 'chat', $voyant['voyantId']);
    
        $pConsultations = Model::factoryInstance('userConsultation')->findAll($phoneQuery);
        $wConsultations = Model::factoryInstance('userConsultation')->findAll($webcamQuery);
        $cConsultations = Model::factoryInstance('userConsultation')->findAll($chatQuery);
        
        return count($pConsultations) + count($wConsultations) + count($cConsultations);
    }
    
    private function buildConsultationQuery($status, $type, $voyantId) {
        $query = new Criteria();
        $query->add('status', $status);
        $query->add('type', $type);
        $query->add('voyantId', $voyantId);
    
        return $query;
    }
    
    private function calculatePriority($voyant, $multiplier, $duration) {
        $priority = 0;

    
        if ($voyant['available'] == 1) {
            // Expert available (logged)
            if ($voyant['displayPhone'] == 1 && $voyant['displayWebcam'] == 1 && $voyant['displayChat'] == 1 && $voyant['displayEmail'] == 1) {
                // audio ON && webcam ON && chat ON && mail ON
                $priority = 100;
            } elseif (($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1) && $voyant['displayChat'] == 1 && $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON && chat ON && mail ON
                $priority = 95;
            } elseif (($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1 || $voyant['displayChat'] == 1) && $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON || chat ON && mail ON
                $priority = 90;
            } elseif ($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1 || $voyant['displayChat'] == 1 || $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON || chat ON || mail ON
                $priority = 85;
            }
            $priority += 1000;
        } elseif ($voyant['available'] == 0 || $voyant['available'] == '') {
            // Expert not available (logged)
            if ($voyant['displayPhone'] == 1 && $voyant['displayWebcam'] == 1 && $voyant['displayChat'] == 1 && $voyant['displayEmail'] == 1) {
                // audio ON && webcam ON && chat ON && mail ON
                $priority = 80;
            } elseif (($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1) && $voyant['displayChat'] == 1 && $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON && chat ON && mail ON
                $priority = 75;
            } elseif (($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1 || $voyant['displayChat'] == 1) && $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON || chat ON && mail ON
                $priority = 70;
            } elseif ($voyant['displayPhone'] == 1 || $voyant['displayWebcam'] == 1 || $voyant['displayChat'] == 1 || $voyant['displayEmail'] == 1) {
                // audio ON || webcam ON || chat ON || mail ON
                $priority = 65;
            }

            if (time() % $duration == 0) {
                $priority += rand(0, 100) / 100;
            }
        }

        $priority += $voyant['priority'] * $multiplier;
        
        return $priority;
    }


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

    /**
     * @param $arrVoyants
     * @return array|mixed
     */
    private function getByProp($arrVoyants)
    {
        if (isset($this->request->sortValues)) {
            // Sort by best rated
            if ($this->request->sortValues == 'bestRated') {
                // SHOW ONLY BEST RATED VOYANTS
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'ratingAverage', 'desc');
            }

            // Sort by availability
            if ($this->request->sortValues == '1') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'available', 'desc');
            }

            // Sort by webcam, phone and email availability
            if ($this->request->sortValues == 'W' || $this->request->sortValues == 'P' || $this->request->sortValues == 'E') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'ratingAverage', 'desc');
                $arrVoyants = helper\VoyantHelper::filterByFeature($arrVoyants, $this->request->sortValues);
            }

            // Default
            if ($this->request->sortValues == 'default') {
                $arrVoyants = helper\VoyantHelper::sortByProp($arrVoyants, 'priority', 'desc');
            }
        }
        return $arrVoyants;
    }
}

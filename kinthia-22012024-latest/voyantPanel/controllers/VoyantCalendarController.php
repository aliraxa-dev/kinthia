<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_VoyantCalendarController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction()
    {
        $consultations = $this->consultation->findAll();
        $this->set('consultations',$consultations);

        $c = new Criteria();
        $consultationTypes = Model::factoryInstance("ConsultationType")->findAll($c);
        $this->set('consultationTypes',$consultationTypes);

        $this->set('voyant', $this->voyant->findByPk($this->userId));

        $this->setStatistic();
    }

    /**
     * save this consultations
     */
    public function saveAction()
    {
        if(isset($this->request->consultaion_type) && !empty($this->request->consultaion_type)){
            // print_r($this->request->consultaion_type);
            // die();
             $c = new Criteria();
             $c->add('consultaion_type', $this->request->consultaion_type, 'IN');
             $consultaionTypes = Model::factoryInstance("ConsultationType")->getArray($c, 'consultaion_type');
            foreach($this->request->consultaion_type as $type){
                if(!in_array($type, $consultaionTypes))
                {
                    $voyant_consult = new ConsultationTypeRecord();
                    $voyant_consult->consultaion_type = $type;
                    $voyant_consult->save(); 
                }

               
                 
            }
        }
      
        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/voyantCalendar/index');
        $this->redirect($redirectUrl);
    }

    /**
    *@param $eid
    */
    public function editAction($eid)
    {
        if(!empty($_GET['sdate']) && !empty($_GET['type'])){
            $type = $_GET['type'];
            $sdate = $_GET['sdate'];
        }else{
            $type = 'next';
            //$sdate = date('Y-m-d');
            $now = new DateTime();
            $now->setTimezone(new DateTimezone('Europe/Paris'));
            $sdate = $now->format('Y-m-d');
        }

        $dates = $this->getWeeksAction($sdate,$type);
        $this->set('dates',$dates);
        $this->set('type',$type);

        $consultationType = $this->consultationType->findByPk($eid);
        $consultation = $this->consultation->findByPk($consultationType['consultaion_type']);
        $this->set('consulType',$consultation['name']);
        $this->set('consultationtypeId',$consultationType['id']);
        $this->set('consultationtypeStatus',$consultationType['status']);
        $minutes = $this->get_minutes('00:00', '23:00');
        $this->set('minutes',$minutes);

        //Calander...
         $record = [];
         $c = new Criteria();
         $c->add('consultationtypeId', $eid);
         $c->add('voyantId', $this->userId);
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
         $this->set('result',$result);

         $this->setStatistic();
    }

    /**
    * Getting weeks
    *@param $date
    *@param $type
    *
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
    * Get minutes
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

    /**
    * update Consultation Status
    */
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
    * save calander data
    */
    public function saveCalanderDataAction(){
        $this->viewClass = 'JsonView';    
         try {
            if($this->request->type=='present'){
                $c = new Criteria();
                $c->add('consultationtypeId', $this->request->consultationtypeId);
                $c->add('voyantId', $this->userId);
                $c->add('schedule_date', $this->request->schedule_date);
                $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);
                 if(count($VoyantDateSchedules)==0){
                    $voyant_schedule = new VoyantDateScheduleRecord();
                    $voyant_schedule->voyantId = $this->userId;
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
                    }
                }
                echo "Time slots availability saved successfully.";
                exit;
            }

            if($this->request->type=='absent'){
         
                 $c = new Criteria();
                 $c->add('consultationtypeId', $this->request->consultationtypeId);
                 $c->add('voyantId', $this->userId);
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
    * delete
    *@param $id
    */
      public function deletAllAction() {
        
        if(isset($this->request->consultaion_ids) && !empty($this->request->consultaion_ids)){
           
              $ids=$this->request->consultaion_ids;
         
           
              
             $c11 = new Criteria();
             $c11->add('id', $ids, 'IN');
            
             Model::factoryInstance('consultationType')->del($c11);
          

            
            
        }
      
        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/voyantCalendar/index');
        $this->redirect($redirectUrl);
      }

    public function deleteAction($id)
    {
        $consultationType = $this->consultationType->findByPk($id);
        if($consultationType){
            //Delete consultation type which voyant added...
             $c = new Criteria();
             $c->add('id', $id);
             Model::factoryInstance('consultationType')->del($c);

             $k = new Criteria();
             $k->add('consultationtypeId', $id);
             $k->add('voyantId', $this->userId);
             $voyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($k);
           
            if($voyantDateSchedules){
                foreach($voyantDateSchedules as $key => $voyantDateSchedule){
                    if(!empty($voyantDateSchedule['id'])){
                        $p = new Criteria();
                        $p->add('voyantdatescheduleId', $voyantDateSchedule['id']);
                        Model::factoryInstance('voyantTimeslot')->del($p);
                    }                    
                }

               // Delete consultation type data in VoyantDateSchedule table...
                $d = new Criteria();
                $d->add('consultationtypeId', $id);
                $d->add('voyantId', $this->userId);
                Model::factoryInstance('VoyantDateSchedule')->del($d);
            }      
             
        }
        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/voyantCalendar/index');
        $this->redirect($redirectUrl);
    }

    public function edittimezoneAction(){
        $timezones = DateHelper::generateTimezone();
        $this->set('timezones',$timezones);
        $this->setStatistic();
    }

    public function savetimezoneAction(){
        $this->voyant->updateByPk(["timezone" => $this->request->timezone], $this->userId);

        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/voyantCalendar/index');
        $this->redirect($redirectUrl);
    }


    private function setStatistic()
    {
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
}
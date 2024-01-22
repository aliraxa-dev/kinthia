<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantReportController extends AppController
{
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
    
    public function recordAction(){
        if(isset($this->request->explainProblem) && !empty($this->request->explainProblem)){
            $userid=$this->session->get('userId');
            $voyantId=$this->request->voyantId;
            $consultantName=$this->request->consultantName;
            $explainProblem=$this->request->explainProblem;
            $voyantReportObj = new VoyantReportRecord();
            $voyantReportObj->voyantId=$voyantId;
            $voyantReportObj->userId=$userid;
            $voyantReportObj->consultantName= $consultantName;
            $voyantReportObj->explainProblem= $explainProblem;
            $c12 = new Criteria();
            $c12->add('voyantId', $voyantId);
            $voyantEmail = Model::factoryInstance('voyant')->find($c12,"email");
            Mailer::getInstance()->sendEmailReport($voyantEmail['email'],'Report ', $explainProblem);
            $voyantReportObj->save();
            if(isset($_SERVER["HTTP_REFERER"])){
                echo "<script>alert('Successfully Send Your Report');window.location = '" . $_SERVER["HTTP_REFERER"] . "';</script>";
            }
            else{
                echo "<script>alert('Successfully Send Your Report');window.location = '/';</script>";
            }
        }
        else{
            if(isset($_SERVER["HTTP_REFERER"])){
                echo "<script>alert('Error on Send Your Report');window.location = '" . $_SERVER["HTTP_REFERER"] . "';</script>";
            }
            else{
                echo "<script>alert('Error on Send Your Report');window.location = '/';</script>";
            }
        }
    }
}

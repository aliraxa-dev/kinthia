<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_AlertController extends AppController
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
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }
    
    public function indexAction()
    {
        // $c = new Criteria();
     
        // $c->addWithRelation('voyanttimeslot', array('fields' => 'timeslots'));
        // $c->addWithRelation('voyant', array('fields' => 'name,imageSrc,headerDescription'));
        // $c->addWithRelation('consultation', array('fields' => 'name'));
        // $demo11 = $this->VoyantDateSchedule->findAll($c);

        $userAlert = $this->UserFav->findAllFav("SELECT kinthiavoyance_voyantdateschedules.id as id, kinthiavoyance_voyanttimeslots.timeslots as timeslots, kinthiavoyance_voyants.name as name,kinthiavoyance_voyants.imageSrc as imageSrc,kinthiavoyance_voyants.headerDescription as headerDescription ,kinthiavoyance_voyantdateschedules.schedule_date as schedule_date, kinthiavoyance_consultations.name as consname  FROM `kinthiavoyance_voyantdateschedules` join kinthiavoyance_consultationtypes on kinthiavoyance_voyantdateschedules.consultationtypeId=kinthiavoyance_consultationtypes.id join kinthiavoyance_consultations on kinthiavoyance_consultations.id=kinthiavoyance_consultationtypes.consultaion_type join kinthiavoyance_voyants on kinthiavoyance_voyants.voyantId=kinthiavoyance_voyantdateschedules.voyantId join  kinthiavoyance_voyanttimeslots on kinthiavoyance_voyantdateschedules.id=kinthiavoyance_voyanttimeslots.voyantdatescheduleId");


        // $newdata=[];
        //          	$i=-1;
        //            foreach($userAlert as $key=>$info){
        //              if(!(isset($newdata[$i]['name']) && $newdata[$i]['name']==$info['name'])){
        //              	$i++;
        //              }
        // $newdata[$i]['id']=$info['id'];
        //              $newdata[$i]['name']=$info['name'];
        //              $newdata[$i]['imageSrc']=$info['imageSrc'];
        //              $newdata[$i]['headerDescription']=$info['headerDescription'];
                    
        //              $newdata[$i]['schedule_date']=$info['schedule_date'];
                
                   
                     
                     
        //              $newdata[$i]['timeslots'][]=$info['timeslots'];
        //              $newdata[$i]['consname'][]=$info['consname'];
                     
        //            }
                   
        //         //    echo "<pre>";
        //         //     print_r($newdata);
        //         //     die();
        //         $this->set('newdata', $newdata);
        $this->set('userAlert', $userAlert);
    
    }

    public function deleteAlertAction($id)
    {
       $voyantScheduleId = $this->voyantDateSchedule->findByPk($id);

       if($voyantScheduleId){
           //Delete Voyant report...
            $c = new Criteria();
            $c->add('id', $id);
            $voyantDateSchedules=Model::factoryInstance('voyantDateSchedule')->del($c);
 
    }
       $redirectUrl = AppRouter::getRewrittedUrl('/user/alert');
       $this->redirect($redirectUrl);
   }
}

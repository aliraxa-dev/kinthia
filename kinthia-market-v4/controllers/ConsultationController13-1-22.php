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
        $userdata = ['name'=>$user['name'],'id'=>$user['userId'],'type'=>'U','room'=>'room-'.$userRequests['userId'].'-'.$userRequests['voyantId'],'requestId'=>$userRequests['userconsultationId'],'voyantId'=>$userRequests['voyantId'],'consultationType'=>$userRequests['type']];

        $this->set('voyant',$voyant);
        $this->set('userRequests',$userRequests);
        $this->set('userdata',json_encode($userdata));   
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
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $consultation = $this->userConsultation->find($c);
    
        $this->set('consultation', $consultation);
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

<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_PrivateMessageController extends AppController
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

        $this->set("userId",$this->session->get('userId'));
        $this->set("action",$this->action);
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        //get user's order voyant emails...
         $expertRecds = $this->getOrderVoyantsEmailIds($this->session->get('userId'));
         $this->set('expertRecds', $expertRecds);

        //get All Voyants of users..
        $voyantIds = $this->getallUsersVoyant();
        $voyantRecords = []; $voyantRecords2 = [];
        $voyantdate = []; $voyantdate2 = [];
        if(isset($voyantIds) && !empty($voyantIds)){
            foreach($voyantIds as $voyantId){
                $k = new Criteria();
                $k->add('voyantId', $voyantId);
                $voyantRecords[] = Model::factoryInstance('voyant')->findAll($k);

                $ks = new Criteria();
                $ks->add('userId', $this->session->get('userId'));
                $ks->add('voyantId', $voyantId);
                $ks->add('sendBy', 'U');
                $ks->addOrder("date DESC");
                $voyantdate2[] = $this->voyantMessage->findAll($ks);
            }

                $ks = new Criteria();
                $ks->add('userId', $this->session->get('userId'));
                $ks->add('voyantId', $voyantIds, 'IN');
                $ks->addOrder("voyantId DESC");
                $ks->addOrder("purchaseDate ASC");
                $voyantdate = Model::factoryInstance("order")->getArray($ks, 'purchaseDate','voyantId');
        }

        $this->set("voyantdate",$voyantdate);
        $this->set("voyantRecords",$voyantRecords);
        $this->set("voyantdate2",$voyantdate2);

       $pendingVoyantEmailsIds = $this->getVoyantEmailIds($this->session->get('userId'));

       $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);

       $c = new Criteria();
       $c->add("userId",$this->session->get('userId'));
       $c->addGroup("voyantmessages.voyantId");
       $c->add("sendby",'U');

       // $c->addOrder("messageId DESC");
       $c->addOrder("date DESC");
       $c->addWithRelation('voyant', array('fields' => 'name,email'));
       $voyantmessages = $this->voyantMessage->findAll($c,"max(voyantmessages.date) as date,voyantmessages.voyantId",true);
       $this->set('voyantmessages',$voyantmessages);









    }

    /**
    * Getting private messages
    */
    public function getPrivateMessageAction(){
        $this->viewClass = 'JsonView';
        try{
            if(!empty($this->request->voyantEmailId)){
                $k = new Criteria();
                $k->add('name', '%'. $this->request->voyantEmailId. '%', 'LIKE');
                $expertRecords = Model::factoryInstance('voyant')->findAll($k);
                $voyantTblRecords = [];
                $voyantId = $expertRecords[0]['voyantId'];
                $voyantImage = $expertRecords[0]['imageSrc'];
                if(!empty($voyantId)){
                    $p = new Criteria();
                    $p->add('voyantId', $voyantId);
                    $voyantTblRecords = Model::factoryInstance('voyant')->findAll($p);

                    $k = new Criteria();
                    $k->add('voyantId', $voyantTblRecords[0]['voyantId']);
                    $k->add('userId', $this->session->get('userId'));
                    $k->add('view', 0);
                    $k->add('sendBy', 'V');
                    $voyantmessage = $this->voyantMessage->findAll($k);
                    $voyantTblRecords[0]['pendingMsg'] = count($voyantmessage);
                 }
                $this->set('voyantTblRecords',$voyantTblRecords[0]);
                return;
            }
        }catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }
    }

    public function indexAction()
    {

    }

    /**
    * Getting details
    *@param $voyantId
    */
    public function detailsAction($voyantId)
    {
        if(!empty($voyantId) && $this->session->get('userId')){

            //update pending msg to normal msg...
            $this->voyantMessage->updateVoyantView($voyantId,$this->session->get('userId'));

            $p = new Criteria();
            $p->add('voyantId', $voyantId);
            $voyant = Model::factoryInstance('voyant')->findAll($p); 
            $this->set("voyant",$voyant[0]);
            $this->set("userId", $this->session->get('userId'));

            //get message data from user and voyant...
            $k = new Criteria();
            $k->add('voyantId', $voyantId);
            $k->add('userId', $this->session->get('userId'));
            $k->addOrder("messageId ASC");
            $voyantmessage = $this->voyantMessage->findAll($k);
            $this->set("voyantmessage",$voyantmessage);
        }
    }

    /**
    * SaveUserMessage
    */
    public function saveUserMessageAction()
    {
        if(!empty($this->request->text) && !empty($this->request->voyantId) && !empty($this->request->userId)){
            $userMessage = new VoyantMessageRecord();
            $userMessage->userId = $this->request->userId;
            $userMessage->voyantId = $this->request->voyantId;
            $userMessage->text = $this->request->text;
            $userMessage->sendBy = 'U';
            $userMessage->save();
            $this->redirect(AppRouter::getRewrittedUrl('/user/privateMessage/details/'.$this->request->voyantId));
        }
    }

    /**
    * Getting voyant email Id's Array
    *@param $userId
    *@return $emails
    */
    function getVoyantEmailIds($userId){
       if(!empty($userId)){
            $k = new Criteria();
            $voyantIds = [];
            $k->add('userId', $userId);
            $k->add('sendBy', 'V');
            $k->add('view', 0);
            $voyantss = $this->voyantMessage->findAll($k);
            foreach($voyantss as $voyant){
                if (!empty($voyant['voyantId'])) {
                    $voyantIds[] = $voyant['voyantId'];
                }
            }
            if(count($voyantIds) > 1){
                $voyantIds = array_values(array_unique($voyantIds));
            }
            $voyantEmails = [];$emails = [];
            if(isset($voyantIds) && !empty($voyantIds)){
                 foreach($voyantIds as $voyantId){
                    $k = new Criteria();
                    // $k->add('userId', $voyantId);
                    // $k->add('role', 'voyant');
                     $k->add('voyantId', $voyantId);
                    $voyantEmails[] = Model::factoryInstance('voyant')->findAll($k, 'name');
                }
            }
            foreach($voyantEmails as $email){
                $emails[] = $email[0]['name'];
            }
           $emails = json_encode($emails);
           return $emails;
       }
    }

    /**
    * Getting order voyant email Ids
    *@param $userId
    *@return $expertRecds
    */
    function getOrderVoyantsEmailIds($userId){
         if(!empty($userId)){
                $d = new Criteria();
                $d->add('userId', $userId);
                $order = Model::factoryInstance('order')->findAll($d);

                if(isset($order) && !empty($order)){
                $voyantIds = [];
                foreach($order as $torder){
                    if (!empty($torder['voyantId'])) {
                        $voyantIds[] = $torder['voyantId'];
                    }
                }
                $voyantIds = array_values(array_unique($voyantIds));
                $expertRecds = [];
                foreach($voyantIds as $voyantId){
                    $k = new Criteria();
                    //$k->add('userId', $voyantId);
                   // $k->add('role', 'voyant');
                   // $expertRecords = Model::factoryInstance('user')->findAll($k);

                    $k->add('voyantId', $voyantId);
                    $expertRecords = Model::factoryInstance('voyant')->findAll($k);
                    foreach($expertRecords as $record){
                        $expertRecds[] = $record['name'];
                    }
                }
                return json_encode($expertRecds);
            }
        }
    }

    /**
    * Getting user's voyant Id's Array
    *@return $voyantIds
    */
    function getallUsersVoyant(){
        $d = new Criteria();
        $d->add('userId', $this->session->get('userId'));
        $d->addOrder("purchaseDate DESC");
        $order = Model::factoryInstance('order')->findAll($d);

        if(isset($order) && !empty($order)){
            $voyantIds = [];
            foreach($order as $torder){
                if (!empty($torder['voyantId'])) {
                    $voyantIds[] = $torder['voyantId'];
                }
            }
            if(count($voyantIds) > 1){
                $voyantIds = array_values(array_unique($voyantIds));
            }
            return $voyantIds;
        }
    }
}
<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_UserMessageController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction()
    {

        $c = new Criteria();
        $c->add("voyantId",$this->userId);
        $c->add("sendby",'U');
        $c->addGroup("voyantmessages.userId");
        // $c->addOrder("messageId DESC");
        $c->addOrder("date DESC");

        if (isset($this->request->email)) {
            $c->add('users.email', '%' . $this->request->email . '%', 'LIKE');
            $c->addOr('users.name', '%' . $this->request->email . '%', 'LIKE');
        }

        $c->addWithRelation('user', array('fields' => 'name,email'));
        $voyantmessages = $this->voyantMessage->findAll($c,"max(voyantmessages.date) as date,voyantmessages.userId,min(voyantmessages.view) as view",true);

        $this->set('voyantmessages',$voyantmessages);

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

    public function detailsAction($userId)
    {
        $userdata = $this->user->findByPk($userId);

        $c = new Criteria();
        $c->add("voyantId",$this->userId);
        $c->add("userId",$userId);
        $c->addOrder("messageId ASC");
        $voyantmessages = $this->voyantMessage->findAll($c,"*",true);
        $this->set('voyantmessages',$voyantmessages);
        $this->set('userdata',$userdata);

        $this->voyantMessage->updateView($userId,$this->userId);
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

    public function sendMessageAction($userId) {
        
        if(!empty($this->request->send_message)){
            $userMessage = new VoyantMessageRecord();
            $userMessage->userId = $userId;
            $userMessage->voyantId = $this->userId;
            $userMessage->text = $this->request->send_message;
            $userMessage->sendBy = 'V';
            $userMessage->save();
            $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/userMessage/details/'.$userId)); 
        }
    }
}

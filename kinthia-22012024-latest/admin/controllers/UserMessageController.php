<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_UserMessageController extends AppController
{
    /**
    * set access privileges
    */
    
    public function pendingAction()
    {
        $c = new Criteria();
        $c->addGroup("voyantmessages.userId,voyantmessages.voyantId");
        $c->addOrder("messageId DESC");

        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $voyantmessages = $this->voyantMessage->findAll($c,"max(voyantmessages.date) as date,voyantmessages.userId,voyantmessages.voyantId",true);
        $this->set('voyantmessages',$voyantmessages);

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsAction($userId,$voyantId)
    {

        $user = $this->user->findByPk($userId);

        $c = new Criteria();
        $c->add("voyantId",$voyantId);
        $c->add("userId",$userId);
        $c->addOrder("messageId ASC");
        $voyantmessages = $this->voyantMessage->findAll($c,"*",true);
        $this->set('voyantmessages',$voyantmessages);
        $this->set('user',$user);
        /**
        * set statistic
        */
        $this->set('voyant', $this->voyant->findByPk($voyantId));

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }
    
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_UserReviewController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction($page = 1)
    {
        
        $c = new Criteria();
        // $c->add("validated",0);
        $c->add("voyantId",$this->userId);
        $c->addOrder("commentId DESC");
        

        //set pagination
        $perPage = 50;
        $totalCount = $this->voyantComment->getCount($c);
       
        $totalPages = ceil($totalCount / $perPage);

        $this->set('pageNavigation', array('baseLink' => 'voyantPanel/userReview/',
                                           'totalPages' => $totalPages,
                                           'currentPage' => $page));
        
        $c->setPagination($page, $perPage);
        $this->set('commentsCount', $totalCount);

        $c->addWithRelation('user', array('fields' => 'name'));
        $comments = $this->voyantComment->findAll($c);
       
        
        $this->set('comments', $comments);
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

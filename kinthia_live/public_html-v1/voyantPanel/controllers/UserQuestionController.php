<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_UserQuestionController extends AppController
{
    /**
    * set access privileges
    */
    function init()
    {
        $this->acl->allow('voyant', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/main/logIn'));
        }
    }
    
    public function pendingAction($page = 1)
    {
        $perPage = 5;
        $c = new Criteria();
        $c->setPagination($page, $perPage);
        $c->add('userquestions.voyantId', $this->userId);
        
        $this->set('userQuestions', $this->userQuestion->getPending($c));
        $totalCount = $this->userQuestion->getFoundRowsCount();

        $this->set('userQuestionsCount', $totalCount);
        $totalPages = ceil($totalCount / $perPage);
        $this->set('pageNavigation', array('baseLink' => '/voyantPanel/userQuestion/pending/',
                                           'totalPages' => $totalPages,
                                           'currentPage' => $page));
        

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
    
    function updateUserQuestionStatusAction()
    {
        if (!empty($this->request->questionIds)
            && in_array($this->request->status, array('answered'))
        ) {
            $c = new Criteria();
            $c->add('questionId', $this->request->questionIds, 'IN');
            $userQuestions = $this->userQuestion->findAll($c, '*', true);
            
            foreach ($userQuestions as $userQuestion) {
                if ($userQuestion->voyantId != $this->userId) {
                    $this->return404();
                }
                
                $userQuestion->status = $this->request->status;
                $userQuestion->save();
            }
        }

        $this->redirect($this->moduleLink('pending'));
    }
    
    public function summaryAction($questionId)
    {
        $userQuestion = $this->userQuestion->getSummaryDetails($questionId);       
        $userQuestion->itemId = $userQuestion->questionId;
        $this->userQuestion->attachPhotos($userQuestion, array('attachOriginalPhotos' => true));

        if ($userQuestion->voyantId != $this->userId) {
            $this->return404();
        }
        $this->set('userQuestion', $userQuestion);
        $this->set('questionId', $questionId);
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
    
    public function saveSummaryAction()
    {
        $userQuestion = $this->userQuestion->findByPk($this->request->questionId);
        if ($userQuestion->voyantId != $this->userId) {
            $this->return404();
        }
        $userQuestion->summary = $this->request->summary;
        $userQuestion->save();
        
        $redirectUrl = AppRouter::getRewrittedUrl('/voyantPanel/user/show/' . $userQuestion->userId);
        $this->redirect($redirectUrl);
    }
}

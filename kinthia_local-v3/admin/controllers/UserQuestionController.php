<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_UserQuestionController extends AppController
{
    /**
    * set access privileges
    */
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }
    }
    
    public function pendingAction($page = 1)
    {
        $perPage = 5;
        $c = new Criteria();
        $c->setPagination($page, $perPage);
        $this->set('userQuestions', $this->userQuestion->getPending($c));
        $totalCount = $this->userQuestion->getFoundRowsCount();

        $this->set('userQuestionsCount', $totalCount);
        $totalPages = ceil($totalCount / $perPage);
        $this->set('pageNavigation', array('baseLink'    => '/admin/userQuestion/pending/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));
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
    
    function updateUserQuestionStatusAction()
    {
        if (!empty($this->request->questionIds)
            && in_array($this->request->status, array('answered', 'delete'))
        ) {
            $c = new Criteria();
            $c->add('questionId', $this->request->questionIds, 'IN');

            if ($this->request->status == 'delete') {
                $this->userQuestion->del($c);
            } else {
                $this->userQuestion->update(array('status' => $this->request->status), $c);
            }
        }

        $this->redirect($this->moduleLink('pending'));
    }
    
    public function summaryAction($questionId)
    {
        $this->set('userQuestion', $this->userQuestion->getSummaryDetails($questionId));

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
    
    public function saveSummaryAction()
    {
        $question = $this->userQuestion->findByPk($this->request->questionId);
        $question->summary = $this->request->summary;
        $question->save();
        
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyant/edit/' . $question->voyantId);
        $this->redirect($redirectUrl);
    }
}

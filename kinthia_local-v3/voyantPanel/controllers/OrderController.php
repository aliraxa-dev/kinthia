<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_OrderController extends AppController
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
        $itemsPerPage = 10;
                               
        $c = new Criteria();
        $c->add('orders.voyantId', $this->userId);
        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $this->set('orders', $this->voyant->getVoyantPendingCheckOrders($c));
        
        $totalCount = $this->order->getFoundRowsCount();
        
        $this->set('pendingCheckOrdersCount', $totalCount);
        $totalPages = ceil($totalCount / $itemsPerPage);

        $this->set('pageNavigation', array('baseLink'    => '/voyantPanel/order/pending/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));
        
        $this->set('voyant', $this->voyant->findByPk($this->userId));

        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId),
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
        )); 
    }
    
    function updateStatusAction()
    {

        if (!empty($this->request->orderIds)
            && in_array($this->request->status, array('paid'))
        ) {
            $c = new Criteria();
            $c->add('orderId', $this->request->orderIds, 'IN');
            $c->add('status', 'pending');
            $orders = $this->order->findAll($c, '*', true);
            foreach ($orders as $order) {
                if ($order->voyantId != $this->userId) {
                    throw new Exception('You have not enought privilages to do this action');
                }                
                $order->setPaid();
            }
        }
        $this->redirect($this->moduleLink('pending'));
    }
}

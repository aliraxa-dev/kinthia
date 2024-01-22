<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class User_CommentController extends AppController
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
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }
    
    public function saveCommentAction()
    {
        $this->viewClass = 'JsonView';
        $orderId = $this->request->orderId;
        $order = $this->order->findByPk($orderId);

        if (empty($order)
            || $order->userId != $this->userId
            || $order->status != 'paid'
        ) {
            return $this->return404();
        }

        $errorMessage = $this->voyantComment->validate($this->request);

        if (empty($errorMessage)) {
            $comment = new VoyantCommentRecord();
            $comment->fromArray($this->request->getArray(array('text',
                                                               'rating')));
            $comment->orderId = $order->orderId;
            $comment->voyantId = $order->voyantId;
            $comment->userId = $order->userId;
            $comment->validated = 0;
            $comment->remoteIp = $this->request->getIp();
            $comment->type = $this->request->type;
            $comment->itemId = $this->request->itemId;
            $comment->save();

            $this->set('status', 'ok');
        } else {
            $this->set('status', 'error');
            $this->set('message', _t($errorMessage));
        }
    }

    public function popupAction($itemId,$orderId,$type=null)
    {
        $order = $this->order->findByPk($orderId);
        if (empty($order) || $order->userId != $this->userId) {
            return $this->return404();
        }
        $this->set('canVote', $this->voyantComment->checkCanVote($orderId,$itemId));
        $this->set('itemId',$itemId);
        $this->set('type',$type);
        $this->set('order', $order);
    }

    public function popupConsultationAction($userconsultationId,$type=null)
    {   
        $userConsultation = $this->userConsultation->findByPk($userconsultationId);
        if (empty($userConsultation) || $userConsultation->userId != $this->userId) {
            return $this->return404();
        }

        $this->set('canVote', $this->voyantComment->checkCanVoteConsultation($userconsultationId));
        $this->set('userconsultationId',$userconsultationId);
        $this->set('type',$type);
        $this->set('userConsultation', $userConsultation);
       
    }

    public function savePlatformCommentAction()
    {
        $this->viewClass = 'JsonView';
        $userconsultationId = $this->request->userconsultationId;
        $userConsultation = $this->userConsultation->findByPk($userconsultationId);
       
        if (empty($userConsultation)
            || $userConsultation->userId != $this->userId
        ) {
            return $this->return404();
        }

        $errorMessage = $this->voyantComment->validateConsultation($this->request);

        if (empty($errorMessage)) {
            $comment = new VoyantCommentRecord();
            $comment->fromArray($this->request->getArray(array('text',
                                                               'rating')));
            $comment->userconsultationId = $userConsultation->userconsultationId;
            $comment->voyantId = $userConsultation->voyantId;
            $comment->userId = $userConsultation->userId;
            $comment->validated = 0;
            $comment->remoteIp = $this->request->getIp();
            $comment->type = $this->request->type;
            $comment->save();

            $this->set('status', 'ok');
        } else {
            $this->set('status', 'error');
            $this->set('message', _t($errorMessage));
        }
    }

}

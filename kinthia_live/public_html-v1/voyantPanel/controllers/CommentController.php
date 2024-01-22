<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantPanel_CommentController extends AppController
{
    /**
     * set access privileges
     */
    public function init()
    {
        $this->acl->allow('voyant', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/main/logIn'));
        }
    }

    /**
     * Update this comment
     */
    public function saveAction()
    {
       // echo "<pre>";print_r($this->request);die;
        $data = $this->request->getArray(array('text', 'replyText'));

        $data['validated'] = '1';
        $voyantComment = $this->voyantComment->findByPk($this->request->commentId);
        
        if ($voyantComment->voyantId != $this->userId) {
            $this->return404();
        }
        
        $voyantComment->fromArray($data);
        $voyantComment->save();
        
        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    /**
     * Delete this comment
     */
    public function deleteAction()
    {
        $voyantComment = $this->voyantComment->findByPk($this->request->commentId);
        
        if ($voyantComment->voyantId != $this->userId) {
            $this->return404();
        }
        
        $voyantComment->del();

        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class Admin_CommentController extends AppController
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

    /**
     * Update this comment
     */
    public function saveAction()
    {
        $data = $this->request->getArray(array('text', 'rating', 'date'));
        $data['validated'] = '1';
        $this->voyantComment->updateByPk($data, $this->request->commentId);

        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    /**
     * Update this comment
     */
    public function updateAction()
    {
        $data = $this->request->getArray(array('text', 'rating'));
        $this->voyantComment->updateByPk($data, $this->request->commentId);
        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    /**
     * publish this comment
     */
    public function publishAction()
    {
        $data['validated'] = 1;
        $this->voyantComment->updateByPk($data, $this->request->commentId);
        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    /**
     * unpublish this comment
     */
    public function unpublishAction()
    {
        $data['validated'] = '0';
        $this->voyantComment->updateByPk($data, $this->request->commentId);
        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }
    
    /**
     * Delete this comment
     */
    public function deleteAction()
    {
        $this->voyantComment->delByPk($this->request->commentId);

        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }

    /**
     * Ban comment ip
     */
    public function banIpAction()
    {
        $bannedIp = new BannedIpRecord();
        $bannedIp->remoteIp = $this->request->remoteIp;
        $bannedIp->save();

        $this->set('status', 'OK');
        $this->viewClass = 'JsonView';
    }
}

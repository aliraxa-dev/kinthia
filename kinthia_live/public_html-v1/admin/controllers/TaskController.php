<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class Admin_TaskController extends AppController
{
    private $backgroundTask;

    function init()
    {
        $this->acl->allow('administrator', $this->name, '*');
        $this->acl->allow('guest', $this->name, 'start');
        $this->acl->allow('guest', $this->name, 'nextStart');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }

        if (in_array($this->request->taskId, array('newsletter'))) {
            $className = ucfirst($this->request->taskId) . 'BackgroundTask';
            $this->backgroundTask = new $className();
        }

        $this->viewClass = 'JsonView';
    }

    function getStatusAction()
    {
        $this->set($this->backgroundTask->getStatus());
    }

    function pauseAction()
    {
        $this->set('result', $this->backgroundTask->pause());
    }

    function resumeAction()
    {
        $this->set('result', $this->backgroundTask->resume());
    }

    function stopAction()
    {
        $this->set('result', $this->backgroundTask->stop());
    }

    function startAction()
    {
        $this->backgroundTask->start();
    }

    function nextStartAction()
    {
        $this->backgroundTask->nextStart();
    }

    function initAction()
    {
        $this->backgroundTask->init();
        $this->backgroundTask->fork($this->moduleLink('start'));
    }
}

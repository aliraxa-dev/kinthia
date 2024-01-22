<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_ManagementController extends AppController
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
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);
    }
    
    /**
    * Redirect to managment panel
    */
    public function indexAction()
    {
        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }
}

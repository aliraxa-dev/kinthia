<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/**
 * Class ContactController
 */
class PopupController extends AppController
{

	/*
    public function alertAction($id)
    {
        $c = new Criteria();
       
        $c->add('voyantId', $id);
        
        $voyantEmail = Model::factoryInstance("voyant")->find($c,'email');   
        $this->set('voyantEmail',$voyantEmail);
        
        $mailToVoyant=Mailer::getInstance()->sendEmailVoyantOnline($voyantEmail['email'],'alert',"M'alerter par email de son retour");

        $this->set('mailToVoyant',$mailToVoyant);

         
    }
	*/
	public function alertAction()
    {


         
    }
    

}

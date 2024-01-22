<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class ConsultationController extends AppController
{
    public function indexAction($voyantId,$type)
    {
       if(!empty($voyantId) && !empty($type)){
            $voyant = $this->voyant->findByPk($voyantId);
            $this->set('expertName',$voyant['name']);
            $this->set('type',$type);
        }  
    }

    public function startAction($voyantId,$type)
    {
        if(!empty($voyantId) && !empty($type)){
            $voyant = $this->voyant->findByPk($voyantId);
            $this->set('expertName',$voyant['name']);
            $this->set('type',$type);
        }     
    }
    public function endedAction()
    {
        
    }
}

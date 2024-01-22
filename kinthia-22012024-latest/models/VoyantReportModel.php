<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantReportModel extends Model
{
       
    protected $primaryKey = "id";
 
    protected $relations = array('user' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'userId'),
                                 'voyant' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'voyantId'));
   

}

class VoyantReportRecord extends ModelRecord
{
    function save()
    {
        
        parent::save();
    }

}

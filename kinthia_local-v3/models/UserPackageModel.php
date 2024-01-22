<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserPackageModel extends Model
{   
    protected $primaryKey = 'packId';
    
    protected $relations = array('user' => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'userId'),                                                            
                                 'package' => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'packageId',
                                                           'localKey'   => 'packageId'),
                                                           
                                 'order'          => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'orderId'));
}    
    
class UserPackageRecord extends ModelRecord
{
    public function save()
    {
        parent::save();
    }
}

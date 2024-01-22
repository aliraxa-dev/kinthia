<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class PlatformInvoiceModel extends Model
{
    protected $primaryKey = "platformId";

    protected $relations = array('platformInvoice' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'platformId'),
                                 'voyant' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'order' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                );
//     public function getFields()
//     {
//         return array('platformId', 'voyantId', 'invoicePlatformNumber');
//     }
    
    // public function validate()
    // {
    //     return '';
    // }
}

    class PlatformInvoiceRecord extends ModelRecord
    {
        public function save()
        {
            parent::save();
        }
    }

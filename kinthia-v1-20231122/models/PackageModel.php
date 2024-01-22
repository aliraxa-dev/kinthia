<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class PackageModel extends Model
{   
    protected $primaryKey = "packageId";
    
    // protected $relations = array('voyantQuestionPrices' => array('type'       => 'oneToMany',
    //                                                              'foreignKey' => 'questionId'),
    //                              'voyant'               => array('type'       => 'oneToOne',
    //                                                             'foreignKey' => 'voyantId'));
    
    public function getFields()
    {
        return array('packageId', 'packageName', 'packageDescription', 'packageTime', 'packagePrice', 'packageBarredPrice', 'packagePromo', 'packagePromoMsg', 'packageDisplay', 'createdAt', 'updatedAt');
    }
    
    public function validate()
    {
        return '';
    }
}

    class PackageRecord extends ModelRecord
    {
        
    
    }

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class OrderItemModel extends Model
{
    protected $primaryKey = "itemId";
    protected $relations = array('voyantQuestion' => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'questionId',
                                                           'localKey'   => 'itemId'),

                                  'package'       => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'packageId',
                                                           'localKey'   => 'packId')
                                                   );
}

class OrderItemRecord extends ModelRecord
{
    public function __construct($data)
    {
      $insertarray = [];
      $insertarray['quantity'] = $data['quantity'].'||'. $data['voyantId'];
      $insertarray['totalPrice'] = $data['totalPrice'];
      
      if($data['type']=='TimePack') {
        $insertarray['packId'] = $data['itemId'];
      } 

      if($data['type']=='VoyantQuestion'){
        $insertarray['itemId'] = $data['itemId'];
      }

      parent::__construct($insertarray);
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class ConsultationModel extends Model
{   
    protected $primaryKey = "id";
    
    // protected $relations = array('voyantQuestionPrices' => array('type'       => 'oneToMany',
    //                                                              'foreignKey' => 'questionId'),
    //                              'voyant'               => array('type'       => 'oneToOne',
    //                                                             'foreignKey' => 'voyantId'));
    
    public function getFields()
    {
        return array('id', 'name', 'created_at', 'updated_at');
    }
    
    public function validate()
    {
        return '';
    }

    public function getVoyantConsultations($consIdArr){
        
        $d = new Criteria();
       if(isset($consIdArr) && !empty($consIdArr)){           
           $d->add('id', $consIdArr, 'IN');
           $voyantConsultations = Model::factoryInstance("Consultation")->findAll($d,  'id, name', true);            
       }else{
        $voyantConsultations = Model::factoryInstance("Consultation")->findAll($d);
       } 
       return $voyantConsultations;     
   }
}

    class ConsultationRecord extends ModelRecord
    {
        
    
    }

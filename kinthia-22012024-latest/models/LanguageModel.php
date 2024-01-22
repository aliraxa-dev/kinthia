<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class LanguageModel extends Model
{   
    protected $primaryKey = "languageId";
    
    // protected $relations = array('voyantQuestionPrices' => array('type'       => 'oneToMany',
    //                                                              'foreignKey' => 'questionId'),
    //                              'voyant'               => array('type'       => 'oneToOne',
    //                                                             'foreignKey' => 'voyantId'));
    
    public function getFields()
    {
        return array('languageId', 'language', 'languageCode', 'languageFlag',
                     'created_at', 'updated_at');
    }
    
    public function validate()
    {
        return '';
    }
    public function getVoyantLanguages($langIdArr){
        
        $d = new Criteria();
       if(isset($langIdArr) && !empty($langIdArr)){           
           $d->add('languageId', $langIdArr, 'IN');
           $voyantLanguages = Model::factoryInstance("Language")->findAll($d,  'languageId, language', true);            
       }else{
        $voyantLanguages = Model::factoryInstance("Language")->findAll($d);
       } 
       return $voyantLanguages;     
   }
   
}

    class LanguageRecord extends ModelRecord
    {
         function del()
        {
            $c = new Criteria();
            $c->add('languageId', $this->languageId);
            Model::factoryInstance('voyantLanguage')->del($c);
                    
            parent::del();
        }
    
    }

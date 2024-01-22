<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantQuestionModel extends Model
{   
    protected $primaryKey = "questionId";
    
    protected $relations = array('voyantQuestionPrices' => array('type'       => 'oneToMany',
                                                                 'foreignKey' => 'questionId'),
                                 'voyant'               => array('type'       => 'oneToOne',
                                                                 'foreignKey' => 'voyantId'));
    
    public function getFields()
    {
        return array('voyantId', 'title', 'shortDescription', 'longDescription',
                     'price', 'metaTitle', 'metaDescription', 'headerDescription',
                     'navigationName','displayOnline','adminValidation');
    }
    
    public function validate()
    {
        return '';
    }
}

class VoyantQuestionRecord extends ModelRecord
{
    public function updateUrlName($voyant)
    {
        $this->urlName = $voyant['urlName'] . '\\' . NameTool::strToAscii($this->title);
    }
    
    public function save()
    {
        if(!empty($this->voyantId)){
            $voyant = Model::factoryInstance('voyant')->findByPk($this->voyantId, 'urlName');
            $this->updateUrlName($voyant);
            parent::save();
        }        
    }
}
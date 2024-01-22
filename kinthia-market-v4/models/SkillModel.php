<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class SkillModel extends Model
{   
    protected $primaryKey = "skillId";
    
    // protected $relations = array('voyantQuestionPrices' => array('type'       => 'oneToMany',
    //                                                              'foreignKey' => 'questionId'),
    //                              'voyant'               => array('type'       => 'oneToOne',
    //                                                             'foreignKey' => 'voyantId'));
    
    protected $relations = array('voyantQuestions' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                                            
                                 'userQuestions'   => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                                            
                                 'voyantComments'  => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantSkills' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantLanguage' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantConsultation' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId')

                             );

                             public function findAllSkill($data1)
                             { 
                                 
                                 $results = $this->db->sqlGetAll($data1);
                                 return $results;
                         
                             }
                          

    public function getFields()
    {
        return array('skillId', 'name', 'slug', 'title',
                     'metaDescription','metaRobots','breadcrumb','h1_tag','longDescription','longDescription2','createPage','createdAt','updatedAt');
    }
    
    public function validate()
    {
        return '';
    }

    public function getVoyantSkills($skillIdArr){
        
         $d = new Criteria();
        if(isset($skillIdArr) && !empty($skillIdArr)){           
            $d->add('skillId', $skillIdArr, 'IN');
            $voyantSkills = Model::factoryInstance("Skill")->findAll($d,  'skillId, name', true);            
        }else{
            $voyantSkills = Model::factoryInstance("Skill")->findAll($d);
        } 
        return $voyantSkills;     
    }
    
}

    class SkillRecord extends ModelRecord
    {
        function setTitle($title)
        {
            $this->title = $title;
            return $this;
        }

        function del()
        {
            $c = new Criteria();
            $c->add('skillId', $this->skillId);
            Model::factoryInstance('voyantSkill')->del($c);
                    
            parent::del();
        }
    
    }

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserConsultationModel extends Model
{   
    protected $primaryKey = "userconsultationId";

    protected $relations = array('user'   => array('type'       => 'oneToOne',
                                                   'foreignKey' => 'userId'),
                                 'voyant'   => array('type'       => 'oneToOne',
                                                    'foreignKey' => 'voyantId'),
                                  'userQuestions' => array('type'       => 'oneToMany',
                                                          'foreignKey' => 'userId')
                                );
    
    public function getFields()
    {
        return array('userconsultationId', 'userId', 'voyantId','type','room','status','duration','date');
    }
    
    public function validate()
    {
        return '';
    }

    public function getActiveUser($voyantId = 0)
    {
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add("status", "A");
        $result = Model::factoryInstance("userconsultation")->find($c);
        
        if(isset($result['userId'])){
            return $result['userId'];
        }
        else{
            return 0;
        }
    }

    public function getActiveStartSession($voyantId = 0)
    {
        $c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add("status", "A");
        $result = Model::factoryInstance("userconsultation")->find($c);
        
        if(isset($result['start_time'])){
            return $result['start_time'];
        }
        else{
            return;
        }
    }
}

class UserConsultationRecord extends ModelRecord
{
    

}


<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantMessageModel extends Model
{
    protected $primaryKey = 'messageId';
    protected $relations = array('user' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'userId'),
                                 'voyant' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'voyantId'));
    
    public function updateView($userId,$voyantId)
    {
    	$c = new Criteria();
        $c->add("voyantId",$voyantId);
        $c->add("userId",$userId);
        $c->add("sendby",'U');
        $data = array("view"=>1);
    	$this->update($data,$c);
    }

    public function updateVoyantView($voyantId, $userId)
    {
    	$c = new Criteria();
        $c->add("voyantId", $voyantId);
        $c->add("userId", $userId);
        $c->add("view", 0);
        $c->add("sendBy", 'V');
        $data = array("view"=>1);
    	$this->update($data,$c);
    }
}

class VoyantMessageRecord extends ModelRecord
{

	public function save()
    {
       parent::save();
    }
}

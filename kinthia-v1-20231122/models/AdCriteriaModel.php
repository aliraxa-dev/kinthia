<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class AdCriteriaModel extends Model
{   
    protected $primaryKey = "adCriterionId";
    
    function getSelectList()
    {
        return (array("0" => "ad off") + $this->getArray(null, "name"));  
    }
    
    function del(Criteria $c)
    {
        $condition = $c->getCondition("adCriterionId");
        
        $nc = new Criteria();
        $nc->addCondition($condition);
        
        parent::del($c);
        
        Model::factoryInstance("ad")->del($nc);
    }
}

class AdCriteriaRecord extends ModelRecord
{
    
}

?>
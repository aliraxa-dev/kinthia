<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserFavModel extends Model
{   
    
    protected $primaryKey = "id";
   
    
 
    
 
    public function findAllFav($data1)
    { 
        
        $results = $this->db->sqlGetAll($data1);
        return $results;

    }
 
    
 
  
}

class UserFavRecord extends ModelRecord
{
    function save()
    {
       

        // var_dump($this->birthdayDate); die;
        parent::save();
    }
    

    
     
}

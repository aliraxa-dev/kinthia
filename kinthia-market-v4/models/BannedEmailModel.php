<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class BannedEmailModel extends Model
{   
    protected $primaryKey = "banId";
    
    function isBanned($email)
    {
        if(empty($email))return true;
        
        $bannedEmails = $this->findAll(null, "email");
        
        foreach($bannedEmails as $bannedEmail)
        {
            if(preg_match("#^".str_replace("\\*", ".*", preg_quote($bannedEmail['email']))."$#i", $email))
                return true;  
        }
        
        return false;
    }
}

class BannedEmailRecord extends ModelRecord
{
    
}

?>
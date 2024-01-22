<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class BannedIpModel extends Model
{   
    protected $primaryKey = "banId";
            
    function isBanned($ip)
    {
        if(empty($ip))return true;
        
        $bannedIps = $this->findAll(null, "remoteIp");
        
        foreach($bannedIps as $bannedIp)
        {
            if(preg_match("#^".str_replace("\\*", ".*", preg_quote($bannedIp['remoteIp']))."$#i", $ip))
                return true;  
        }
        
        return false;
    }
}

class BannedIpRecord extends ModelRecord
{
    
}

?>
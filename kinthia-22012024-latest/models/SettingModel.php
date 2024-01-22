<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class SettingModel extends Model
{
    protected $primaryKey = "`key`";

    function set($key, $value)
    {
        $this->updateByPk(array("value" => $value), $key);
    }
    function get($what, Criteria $c = null)
    {
       return parent::get($what, $c);
    }
}

class SettingRecord extends ModelRecord
{

}

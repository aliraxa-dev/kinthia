<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserTimeSlotModel extends Model
{   
    protected $primaryKey = "id";
}

class UserTimeSlotRecord extends ModelRecord
{

    public function save()
    {
        parent::save();
    }

   

}
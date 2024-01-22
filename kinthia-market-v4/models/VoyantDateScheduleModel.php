<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantDateScheduleModel extends Model
{   
    protected $primaryKey = "id";

    // protected $relations = array('voyantTimeSlots' => array('type'       => 'oneToMany',
    //                                                         'foreignKey' => 'voyantdatescheduleId')

    //                          );
}


class VoyantDateScheduleRecord extends ModelRecord
{

    public function save()
    {
        parent::save();
    }

   

}
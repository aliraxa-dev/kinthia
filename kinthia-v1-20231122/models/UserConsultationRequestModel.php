<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserConsultationRequestModel extends Model
{   
    protected $primaryKey = "id";

    protected $relations = array('user'   => array('type'       => 'oneToOne',
                                                   'foreignKey' => 'userId'),
                                );
    
    public function getFields()
    {
        return array('id', 'userId', 'voyantId','consultationType','consultationTime','consultationDate','userRequestStatus','created_at');
    }
    
    public function validate()
    {
        return '';
    }
}

class UserConsultationRequestRecord extends ModelRecord
{
    

}

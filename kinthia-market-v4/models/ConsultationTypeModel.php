<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class ConsultationTypeModel extends Model
{   
    protected $primaryKey = "id";
        
    public function getFields()
    {
        return array('id', 'consultaion_type', 'created_at', 'updated_at');
    }
    
    public function validate()
    {
        return '';
    }
}

    class ConsultationTypeRecord extends ModelRecord
    {
        
        function del()
        {
            parent::del();
        }
    }

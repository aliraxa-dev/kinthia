<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantConsultationModel extends Model
{   
    protected $primaryKey = "id";

   
}


class VoyantConsultationRecord extends ModelRecord
{

    public function save()
    {
        parent::save();

    }

    function del()
    {
        // $c = new Criteria();
        // $c->add('voyantId', $this->voyantId);
        // // Model::factoryInstance('voyantQuestion')->del($c);
        // // Model::factoryInstance('voyantComment')->del($c);
        
        parent::del();
    }

}
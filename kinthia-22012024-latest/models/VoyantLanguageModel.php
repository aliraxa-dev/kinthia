<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantLanguageModel extends Model
{   
    protected $primaryKey = "languageId";

   
}


class VoyantLanguageRecord extends ModelRecord
{

    public function save()
    {
        parent::save();

    }

}
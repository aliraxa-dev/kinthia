<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantQuestionPriceModel extends Model
{   
    protected $primaryKey = "priceId";
    
    function extractQuestionPrices($voyantQuestions)
    {        
        $questionPrices = array();
        
        foreach ($voyantQuestions as $voyantQuestion) {
            $current =& $questionPrices[$voyantQuestion['questionId']];
            $current[] = array('quantity' => 1, 'price' => $voyantQuestion['price']);
            foreach($voyantQuestion['voyantQuestionPrices'] as $voyantQuestionPrice) {
                $current[] = array('quantity' => $voyantQuestionPrice['quantity'],
                                   'price'    => $voyantQuestionPrice['price']);
            }
        }
        
        return $questionPrices;
    }
}

class VoyantQuestionPriceRecord extends ModelRecord
{

}
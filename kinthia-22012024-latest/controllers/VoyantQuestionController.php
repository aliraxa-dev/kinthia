<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class VoyantQuestionController extends AppController
{
    public function detailsAction($questionId, $urlName)
    {
        $c = new Criteria();

        if (!empty($questionId)) {
            $c->add('voyantquestions.questionId', $questionId);
        } else {
            $c->add('voyantquestions.urlName', $urlName);
        }

        $c->addWithRelation('voyantQuestionPrices', array(
                                'fields' => 'questionId, price, quantity, priceId'));

        $c->addWithRelation('voyant', array(
                                'fields' => 'voyantId, name, title, urlName, navigationName, displayPhone, displayChat, displayWebcam, displayEmail, consultationStatus, consultationTime'));

        $voyantQuestion = $this->voyantQuestion->find($c, 'voyantquestions.*');

        if (empty($voyantQuestion) || ($voyantQuestion['displayOnline']==0 || $voyantQuestion['adminValidation']==0)) {
            $this->return404();
        }
        if (empty($voyantQuestion['voyant']['displayEmail'])) {
            $this->return404();
        }

        $questionPrices = $this->voyantQuestionPrice->extractQuestionPrices(array($voyantQuestion->toArray()));
        $this->set('questionPrices', JsonView::php2js($questionPrices));
        $this->set('voyantQuestion', $voyantQuestion);
    }
}

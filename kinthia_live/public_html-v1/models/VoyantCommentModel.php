<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantCommentModel extends Model
{
    protected $primaryKey = 'commentId';
    protected $relations = array('user' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'userId'),
                                 'voyant' => array('type'=>'oneToOne',
                                                 'foreignKey' => 'voyantId'));

    function insert($data)
    {
        parent::insert($data);
        $voyantId = $data['voyantId'];
        $this->updateVoyantRatingAverage($voyantId);
    }

    function update($data, Criteria $c)
    {
        parent::update($data, $c);

        $comment = $this->find($c);
        $voyantId = $comment->voyantId;

        $this->updateVoyantRatingAverage($voyantId);
    }

    function del(Criteria $c, $updateStats = true)
    {
        if ($updateStats) {
            $voyantIds = array_unique($this->getArray($c, 'voyantId'));
        }

        parent::del($c);

        if ($updateStats) {
            foreach ($voyantIds as $voyantId) {
                $this->updateVoyantRatingAverage($voyantId);
            }
        }
    }
    
    function checkCanVote($orderId,$itemId)
    {
        $c = new Criteria();
        $c->add('orderId', $orderId);
        $c->add('itemId', $itemId);
         
        return ($this->getCount($c) == 0);
    }

    function checkCanVoteConsultation($userconsultationId)
    {
        $c = new Criteria();
        $c->add('userconsultationId', $userconsultationId);
        return ($this->getCount($c) == 0);
    }

    function validate($newComment)
    {
        if (!$this->checkCanVote($newComment->orderId,$newComment->itemId)) {
            return 'You have already commented this order item.';
        }
        
        if ((int)$newComment->rating < 1 || (int)$newComment->rating > 5) {
            return 'Rating must be in range 1-5';
        }

        return '';
    }

    function validateConsultation($newComment)
    {
        if (!$this->checkCanVoteConsultation($newComment->userconsultationId)) {
            return 'You have already commented this consultation item.';
        }
        return '';
    }
    
    function updateVoyantRatingAverage($voyantId)
    {
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->add('validated', '1');

        $ratingData = $this->find($c, 'SUM(rating) as ratingSum, COUNT(rating) as ratingCount');
        
        if ($ratingData['ratingCount']) {
            $ratingAverage = $ratingData['ratingSum'] / $ratingData['ratingCount'];
        } else {
            $ratingAverage = 0;
        }

        $data = array('ratingAverage'  => $ratingAverage);

        $this->voyant->updateByPk($data, $voyantId);
    }
}

class VoyantCommentRecord extends ModelRecord
{

}

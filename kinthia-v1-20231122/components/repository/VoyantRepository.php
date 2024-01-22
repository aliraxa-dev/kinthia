<?php

namespace repository;

use Criteria;
use Model;

class VoyantRepository extends Model
{
    public static function getConsultationCount($voyantId)
    {
        $criteria = new Criteria();
        $criteria->add('voyantId',$voyantId);
        $criteria->add('status', 'E');
        $answeredCount = Model::factoryInstance("UserQuestion")->findAll($criteria);
        return count($answeredCount);
    }
}

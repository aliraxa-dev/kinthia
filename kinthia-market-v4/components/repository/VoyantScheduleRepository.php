<?php

namespace repository;

use Criteria;
use Model;

class VoyantScheduleRepository extends Model
{

    public function getNearestScheduleInDay($voyantId)
    {
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->add('schedule_date', date("Y-m-d"), ">=");
        $c->addOrder("schedule_date asc");
        $voyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);

        $record = [];
        foreach ($voyantDateSchedules as $key => $dateSchedule) {
            $c = new Criteria();
            $c->add('voyantdatescheduleId', $dateSchedule['id'], 'IN');
            $voyantTimeslots = Model::factoryInstance("voyantTimeslot")->getArray($c, 'timeslots');
            if ($voyantTimeslots) {
                $temp = [];
                $temp['schedule_date'] = $dateSchedule['schedule_date'];

                $start_date = new \DateTime();
                $since_start = $start_date->diff(new \DateTime($dateSchedule['schedule_date']));
                return $since_start->days;
            }
        }

        return 0;
    }
}

<?php
class TimeslotHelper
{
    public static function transformToCalendar($dateTimeSlots)
    {
        $calendar = [];

        foreach ($dateTimeSlots as $date => $timeslots) {
            sort($timeslots);
            $startEnd = [];
            if (count($timeslots) == 1) {
                $datetime = new \DateTime();
                $datetime->setTimestamp($timeslots[0]);
                $datetime->modify('+30 Min');

                $startEnd[] = date("H:i", $timeslots[0]);
                $startEnd[] = $datetime->format("H:i");
                $calendar[$date][] = $startEnd;
            } else {
                foreach ($timeslots as $key => $time) {
                    $theTime = date("H:i", $time);
                    if ($key == 0) {
                        $startEnd = [];
                        $startEnd[] = date("H:i", $time);
                    } else {
                        if (isset($timeslots[$key + 1])) {
                            $timeDiff = $timeslots[$key + 1] - $time;
                            if ($timeDiff > 1800) {
                                $startEnd[] = date("H:i", $time);

                                if(count($startEnd) == 1){
                                    $startEnd[] = date("H:i", $time);
                                }
                            }
                            else{
                                if(count($startEnd) == 0){
                                    $startEnd[] = date("H:i", $time);
                                }
                            }
                        } else {
                            // If only one array left at between array
                            if(count($startEnd) == 1){
                                $startEnd[] = date("H:i", $time);
                            }

                            // If only one array left at the end
                            if(count($startEnd) == 0){
                                $startEnd[] = date("H:i", $time);
                                $startEnd[] = date("H:i", $time);
                            }
                        }
                    }
                    

                    // Push start and end array if good
                    if (count($startEnd) == 2) {
                        $datetime = new DateTime($startEnd[1]);
                        $datetime->modify('+30 Min');
                        $startEnd[1] = $datetime->format("H:i");
                        $calendar[$date][] = $startEnd;
                        $startEnd = [];
                    }
                }
            }
        }

        return $calendar;
    }
}

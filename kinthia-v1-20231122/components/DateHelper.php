<?php

class DateHelper
{
    public static function generateTimezone()
    {
        $timezone_identifiers = DateTimeZone::listIdentifiers(DateTimeZone::ALL);

        $results = [];
        $region = "";
        foreach ($timezone_identifiers as $key => $val) {
            $temp = explode("/", $val);

            if (empty($region)) {
                $region = $temp[0];
                $results["region_$key"] = $temp[0];
            } else {
                if ($temp[0] != $region) {
                    $region = $temp[0];
                    $results["region_$key"] = $temp[0];
                }
                
                $results[$val] = $val;
            }
        }

        return $results;
    }
}

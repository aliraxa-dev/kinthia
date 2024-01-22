<?php

namespace helper;

class VoyantHelper
{
    public static function sortByProp($arr, $strprop, $sortOrder)
    {
        if ($sortOrder == 'asc') {
            usort($arr, fn ($a, $b) => strcmp($a[$strprop], $b[$strprop]));
        } else if ($sortOrder == 'desc') {
            usort($arr, fn ($a, $b) => strcmp($b[$strprop], $a[$strprop]));
        }

        return $arr;
    }

    public static function filterByFeature($arr, $filter)
    {
        $filterArr = ["W" => "displayWebcam", "P" => "displayPhone", "E" => "displayEmail"];

        $result = [];
        foreach($arr as $val){
            $key = $filterArr[$filter];
            if($val[$key] == 1){
                $result[] = $val;
            }
        }

        if(empty($result)) return $arr;
        else return $result;
    }
}

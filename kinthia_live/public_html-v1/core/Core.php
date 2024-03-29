<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


require_once (Config::get("CORE_PATH") . "Loader.php");

// PHP 7.2
spl_autoload_register(function($class) {
    Loader::loadClass($class);
});

/**
 * Get phrase translation
 * @param string $phrase to Translate
 * @lang  string $lang Destination language
 */
function _t($phrase, $lang = null)
{
    return Translate::getInstance($lang ? $lang : Config::get("language"))->getPhrase($phrase);
}

function utf8_htmlspecialchars($string)
{
    return htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
}

function utf8_substr($string, $start, $length)
{
    return preg_replace('#^(?:[\x00-\x7F]|[\xC0-\xFF][\x80-\xBF]+){0,' . $start . '}' . '((?:[\x00-\x7F]|[\xC0-\xFF][\x80-\xBF]+){0,' . $length . '}).*#s', '$1', $string);
}

function utf8_strlen($string)
{
    return strlen(utf8_decode($string));
}

function array_map_recursive($func, $arr)
{
    $newArr = array();

    foreach ($arr as $key => $value) {
        $newArr[$key] = (is_array($value) || $value instanceof ArrayAccess) ? array_map_recursive($func, $value) : call_user_func($func, $value);
    }

    return $newArr;
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class which load required models, views, core files
 */
class Loader
{
    private static $coreClasses = array("ErrorHandler" => "",
                                        "Controller" => "",
                                        "FrontController" => "",
                                        "Router" => "",
                                        "AutoComponent" => "",
                                        "CoreObject" => "",
                                        "Session" => "",
                                        "Request" => "",
                                        "DataAggregator" => "",
                                        "NameTool" => "",
                                        "View" => "",
                                        "Model" => "",
                                        "ModelRecord" => "",
                                        "Database" => "",
                                        "DbMapper" => "",
                                        "Criteria" => "",
                                        "Translate" => "",
                                        "Acl" => "",
                                        "Cacher" => "",
                                        "Response" => "");

    public static function loadModel($className)
    {
        $file = Config::get("MODELS_PATH") . self::classNameToFile($className);
        return self::loadFile($file);
    }

    public static function loadView($className)
    {
        $file = Config::get("VIEWS_PATH") . self::classNameToFile($className);
        return self::loadFile($file);
    }

    public static function loadComponent($className)
    {
        $file = Config::get("COMPONENTS_PATH") . self::classNameToFile($className);
        return self::loadFile($file);
    }

    public static function loadController($className)
    {
        $file = Config::get("CONTROLLERS_PATH") . self::classNameToFile($className);
        return self::loadFile($file);
    }

    public static function loadCore($className)
    {
        $file = Config::get("CORE_PATH") . self::classNameToFile($className);
        return self::loadFile($file);
    }

    public static function loadFile($file)
    {
        $file = str_replace("\\", "/", $file);
        require_once ($file);
        return true;
    }

    public static function classNameToFile($className)
    {
        return $className . ".php";
    }

    public static function loadClass($className)
    {
        if (isset(self::$coreClasses[$className])) {
            return self::loadCore($className);
        }

        if (substr_compare($className, "Controller", -10) == 0) {
            return self::loadController($className);
        }

        if (substr_compare($className, "Model", -5) == 0) {
            return self::loadModel($className);
        }

        if (substr_compare($className, "Record", -6) == 0) {
            $className = substr($className, 0, -6) . "Model";
            return self::loadModel($className);
        }

        if (substr_compare($className, "View", -4) == 0) {
            return self::loadView($className);
        }

        return self::loadComponent($className);
    }
}

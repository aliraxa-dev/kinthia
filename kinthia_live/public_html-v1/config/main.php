<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Config
{
    static $confVars = array();
    
    public static function get($name, $defaultValue = null)
    {
        return self::$confVars[$name];
    }
    
    public static function set($name, $value)
    {
        self::$confVars[$name] = $value;
    }
    
    public static function getAll()
    {
        return self::$confVars;
    }
    
    public static function add($confVars)
    {
        self::$confVars = array_merge(self::$confVars, $confVars);
    }
}

class Display
{
    static $confVars;
    
    public static function get($name, $defaultValue = null)
    {
        return isset(self::$confVars[$name]) ? self::$confVars[$name] : $defaultValue;
    }
    
    public static function set($name, $value)
    {
        self::$confVars[$name] = $value;
    }
    
    public static function getAll()
    {
        return self::$confVars;
    }
}

Config::set('DEFAULT_LANGUAGE', "en");
Config::set('DEFAULT_TEMPLATE_NAME', "arfooo");
Config::set('DEFAULT_CHARSET', "utf8");

Config::set('CONTROLLERS_PATH', CODE_ROOT_DIR."controllers/");
Config::set('MODELS_PATH', CODE_ROOT_DIR."models/"); 
Config::set('VIEWS_PATH', CODE_ROOT_DIR."views/"); 
Config::set('CORE_PATH', CODE_ROOT_DIR."core/"); 
Config::set('TEMPLATES_PATH', CODE_ROOT_DIR."templates/");
Config::set('COMPONENTS_PATH', CODE_ROOT_DIR."components/");
Config::set('LANGUAGES_PATH', CODE_ROOT_DIR."languages/");

// If you want use smtp
Config::set('SMTP_ENABLE', true);
Config::set('SMTP_HOST', 'smtp.gmail.com');
Config::set('SMTP_SECURE', 'ssl');
Config::set('SMTP_USERNAME', 'candyjohn05@gmail.com');
Config::set('SMTP_PASSWORD', 'sqkswqxsfaxkclle');
Config::set('SMTP_PORT',465);

// Config::set('SMTP_ENABLE', true);
// Config::set('SMTP_HOST', 'in-v3.mailjet.com');
// Config::set('SMTP_SECURE', 'ssl');
// Config::set('SMTP_USERNAME', '2fe4a265e4bd54c8d5594b3041b9e055');
// Config::set('SMTP_PASSWORD', 'e1489ce9c7869a5444761ee509b2d9fa');
// Config::set('SMTP_PORT', 465);
Config::set('SITES_THUMBS_PATH', CODE_ROOT_DIR."uploads/images_thumbs/");
Config::set('PACKAGES_THUMBS_PATH', CODE_ROOT_DIR."uploads/images_packages/");


Config::set('cdnSwitcher', false);
Config::set('cdnRootUrl', 'https://cdn.omygod.co');

Config::set('VOYANT_REVIEW_LIMIT', 1);
Config::set('VOYANT_AUDIO_PRESENTATION_LIMIT', 5); //Size in MB

require_once(CODE_ROOT_DIR."config/db.php");

if(!empty($dbConfig['DB_INSTALLED']))
{
    foreach($dbConfig as $key => $value)
    {
        Config::set($key, $value);
    }
}
else
{
    $url = substr($_SERVER['SCRIPT_NAME'], 0, -strlen(basename($_SERVER['SCRIPT_NAME'])))."install";
    header("Location: $url");
    exit;
}

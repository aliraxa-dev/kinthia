<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class which handle request
 */
class Response extends CoreObject
{
    private static $instance = null;

    /**
     * Returns an instance of Response object
     * @return Response
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    public function setCookie($name, $value, $expire = 0)
    {
        setcookie($name, $value, $expire, Config::get('cookiePath'), Config::get('cookieDomain'));
    }
}

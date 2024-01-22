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
class Request extends DataAggregator
{
    private static $instance = null;

    /**
     * Returns an instance of Request object
     * @return Request
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /**
     * Generates the standard request object
     */
    public function __construct()
    {
        $this->removeMagicGpc();
        parent::__construct($_POST);
    }

    /**
     * Get request value or false if not exists
     * @param  string $key Key of value which should be returned
     * @return string|boolean
     */
    public function get($key)
    {
        if (!isset($this->data[$key])) {
            return false;
        }
        return $this->data[$key];
    }

    function stripSlashesRecursive($oldArray)
    {
        $newArray = array();

        foreach ($oldArray as $key => $value) {
            $newArray[stripslashes($key)] = (is_array($value)) ? $this->stripSlashesRecursive($value) : stripslashes($value);
        }

        return $newArray;
    }

    private function removeMagicGpc()
    {
        $phpVersion = phpversion();
        $phpVersionCorrect = version_compare($phpVersion, "5.4", "<"); 

        if ($phpVersionCorrect) {
            if (get_magic_quotes_gpc()) {
                $_POST = $this->stripSlashesRecursive($_POST);
                $_GET = $this->stripSlashesRecursive($_GET);
                $_COOKIE = $this->stripSlashesRecursive($_COOKIE);
            }
        }
    }

    public function getArray($fields)
    {
        $results = array();

        foreach ($fields as $key) {
            $results[$key] = $this->get($key);
        }

        return $results;
    }

    /**
     * Checks value is defined and isn't empty string
     * @param  string $key Key which should be checked
     * @return boolean
     */
    public function hasValue($key)
    {
        if (!isset($this->data[$key])) {
            return false;
        }
        if ($this->data[$key] === "") {
            return false;
        }
        return true;
    }

    /**
     * Returns http referer url
     * @return string
     */
    public function getRefererUrl()
    {
        return isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : false;
    }

    public function getIp()
    {
        return $_SERVER['REMOTE_ADDR'];
    }

    public function getCookie($name)
    {
        return isset($_COOKIE[$name]) ? $_COOKIE[$name] : false;
    }
    
    public function getCurrentUrl()
    {
        return $_SERVER['REQUEST_URI'];
    }

    public function isAjax() {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
    }

}

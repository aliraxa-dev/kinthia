<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class which handle Access Control List
 */
class Acl extends CoreObject
{
    private static $instance = null;
    private $allows = array();

    /**
     * Returns an instance of Acl object
     *
     * @return Acl
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /**
     * Add permission for $role to $controller->$method
     *
     * @param string $role User role
     * @param string $controller Name of controller which contain method
     * @param string $method Method for which we set permission
     */
    public function allow($role, $controller, $method)
    {
        $this->allows[$role][$controller][$method] = true;
    }

    /**
     * Check that user with $role have access to specified controller method
     *
     * @param string $role User role
     * @param string $controller Name of controller which containt method
     * @param string $method Method name to check access
     */
    public function isAllowed($role, $controller, $method)
    {
        if (in_array($role, array("administrator", "moderator", "webmaster"))) {
            $refererUrl = Request::getInstance()->getRefererUrl();
            $siteRootUrl = Config::get("siteRootUrl");

            if ($refererUrl) {
                if (strncmp($siteRootUrl, $refererUrl, strlen($siteRootUrl)) != 0) {
                    return $this->isAllowed("guest", $controller, $method);
                }
            }
        }

        if (!empty($this->allows[$role][$controller]["*"])) {
            return true;
        }

        $access = !empty($this->allows[$role][$controller][$method]);

        if (!$access && $role != "guest") {
            return $this->isAllowed("guest", $controller, $method);
        }

        return $access;
    }

}

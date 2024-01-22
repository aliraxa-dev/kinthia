<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class to handle PHP Session feature
 */
class Session extends CoreObject
{
    private static $instance = null;

    /**
     * Returns an instance of Session object
     * @return Session
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /**
     * Generates the standard Session object
     */
    private function __construct()
    {
        session_start();
        if ($this->get("role") == "administrator"
            || $this->loginUser($this->get("email"), $this->get("password"), "email", $this->get("role"))) {
            /* verified */
        } else {
            $request = Request::getInstance();

            if ($request->getCookie("rememberMe")
                && $this->loginUser($request->getCookie("email"), $request->getCookie("password"))) {
            /* verified */
            } else {
                $this->set("userId", 0);
                $this->set("role", "guest");
            }
        }

        $this->getConsultationPhoneTypeCount();
        $this->getConsultationWebcamTypeCount();
        $this->getTotalUserConsultationCounts();
    }

    /**
     * Login user and store user informations in session
     * @param  string $login User login
     * @param  string $pass User password
     * @param  string $mode authorization method email/login
     * @param  string $role webmaster/administrator/admin
     * @return boolean
     */
    function loginUser($login, $password, $mode = "email", $role = "webmaster")
    {
        if (empty($login)) {
            return false;
        }

        // echo "<pre>";
        // print($login);
        // die();
        $users = new UserModel();

        $c = new Criteria();

        if ($mode == "login") {
            $c->add("login", $login);
        } else {
            $c->add("email", $login);
        }

        $c->add("password", $password);
        $c->add("role", $role);
        $c->add("active", "1");
        
        $row = $users->find($c);
       
        if (!empty($row)) {
            foreach ($row as $key => $value) {
                $this->set($key, $value);
            }

            if (empty($row['login'])) {
                $this->set("login", $row['email']);
            }

            return true;
        }

        return false;
    }

    /**
     * Delete session variable
     * @param string $key Name of key which should be deleted
     */
    public function del($key)
    {
        unset($_SESSION[$key]);
    }

    /**
     * Get session variable
     * @param string $key Name of variable
    */
    public function getConsultationPhoneTypeCount(){
       
        $userConsultation = new UserConsultationModel();       
            $c = new Criteria();
            $c->add('userId', $_SESSION['userId']);
            $c->add('status', 'E');
            $c->add('type', 'phone');
            $userConsultations = $userConsultation->findAll($c);            
            $this->set('userPhoneConsultationCounts', count($userConsultations));   
            
    }

    public function getConsultationWebcamTypeCount(){
       
        $userConsultation = new UserConsultationModel();       
            $c = new Criteria();
            $c->add('userId', $_SESSION['userId']);
            $c->add('status', 'E');
            $c->add('type', 'webcam');
            $userConsultations = $userConsultation->findAll($c);            
            $this->set('userWebcamConsultationCounts', count($userConsultations));   
    }

    public function getTotalUserConsultationCounts(){
       
        $total = 0;
        if(isset($_SESSION['userPhoneConsultationCounts']) && !empty($_SESSION['userPhoneConsultationCounts']) || isset($_SESSION['userWebcamConsultationCounts']) && !empty($_SESSION['userWebcamConsultationCounts'])){

            $total = $_SESSION['userPhoneConsultationCounts'] + $_SESSION['userWebcamConsultationCounts'];

        }        
        $this->set('totalConsultationUserCount', $total);   
    }

    /**
     * Set session variable
     * @param string $key Name of variable
     * @param string $value Value
     */
    public function set($key, $value)
    {
        $_SESSION[$key] = $value;
    }

    /**
     * Get session variable
     * @param string $key Name of variable
     */
    public function get($key)
    {
        return isset($_SESSION[$key]) ? $_SESSION[$key] : false;
    }

   

    /**
     * Destroy session, unset all variables
     */
    public function destroy()
    {
        $_SESSION = array();

        if (isset($_COOKIE[session_name()])) {
            Response::getInstance()->setCookie(session_name(), '', time() - 42000, '/');
        }

        session_destroy();
    }

    /**
     * Return array with session variables
     */
    public function toArray()
    {
        return $_SESSION;
    }

   
}

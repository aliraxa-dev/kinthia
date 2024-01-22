<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Basic class which give error handlers to every object
 */
class CoreObject
{
    private $error;

    /**
     * Set error message
     * @param string $msg error message
     * @return boolean
     */
    protected function throwError($msg)
    {
        echo $msg;
        return $this->setLastError($msg);
    }

    /**
     * Retrieve last error from object
     * @return string
     */
    public function getLastError()
    {
        return $this->error;
    }

    protected function setLastError($msg)
    {
        $this->error = $msg;
        return false;
    }
}

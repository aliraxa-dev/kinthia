<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Abstract class View from MVC design pattern
 */
abstract class View extends CoreObject
{
    /**
     * Abstract function which must be overwrited to display View values
     */
    abstract public function render($controller);
}

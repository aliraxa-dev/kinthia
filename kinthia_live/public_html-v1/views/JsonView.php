<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class JsonView extends View
{
    public static function php2js($a)
    {
        if ($a instanceof ArrayAccess) {
            return json_encode($a->toArray());
        } else {
            return json_encode($a);
        }
    }

    public function render($controller)
    {
        return self::php2js($controller->viewVars);
    }
}

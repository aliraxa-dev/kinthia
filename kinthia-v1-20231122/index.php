<?php die(44);
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

define('CODE_ROOT_DIR', realpath(dirname(__FILE__)).'/');
require_once(CODE_ROOT_DIR.'core.php');

$front = FrontController::getInstance();
$front->setRouter(new AppRouter());
$front->dispatch();

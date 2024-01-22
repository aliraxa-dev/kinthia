<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////
                 
$script_start_time = microtime(true);

ini_set("display_errors", "on");
ini_set("url_rewriter.tags","");
error_reporting(E_ALL);

require_once(CODE_ROOT_DIR."config/main.php");  
require_once(CODE_ROOT_DIR."core/Core.php");
$eh = new ErrorHandler();
$eh->start();

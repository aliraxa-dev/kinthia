<?php

$routes = array("^admin.*"       => array("executeDir" => "admin"),
                "^voyantPanel.*" => array("executeDir" => "voyantPanel"),
                "^user.*"        => array("executeDir" => "user"),
                ".*"             => array("executeDir" => ""));
               
                                   
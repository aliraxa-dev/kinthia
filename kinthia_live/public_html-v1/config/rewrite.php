<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

$rewrites = array(
'#^/voyant-p(\d+)\.html$#' => '/main/index/\1',
'#^/(.*)-p(\d+)\.html$#' => '/voyant/details//\1/\2',
);

$reverseRewrites = array (
'#^/main/index/1#' => '/',
'#^/main/index/(\d+)#' => '/voyant-p\1.html',
'#^/voyant/details/(\d+)/(.*)/1#' => '/\2/',
'#^/voyant/details/(\d+)/(.*)/(\d+)#' => '/\2-p\3.html',
'#^/voyant/details/(\d+)/(.*)#' => '/\2/',
'#^/voyantQuestion/details/(\d+)/(.*)#' => '/\2.html',
);
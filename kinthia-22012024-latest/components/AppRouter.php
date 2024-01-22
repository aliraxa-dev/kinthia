<?php

class AppRouter extends Router
{
    public function __construct()
    {
        parent::__construct();

        if (Config::get('urlRewriting')) {
            self::addRewrites(CODE_ROOT_DIR . 'config/rewrite.php');
        }
    }
	
	public function getControllerActionUrl($url)
    {
        $urlParts = @parse_url($url);

        if (!empty($urlParts['query']) && !empty($urlParts['path'])) {
            $filters = array_map('preg_quote', array('gclid*'));

            foreach ($filters as &$filter) {
                $filter = str_replace('\\*', '.*', $filter);
            }
            $pattern = '#^(?:' . implode('|', $filters) . ')$#';
            if (preg_match($pattern, $urlParts['query'])) {
                $url = $urlParts['path'];
            }
        }
        return parent::getControllerActionUrl($url);
    }

    public static function getResourceUrl($url, $absolute = true)
    {
        switch ($url) {
            case '/uploads/images_categories/':
            case '/uploads/images_categories/defaultCategoryImage.gif':
                $url = '/templates/' . Config::get('templateName') . '/images/defaultCategoryImage.gif';
                break;

            case '/uploads/images_thumbs/default.jpg':
                $url = '/templates/' . Config::get('templateName') . '/images/default.jpg';
                break;
        }

        return parent::getResourceUrl($url, $absolute);
    }

    public static function getCdnUrl($url)
    {
        return parent::getCdnUrl($url);
    }


    public static function getObjectUrl($object, $type, $absolute = false)
    {
        switch ($type) {

            case 'voyantDetails':
                $urlParts = array('/voyant/details/%d/%s',
                                  $object['voyantId'],
                                  $object['urlName']);

                break;
                
            case 'voyantQuestionDetails':
                $urlParts = array('/voyantQuestion/details/%d/%s',
                                  $object['questionId'],
                                  $object['urlName']);

                break;
                
            case 'voyantComments':
                $urlParts = array('/comment/voyantComment/%d/%s',
                                  $object['voyantId'],
                                  $object['urlName']);

                break;

            case 'voyantReport':
                $urlParts = array('/voyantReport/report/%d/%s',
                                  $object['voyantId'],
                                  $object['urlName']);

                break;
        }

        $url = AppRouter::getRewrittedUrl($urlParts);

        if ($absolute) {
            $url = Config::get('siteDomainUrl') . $url;
        }

        return $url;
    }

    public static function getHostNameFromUrl($url)
    {
        $urlParts = @parse_url($url);
        if (!empty($urlParts['host'])
            && !empty($urlParts['scheme'])
            && $urlParts['scheme'] == 'http'
        ) {
            return $urlParts['scheme'] . '://' . $urlParts['host'];
        } else {
            return '';
        }
    }
    
    public function defaultHandler($url)
    {
        $urlParts = explode('/', preg_replace('#\.html$#', '', $url));
        
        if (!empty($urlParts[1])) {
            $dispathUrl = '/voyantQuestion/details//' . $urlParts[0] . '\\' . $urlParts[1];
        } else {
            $dispathUrl = '/voyant/details//' . $urlParts[0];
        }
        
        FrontController::getInstance()->dispatch($dispathUrl);

        return true;
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class HttpClient
{
    public $additionalServerUrl;
    
    function getSiteContent($url, $header = true, $body = true, $canRedirect = false, $method = "GET", $postData = "")
    {
        $ch = curl_init();
        
        if($this->additionalServerUrl)
        {
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_URL, $this->additionalServerUrl);
            curl_setopt($ch, CURLOPT_POSTFIELDS, array("url" => $url)); 
        }
        else
        {
            curl_setopt($ch, CURLOPT_URL, $url); 
        }
        
        if($method == "POST")
        {
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        }
        
        if($canRedirect)
        {
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_MAXREDIRS, 1);
        }
        
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, $header);
        if ($body === false) {
        	curl_setopt($ch, CURLOPT_NOBODY, true);
		}
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4');
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
 
        $siteContent = curl_exec($ch);
        return $siteContent;  
    }
    
    function pingSite($url)
    {
        $urlParts = parse_url($url);
        $fp = fsockopen($urlParts['host'], 80);
        $query = "POST ".$urlParts['path']." HTTP/1.0\r\n"
                    ."Host: ".$urlParts['host']."\r\n"
                    ."Connection: close\r\n\r\n";

        fwrite($fp, $query);
        fclose($fp);
    }
    
    function checkResponseCodeOfSite($url)
    {
        $siteContent = $this->getSiteContent($url);
        $responseCode = preg_match('#^HTTP/1.1 (\d+)#', $siteContent, $m) ? $m[1] : 0;
        return $responseCode;
    }
    
    function checkBacklinkOnSite($url, $backlink)
    {
        if(!preg_match("#^http://.+#", $url))return false;
        $backlink = rtrim($backlink, "/");

        $siteContent = $this->getSiteContent($url);
        if(preg_match('#<meta[^>]*nofollow#i', $siteContent))return false;
         
        $backlinkExists = ($siteContent && (strpos($siteContent, 'href="'.$backlink) !== false));
        
        return $backlinkExists;    
    }
    
    function getMetaValues($url)
    {
        $resultSet = array('title' => '',
                            'description' => '',
                            'author' => '',
                            'content-type' => '');
        
        $siteContent = $this->getSiteContent($url);
        
        if (!$siteContent)return $resultSet;
        
        // get title
        $resultSet['title'] = (preg_match("#<title>(.*?)</title>#", $siteContent, $matches)) ? $matches[1] : '';

        // get meta tags            
        preg_match_all("#<meta.*?>#", $siteContent, $matches);
        $metaTags = $matches[0];
        
        // iterate all meta tags
        foreach($metaTags as $metaTag)
        {
            preg_match_all('#(name|http-equiv|content)="(.*?)"#i', $metaTag, $attributes, PREG_SET_ORDER);
            
            $propertyName = '';
            $propertyValue = '';
            
            // iterate all attributes of this meta tag 
            foreach($attributes as $attribute)
            {
                switch(strtolower($attribute[1]))
                {
                    case 'name':
                    case 'http-equiv':
                    
                        $propertyName = strtolower($attribute[2]);
                        break;
                    
                    case 'content':
                    
                        $propertyValue = $attribute[2];
                        break;
                }
            }
            
            if($propertyName && $propertyValue && isset($resultSet[$propertyName]))
            {
                $resultSet[$propertyName] = $propertyValue;  
            }
        }
        
        $charset = "iso-8859-1";
         
        if(preg_match("#charset=([\w-]+)#i", $resultSet['content-type'], $match))
        {
            $charset = $match[1];
        }
        
        foreach($resultSet as $key => $value)
        {
            $utfValue = @iconv($charset, "utf-8//ignore", $value);

            $resultSet[$key] = ($utfValue === false) ? utf8_encode($value) : $utfValue; 
       
            
        }
        
        return $resultSet;    
    }
} 
?>

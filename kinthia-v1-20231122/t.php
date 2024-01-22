<?php

$header = false;
$body = true;

$url = "https://www.sandbox.paypal.com/cgi-bin/webscr";
           $method = "POST";
$postData = "cmd=_notify-validate&mc_gross=5.00&protection_eligibility=Ineligible&item_number1=&payer_id=UDGLHC638LQGQ&tax=0.00&payment_date=08%3A17%3A04+Mar+10%2C+2012+PST&payment_status=Completed&charset=windows-1252&mc_shipping=0.00&mc_handling=0.00&first_name=Test&mc_fee=0.55&notify_version=3.4&custom=1305&payer_status=verified&business=seller_1260539400_biz%40gmail.com&num_cart_items=1&mc_handling1=0.00&verify_sign=Au-cSEYNE8LMjhx.kf-LUqXc5E1-ASOuieluuxUaACAHMEDZUC2t2hQt&payer_email=buyer_1260539357_per%40gmail.com&mc_shipping1=0.00&tax1=0.00&txn_id=04F63124YS804350T&payment_type=instant&last_name=User&item_name1=R%E9ponse+par+oui+ou+non+avec+le+pendule&receiver_email=seller_1260539400_biz%40gmail.com&payment_fee=&quantity1=1&receiver_id=72WBESDTRZCE8&txn_type=cart&mc_gross_1=5.00&mc_currency=EUR&residence_country=FR&test_ipn=1&transaction_subject=1305&payment_gross=&ipn_track_id=ecfaa62aedae8";

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_HEADER, $header);
        //curl_setopt($ch, CURLOPT_NOBODY, !$body);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4');
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);

        $siteContent = curl_exec($ch);
        var_dump($siteContent);


        echo "<br><br><br>";
        require_once('components/HttpClient.php');
        $httpClient = new HttpClient();
$siteContent = $httpClient->getSiteContent($url, false, true, false, "POST", $postData);
var_dump($siteContent);


$method = "POST";

$canRedirect = false;

        $ch = curl_init();


            curl_setopt($ch, CURLOPT_URL, $url);

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
        curl_setopt($ch, CURLOPT_NOBODY, !$body);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4');
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);

        $siteContent = curl_exec($ch);
        return $siteContent;

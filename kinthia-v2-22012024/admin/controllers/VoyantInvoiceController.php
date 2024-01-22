<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_VoyantInvoiceController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction()
    {   
        $email = null;
        if(!empty($this->request->email)){
             $email = $this->request->email;
        }
        $totOrderNumbersArr = $this->totOrderNumbersArr($email);
        $this->set("totOrderNumbersArr", $totOrderNumbersArr);

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function totOrderNumbersArr($email){
        $c = new Criteria();
        $c->addOrder("purchaseDate DESC");              
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, paymentExpertPlatform'));
       

        if (isset($email)) {
            $c->add('email', '%' . $email . '%', 'LIKE');
            $c->addOr('name', '%' . $email . '%', 'LIKE');
        }
        $c->addWithRelation('voyant', array('fields' => 'name,email')); 
        $c->add('paymentExpertPlatform', 1 , "<");
        $orders = Model::factoryInstance('order')->findAll($c);
        
        $orderArr = []; $totalOrderCounter = []; $totalOrderPendingCounter = [];
        if(isset($orders) && !empty($orders)){
            foreach($orders as $key => $order){
                $onlyDate = date('Y-m-d', strtotime($order['purchaseDate']));
                $orderArr[][$onlyDate] = $order;
                //$totalOrderCounter[$onlyDate][] = $onlyDate."||".$order['name']."||".$order['email'];
                $totalOrderCounter[$onlyDate][] = $order['name']." - ".$order['email'];

                //get Pending /Unpaid Orders...
                if($order['status']=='unpaid' || $order['status']=='pending'){
                    $totalOrderPendingCounter[$onlyDate][] = $onlyDate."||".$order['name']."||".$order['email'];
                }
            }
        }
        
        //getTotal Orders Counter...
        $totPendingOrderNumbersArr = [];
        if(isset($totalOrderPendingCounter) && !empty($totalOrderPendingCounter)){
            foreach($totalOrderPendingCounter as $key => $order){
                $totPendingOrderNumbersArr[$key] = sizeof($totalOrderPendingCounter[$key]);
            }
        }
        
        //getTotal Orders Counter...
         $totOrderNumbersArr = []; $orderArr = [];
         if(isset($totalOrderCounter) && !empty($totalOrderCounter)){
            foreach($totalOrderCounter as $key => $orders){
                $totOrderNumbersArr[$key][] = sizeof($totalOrderCounter[$key]);
                $totOrderNumbersArr[$key][] = array_unique($orders);               

                if(isset($totPendingOrderNumbersArr) && !empty($totPendingOrderNumbersArr)){
                    foreach($totPendingOrderNumbersArr as $key2 => $pendingOrder){
                        if($key==$key2){
                            $totOrderNumbersArr[$key]['pendingCount'] = $pendingOrder;
                        }
                    }
                }
             }
         }
         return $totOrderNumbersArr;
    }

    public function pendingAction()
    {
        //get Previous Month Orders... 
        $myOrders = Array();
        $myListOrders = Array();
        $myListConsultations = Array();
        $orders = $this->getPendingOrdersOfPreviousMonth();
        
        //Orders Voyant Details...
        $ovoyantIds = [];
        if(isset($orders) && !empty($orders)){            
            foreach($orders as $key => $order){
                $ovoyantIds[] = $order['voyantId'];  
            }    
        }
        $ovoyantIds = array_values(array_unique($ovoyantIds));

        //Consultations Voyant Details...
        $voyantConsultations = $this->getVoyantConsultations();

        $purchaseDates = []; 
        if(isset($orders) && !empty($orders)){
            foreach($orders as $ky => $order){
                $purchaseDates[$order['voyantId']][] = $order['purchaseDate'];    
            }
        }
               
        if(isset($voyantConsultations) && !empty($voyantConsultations)){
            foreach($voyantConsultations as $ky => $consultations){
                $purchaseDates[$consultations['voyantId']][] = $consultations['date'];    
            }
        }
        //echo "<pre>";print_r($purchaseDates);die;
        //save into platformInvoice table...
        $this->saveIntoPlatformInvoice($purchaseDates);

        $cvoyantIds = [];
        if(isset($voyantConsultations) && !empty($voyantConsultations)){            
            foreach($voyantConsultations as $key => $consultation){
                $cvoyantIds[] = $consultation['voyantId'];  
            }    
        }

        $cvoyantIds = array_values(array_unique($cvoyantIds));        
        $arrMerge = array_merge($ovoyantIds, $cvoyantIds);       
        $voyArr = array_values(array_unique($arrMerge));

        $platformInvoices = [];
        if($voyArr){
            foreach($voyArr as $key => $voyntId){
                $c = new Criteria();
                $c->add('voyantId',$voyntId);
                $platformInvoices[$voyntId] = Model::factoryInstance("PlatformInvoice")->findAll($c);
            }
        }        
       
        //get voyant Order Invoices...
        $myListOrders = $this->getOrderInvoices($orders);     
        $myVoyantOrders = array_values($myListOrders);
        
        //Get consultations of that voyants where user paid direct to voyant...
        $myListConsultations = $this->getConsultationInvoices($voyantConsultations);
        $myVoyantConsultation = array_values($myListConsultations);

        //$vArrMrg = array_merge($myVoyantConsultation,$myVoyantOrders); 
        $vArrMrg = array_merge($myVoyantConsultation,$myVoyantOrders); 
        $pendingOrdersList = array_values($vArrMrg);
       
        $dateArrSorted = [];
        foreach($pendingOrdersList as $key1 => $pendingOrder){
            foreach($pendingOrder as $key2 => $order){
                $dateArrSorted[] = $order['date'][0].'||'.$order['voyantId'];             
            }
        }
        //$this->set("dateArrSorted", $dateArrSorted);
        $orderByDate = $my2 = array();
        foreach($dateArrSorted as $key=>$row)
        {   
            $data = explode('||',$row);
            $my2 = explode('-',$data[0]);
            $orderByDate[$key] = $my2[0].'-'.$my2[1].'||'.$data[1];
        }    
        array_multisort($orderByDate, SORT_DESC, $dateArrSorted);
      
        $myArrDates = [];
        foreach($orderByDate as $key=>$result){
            $rest = explode('||',$result);
            $myArrDates[$key][$rest[1]] = $rest[0];
        }  

        $pendingInvoiceArr =[]; $inVoiceDates = array(); $voArr = []; $platformInvNumbers = []; 
        foreach($myArrDates as $qwe => $orderBy){
        foreach($orderBy as $voyId => $ddser){ 
            foreach($pendingOrdersList as $rkey => $myorders){
                foreach($myorders as $voyntkey => $order){
                    if($voyntkey==$voyId){ 
                        foreach($platformInvoices as $voyId2 => $Invoices){ 
                            if($voyId2==$voyntkey){
                                foreach($Invoices as $rkey2 => $invoice){   
                                if($order['yearMonth'][0]==$invoice['invoice_date']){ 
                                    if($order['yearMonth'][0]==$ddser){ 
                                        if($order['tvaCalculatedAmt'][0]){                                     
                                            $mdate = $order['shortName'].'-'.$invoice['invoicePlatformNumber'];
                                        
                                            if(!in_array($order['voyantId'], $voArr) || !in_array($mdate, $inVoiceDates)){                                          
                                                array_push($voArr,$order['voyantId']);                                        
                                                array_push($inVoiceDates,$mdate);                                          
                                                array_push($platformInvNumbers, $invoice['invoicePlatformNumber']); 
                                                
                                                $pendingInvoiceArr[$rkey][$voyntkey]['Date'] = $order['date'][0];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['invoice_date'] = $ddser;
                                                $pendingInvoiceArr[$rkey][$voyntkey]['tvaCalculatedAmt'] = $order['tvaCalculatedAmt'][0];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['shortName'] = $order['shortName'];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['voyantId'] = $order['voyantId'];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['invoicePlatformNumber'] = $invoice['invoicePlatformNumber'];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['name'] = $order['name'];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['email'] = $order['email'];
                                                $pendingInvoiceArr[$rkey][$voyntkey]['paymentExpertPlatform'] = $order['paymentExpertPlatform'];
                                            }  
                                        }   
                                    }                                 
                                    }     
                                }
                            }
                        }  
                    }                       
                }
            }
        }
        }

        $this->set("pendingInvoiceArr", $pendingInvoiceArr);       
        $this->set("myArrDates", $myArrDates);        
        $this->set("pendingOrders", $pendingOrdersList);
        $this->set("platformInvoices", $platformInvoices);

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    /*
    * save Into Platform Invoice
    */
    public function saveIntoPlatformInvoice($purchaseDates){
         if(isset($purchaseDates) && !empty($purchaseDates)){
      
            $platformInvoiceDetail = [];
            $counter = 0;
            foreach($purchaseDates as $voyantID => $arr){

                $c = new Criteria();
                $c->add('voyantId', $voyantID);
                $platformInvoices = Model::factoryInstance("PlatformInvoice")->findAll($c);
                $counter = count($platformInvoices);
                $sortedArray = array_values(array_reverse($purchaseDates[$voyantID], true));
                foreach($sortedArray as $key => $date){ 
                    $invoiceDate = date('Y-m', strtotime($date));
                    $c = new Criteria();
                    $c->add('voyantId', $voyantID);
                    $c->add('invoice_date', $invoiceDate);
                    $countDate = Model::factoryInstance("PlatformInvoice")->findAll($c);
                    if(count($countDate)==0){
                        $invoice_record = new PlatformInvoiceRecord();
                        $invoice_record->invoice_date = $invoiceDate;
                        $invoice_record->voyantId = $voyantID;
                        $invoice_record->invoicePlatformNumber = $counter+1;
                        $invoice_record->save(); 

                        $counter++;
                    } 
                }
            }
            return true;
        }
    }

    /*
    * get Order Invoices...
    */
    public function getOrderInvoices($orders){

        $myListOrders = [];
         if(isset($orders) && !empty($orders)){
            $voyantIds = [];$tvaCalculatedAmt = 0; $arrAmt = [];
            foreach($orders as $key => $order){
                if($order['paymentExpertPlatform'] < 1){
                    $onlyDate = date('Y-m-d', strtotime($order['purchaseDate']));
                    list($y,$m) = explode("-",$onlyDate);

                   //Pending invoice lists...
                    $myListOrders[$y."-".$m][$order['voyantId']]['orderId'][] = $order['orderId'];
                    $myListOrders[$y."-".$m][$order['voyantId']]['shortName'] = substr($order['name'], 0,3);
                    $myListOrders[$y."-".$m][$order['voyantId']]['date'][] = $onlyDate;
                    $myListOrders[$y."-".$m][$order['voyantId']]['yearMonth'][] = date('Y-m', strtotime($onlyDate));
                    $myListOrders[$y."-".$m][$order['voyantId']]['name'] = $order['name'];
                    $myListOrders[$y."-".$m][$order['voyantId']]['email'] = $order['email'];
                    $myListOrders[$y."-".$m][$order['voyantId']]['voyantId'] = $order['voyantId']; 
                    
                    $myListOrders[$y."-".$m][$order['voyantId']]['paymentExpertPlatform'] = $order['paymentExpertPlatform'];

                    /********gettingTotal Amount******/
                    $jointArr = $this->getJointArr($order['voyantId'], $onlyDate);
                    $totalAmount = $this->getTotal($jointArr);

                    //calculate TVA...
                    $tvaCalculatedAmt = $this->getTVA($order['voyantId'], $totalAmount);
                    $arrAmt[] = $tvaCalculatedAmt;
                    //echo $tvaCalculatedAmt;die;           
                    $myListOrders[$y."-".$m][$order['voyantId']]['tvaCalculatedAmt'][] = $tvaCalculatedAmt;
                }
            }
        } 
        return $myListOrders;
    }


    /*
    * get Voyant Consultations...
    */
    public function getConsultationInvoices($voyantConsultations){

        $myListConsultations = [];
         if(isset($voyantConsultations) && !empty($voyantConsultations)){
            $voyantIds = [];$tvaCalculatedAmt2 = 0; $arrAmt2 = [];
            foreach($voyantConsultations as $key => $consultation){
                if($consultation['paymentExpertPlatform'] > 0){
                    $onlyDate = $consultation['date'];
                    list($y,$m) = explode("-",$consultation['date']);

                    //Pending invoice lists...
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['userconsultationId'][] = $consultation['userconsultationId'];
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['shortName'] = substr($consultation['name'], 0,3);
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['date'][] = $onlyDate;
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['yearMonth'][] = date('Y-m', strtotime($onlyDate));
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['name'] = $consultation['name'];
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['email'] = $consultation['email'];
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['voyantId'] = $consultation['voyantId'];
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['paymentExpertPlatform'] = $consultation['paymentExpertPlatform'];
    
                    /********gettingTotal Amount******/
                    $jointArr = $this->getJointArr($consultation['voyantId'], $onlyDate);
                    $totalAmount = $this->getTotal($jointArr);

                    //calculate TVA...
                    $tvaCalculatedAmt2 = $this->getTVA($consultation['voyantId'], $totalAmount);
                    $arrAmt2[] = $tvaCalculatedAmt2;
                    //echo $tvaCalculatedAmt;die;           
                    $myListConsultations[$y."-".$m][$consultation['voyantId']]['tvaCalculatedAmt'][] = $tvaCalculatedAmt2;
                }                
            }
           
        } 
         return $myListConsultations;
    }

    /*
    * get TVA
    */
    public function getTVA($voyantId, $totalAmount){
        $setting = $this->setting->getArray(null, 'value');
        if(!empty($voyantId) && !empty($totalAmount)){
            $voyant = $this->voyant->findByPk($voyantId);
            
            // if($voyant['displayTvaOnInvoice']==1 && !empty($voyant['tva']) && $voyant['paymentExpertPlatform'] == 1){
            //     $tva = $totalAmount*$voyant['tva']/100;
            //     $totalAmount = $totalAmount + $tva;

            // }else if(!empty($setting['vatPercent']) && $voyant['paymentExpertPlatform'] < 1){
            //     $tva = $totalAmount*$setting['vatPercent']/100;
            //     $totalAmount = $totalAmount + $tva;
            // }

           if(!empty($setting['vatPercent'])){
                $tva = $totalAmount*$setting['vatPercent']/100;
                $totalAmount = $totalAmount + $tva;
            } 
            return $totalAmount;
        }
    }

    /*
    * Pending Orders Of Previous Month
    */
    public function getPendingOrdersOfPreviousMonth(){
        $lastDateOfPreviousMonth = date('Y-m-d', strtotime('last day of previous month'));
        $firstOfMonth = new DateTime($lastDateOfPreviousMonth);
        $firstOfMonthOnlyYr = $firstOfMonth->format('Y-m-d'); 
        $firstOfMonth = $firstOfMonthOnlyYr.' 23:59:59';

        $c = new Criteria();
        $c->add('status', 'unpaid');
        $c->add('purchaseDate', $firstOfMonth , "<=");
        $c->addOrder("purchaseDate DESC");        
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city','paymentExpertPlatform'));
        $c->add('paymentExpertPlatform', 1 , "<");        
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, packId, quantity, totalPrice',
                                                'relations' => array(
                                                    'voyantQuestion' => array(
                                                        'fields' => 'questionId, title')
                                                )));
        $orders = Model::factoryInstance('order')->findAll($c);
        //adding total Price of orders...        
        $totalQuestPrice = [];
        if(isset($orders) && !empty($orders)){
            foreach($orders as $key => $order){
                $tot = 0;
                foreach($order['orderItems'] as $key2 => $items){
                    $tot += $items['totalPrice'];
                    $totalQuestPrice[$order['orderId']] = $tot;
                }
                $orders[$key]['totalQuestPrice'] = $tot;
            }
        }
        return $orders;
    }

    public function getVoyantConsultations(){
        $lastDateOfPreviousMonth = date('Y-m-d', strtotime('last day of previous month'));
        $firstOfMonth = new DateTime($lastDateOfPreviousMonth);
        $firstOfMonth = $firstOfMonth->format('Y-m-d'); 
     
        // $mydate = explode("-", $getMonth);
        // $year = $mydate[0]; $month = $mydate[1];
        // $dateBeginingOfMonth = $year.'-'.$month."-"."01";

        $c = new Criteria();
        $c->add('status', 'E');
        $c->add('payment_status', 'pending');
        $c->add('date', $lastDateOfPreviousMonth , ">=");
        $c->add('date', $firstOfMonth , "<=");
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = Model::factoryInstance('userConsultation')->findAll($c);
        return $consultations; 
    }

    public function getPendingConsultationsOfPreviousMonth($consultaionsDetail, $voyantId){
        $consultationData = [];
        if(isset($consultaionsDetail) && !empty($consultaionsDetail)){
            foreach($consultaionsDetail as $consult){
                    $consultationCost = 0;
                    if(!empty($consult['duration'])){  
                        $durTime = $consult['duration'];                  
                        $duration = strtotime("1970-01-01 $durTime UTC");
                        $durationMinutes = $consult['duration'];

                    }else{
                     if(!empty($consult['start_time']) && !empty($consult['end_time'])){
                        
                        $start_date = new DateTime($consult['start_time']);
                        $since_start = $start_date->diff(new DateTime($consult['end_time']));
                        if($since_start->h < 10){
                            $hourNumbers = "0".$since_start->h;
                        }
                        if(!empty($since_start->i)){
                            $minuteNumbers = "0".$since_start->i;
                        }else{
                            $minuteNumbers = 00;
                        }
                       
                        if(!empty($since_start->s)){
                            $secndNumbers = $since_start->s;
                        }else{
                            $secndNumbers = 00;
                        }
                        
                        $durationMinutes = $hourNumbers.':'.$minuteNumbers.":".$secndNumbers;
                        $duration = strtotime("1970-01-01 $durationMinutes UTC");
                     }
                    }

                    if($voyantId==$consult['voyantId']){
                        $consultationData[] = array(
                            "userconsultationId" =>$consult['userconsultationId'],
                            "voyantId" => $consult['voyantId'],
                            "userId" => $consult['userId'],
                            "status" => $consult['status'],
                            "invoiceId" => rand ( 10000 , 99999 ),
                            "voyantName" => $consult['name'],
                            "voyantEmail" => $consult['email'],
                            "date" => $consult['date'],
                            "type" => $consult['type'],   
                            "duration" => $duration,
                            "durationMinutes" => $durationMinutes,
                            "paidBackPhone" => $consult['paidBackPhone'],
                            "paidBackWebcam" => $consult['paidBackWebcam']
                        );
                    }
            }
            //echo "<pre>";print_r($consultationData);die;
            return $consultationData;
        }  
    }

    public function getVoyantConsultationCalculation($start_date, $end_date){

        $d = new DateTime( $end_date );
        $endDateOfMonth = $d->format('Y-m-t');

        $c = new Criteria();
        $c->add('status', 'E');
        $c->add('payment_status', 'pending');
        //$c->add('voyantId', $voyantId);
        $c->add('date', $start_date , ">=");
        $c->add('date', $endDateOfMonth , "<=");
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        return Model::factoryInstance('userConsultation')->findAll($c);  
    }

    public function getJointArr($voyantId, $purchaseDate){
        
        // $ts = strtotime($purchaseDate);
        // $monthLstDate = date('t', $ts);
         $purchaseDate = $purchaseDate." 23:59:59";

        $mydate = explode("-", $purchaseDate);
        $year = $mydate[0]; $month = $mydate[1];
        $dateBeginingOfMonth = $year.'-'.$month."-"."01";
        $currentVoyant = $this->voyant->findByPk($voyantId);
        $orders = [];
        if($currentVoyant['paymentExpertPlatform'] == 0){
            //get each month wise orders...
            $orders = $this->eachMonthWiseOrders($voyantId, $purchaseDate);
        }

        $voyantQuestionArr = $this->voyantQuestionArr($orders);

        //GET Voyant Questions Calculations...
        $vQuestionsArr = $this->getSimplyFyVoyantQuestions($voyantQuestionArr);       

        //get Previous Month Consultations...
        $consultaionsDetail = $this->getVoyantConsultationCalculation($dateBeginingOfMonth, $purchaseDate);
        $consultationData = $this->getPendingConsultationsOfPreviousMonth($consultaionsDetail, $voyantId);
        $consultWebcamTotalTime = [];
        $consultPhoneTotalTime = [];
        $typeWeb = ''; 
        $typePhone = ''; 
        $webCounter = 0; 
        $phoneCounter = 0;
        $paidBackWebcam = 0;
        $paidBackPhone = 0;
        if(isset($consultationData) && !empty($consultationData)){           
            foreach($consultationData as $key => $consultation){
                if($consultation['type'] == 'webcam'){
                    $consultWebcamTotalTime[] = $consultation['durationMinutes'];
                    $typeWeb = $consultation['type'];
                    $paidBackWebcam = $consultation['paidBackWebcam'];

                }   
                if($consultation['type'] == 'phone'){
                    $consultPhoneTotalTime[] = $consultation['durationMinutes'];
                    $typePhone = $consultation['type'];
                    $paidBackPhone = $consultation['paidBackPhone'];
                }
           }
        }

        //Get Webcam Consultation Service...
        $webcamTotalTime = $this->getTotalTimes($consultWebcamTotalTime);
        $packageWebArry = $this->getPackageWebArr($typeWeb, $consultWebcamTotalTime, $webcamTotalTime, $typeWeb, $paidBackWebcam);
        

        //Get Phone Consultation Service...
        $phoneTotalTime = $this->getTotalTimes($consultPhoneTotalTime);
        $packagePhoneArry = $this->getPackagePhoneArr($typePhone, $consultPhoneTotalTime, $phoneTotalTime, $typePhone, $paidBackPhone);

        $packageArr = [];
        $packageArr = array_merge($packageWebArry, $packagePhoneArry);

        $jointArr = array_merge($vQuestionsArr,$packageArr);
        $this->set('jointArr', $jointArr);

        $this->set('orders', $orders);  
        //$this->set('orderItems', $order->getOrderItemArr());      
        $this->set('voyant', $this->voyant->findByPk($voyantId));

        $platformDetail =  Model::factoryInstance('user')->findByPk(1);
        $this->set('platformDetail', $platformDetail);

       // $userDetail =  Model::factoryInstance('user')->findByPk($order->userId);
       // $this->set('userDetail', $userDetail);

        $this->set('purchaseDate', $purchaseDate);       

        return $jointArr;
        
    }

    /*
    * get voyant questions with quanttiy price informations...
    */
    public function getSimplyFyVoyantQuestions($voyantQuestionArr){
       
        $titArr = []; $priceArr = []; $queIdArr = []; 
        if(isset($voyantQuestionArr) && !empty($voyantQuestionArr)){
            foreach($voyantQuestionArr as $key => $orderArrs){
                foreach($orderArrs as $key2 => $orderArr){
                    if(!empty($orderArr['title'])){
                      $titArr[] = $orderArr['title'];
                      $queIdArr[] = $orderArr['questionId'];
                      $priceArr[] = $orderArr['price'];
                    }
                }
            }
        }

        $mtitle = [];
        foreach($titArr as $key1 => $title){
            foreach($priceArr as $key2 => $price){
                if($key1==$key2){
                    $mtitle[] = $title. "||" . $price;
                }                 
            }
        }        
        $titArr = array_count_values($mtitle);            
        $titleArr = [];
        if(isset($titArr) && !empty($titArr)){
            foreach($titArr as $values => $qty){
                $data = explode("||", $values);
                $titleArr['title'][] = $data[0];
                $titleArr['price'][] = $data[1];
                $titleArr['quantity'][] = $qty;
            }
        }
        
        $joArr = [];
        if(isset($titleArr['title']) && !empty($titleArr['title'])){
            foreach($titleArr['title'] as $key => $valArr){              
                $joArr[$key][$titleArr['quantity'][$key]]['title'] = $valArr;
                $joArr[$key][$titleArr['quantity'][$key]]['quantity'] = $titleArr['quantity'][$key];
                $joArr[$key][$titleArr['quantity'][$key]]['price'] = $titleArr['price'][$key];
                $joArr[$key][$titleArr['quantity'][$key]]['totalQPrice'] = $titleArr['price'][$key] * $titleArr['quantity'][$key];         
            }
        }
        $this->set('joArr', $joArr);
        return $joArr;
    }

    /*
    * details Page Action
    */
    public function detailsAction($voyantId=NULL, $paymentExpertPlatform=NULL, $purchaseDate=NULL, $invoiceDate=NULL)
    {
        if (!empty($voyantId) && !empty($purchaseDate) && !empty($invoiceDate) && ($paymentExpertPlatform==0 || $paymentExpertPlatform==1)) {
            $ts = strtotime($purchaseDate);
            $monthLstDate = date('t', $ts);
            $purchaseDate = $purchaseDate."-".$monthLstDate;

            $jointArr = $this->getJointArr($voyantId, $purchaseDate);
            $getTotal = $this->getTotal($jointArr);
            $tvaCalculatedTotalAmt = $this->getTVA($voyantId, $getTotal);

            $settings = $this->setting->getArray(null, 'value');
            $this->set('settings', $settings);

            $this->set('getTotal', $getTotal);
            $this->set('tvaCalculatedTotalAmt', $tvaCalculatedTotalAmt);
            $this->set('invoiceDate', $invoiceDate);
            $this->set('purchaseDate', $purchaseDate);
            $this->set('paymentExpertPlatform', $paymentExpertPlatform);
        }else{
            $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyantInvoice/pending');
            $this->redirect($redirectUrl);
        }
        
        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    /*
    * getPackageWebArr
    */
    public function getPackageWebArr($type, $consultWebcamTotalTime, $webcamTotalTime, $typeWeb, $paidBackWebcam){
       //echo "<pre>";print_r($webcamTotalTime);die;
        $packageWebArr = []; 
        if($type == 'webcam'){
            $totTime = 0;
            $quantity = sizeof($consultWebcamTotalTime);
            $packageWebArr[0][$quantity]['type'] = ucfirst($type);
            $packageWebArr[0][$quantity]['consultation_total_time']=$webcamTotalTime;

            //Calculate total time with cost calculation... 
            $data = explode(":", $webcamTotalTime);
            $totTime = $data[0]*3600 + $data[1]*60 + $data[2];           
            $packageWebArr[0][$quantity]['consultation_total_cost'] = abs($paidBackWebcam / 60)*$totTime;                 
        }
        return $packageWebArr;
    }

    /*
    * getPackagePhoneArr
    */
    public function getPackagePhoneArr($type, $consultPhoneTotalTime, $phoneTotalTime, $typePhone, $paidBackPhone){
 
        $packagePhoneArr = [];
        if($type == 'phone'){
            $totTime = 0;
            $quantity = sizeof($consultPhoneTotalTime);
            $packagePhoneArr[0][$quantity]['type'] = ucfirst($type);
            $packagePhoneArr[0][$quantity]['consultation_total_time'] = $phoneTotalTime;

            //Calculate total time with cost calculation... 
            $data = explode(":", $phoneTotalTime);
            $totTime = $data[0]*3600 + $data[1]*60 + $data[2];
            $packagePhoneArr[0][$quantity]['consultation_total_cost'] = abs($paidBackPhone / 60)*$totTime;
        }
        return $packagePhoneArr; 
    }

    /*
    * voyantQuestionArr
    */
    public function voyantQuestionArr($orders){
        $voyantQuestionArr = [];
        if(isset($orders) && !empty($orders)){
            foreach($orders as $key => $morder){
                $order=Model::factoryInstance('order')->findByPk($morder['orderId']);
                    foreach ($order->getOrderItemArr() as $key=> $orderItem) {
                        if(!empty($orderItem['itemId'])){
                            $voyantQuestionArr[][$orderItem['quantity']] = Model::factoryInstance('voyantQuestion')->findByPk($orderItem['itemId']);
                        }
                    }
            }  
        }
        return $voyantQuestionArr;
    }

    /*
    * eachMonthWiseOrders
    */
    public function eachMonthWiseOrders($voyantId, $purchaseDate)
    {
        if(!empty($voyantId) && !empty($purchaseDate)){
            $purchaseDate = $purchaseDate." 23:59:59";
            $mydate = explode("-", $purchaseDate);
            $year = $mydate[0]; $month = $mydate[1];
            $dateBeginingOfMonth = $year.'-'.$month."-"."01";

            $c = new Criteria();
            $c->add('voyantId', $voyantId);
            $c->add('status', 'unpaid');
            $c->add('purchaseDate', $dateBeginingOfMonth , ">=");
            $c->add('purchaseDate', $purchaseDate , "<=");
            return Model::factoryInstance('order')->findAll($c);
        }
    }

    /*
    * Get Total Time...
    */
    public function getTotalTimes($times) {
        $hours = []; $minutes = []; $seconds = [];
        $hourIntoMinutes = 0;
        $secondsIntoMinutes = 0;
        $h = 0;  $m = 0;  $s = 0;  $totalMinutes = 0; $totalSeconds = 0;
        if(!empty($times)){
            foreach ($times as $time) {
                $timeData = explode(':', $time);
                $hours[] = $timeData[0];
                $minutes[] = $timeData[1];
                $seconds[] = $timeData[2];
            }
        }

        $h = array_sum($hours);
        $m = array_sum($minutes);
        $s = array_sum($seconds);
        
        $hourIntoMinutes = floor($h*60);
        $secondsIntoMinutes = floor(($s%3600)/60);

        $totalMinutes = $hourIntoMinutes+$m+$secondsIntoMinutes;
        $hour = 0; $min = 0; $sec = 0;
        if($totalMinutes){
            $hour = floor($totalMinutes / 60);
            $min = $totalMinutes - ($hour * 60);
            //$sec = $min%60;
            $sec = $s;
        }
        return sprintf('%02d:%02d:%02d', $hour, $min, $sec);

        
        // $totalSeconds = (60*$hourIntoMinutes) + ($m*60) + $s;
        // $amt = $totalSeconds/60;die;    
    }

    public function getTotal($jointArr)
    {
       if(isset($jointArr) && !empty($jointArr)){
        $total = 0;
            foreach($jointArr as $key => $orderArs){
                foreach($orderArs as $qty => $orderArr){
                    if(!empty($orderArr['price'])){
                        $total+= $orderArr['price']/2*$qty;
                    }

                    if(!empty($orderArr['consultation_total_cost'])){
                        //$total+= $orderArr['consultation_total_cost']*$qty;
                        $total+= $orderArr['consultation_total_cost'];
                    }
                }
            }
            return $total;
       }  
    }

    public function printAction($voyantId=NULL, $paymentExpertPlatform=NULL, $purchaseDate=NULL, $invoiceDate=NULL)
    {
        if(!empty($voyantId) && !empty($purchaseDate) && !empty($invoiceDate) && ($paymentExpertPlatform==0 || $paymentExpertPlatform==1)){
                $jointArr = $this->getJointArr($voyantId, $purchaseDate);
                $getTotal = $this->getTotal($jointArr);
                $tvaCalculatedTotalAmt = $this->getTVA($voyantId, $getTotal);

                $settings = $this->setting->getArray(null, 'value');
                $this->set('settings', $settings);
             
                $this->set('getTotal', $getTotal);
                $this->set('tvaCalculatedTotalAmt', $tvaCalculatedTotalAmt);
                $this->set('invoiceDate', $invoiceDate);
                $this->set('purchaseDate', $purchaseDate);
                $this->set('paymentExpertPlatform', $paymentExpertPlatform);
        }else{
                $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyantInvoice/pending');
                $this->redirect($redirectUrl);
        }

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function listAction()
    {

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function listByDateAction()
    {

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsCas1Action()
    {

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsCas2Action()
    {
        



        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsCas3Action()
    {
        



        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsCas4Action()
    {
        



        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }


    /*
    * Update Orders and Consultations Invoice Status pending to paid
    */
    public function updateOrderInvoiceStatusAction(){
        $getData = $this->request->checkValues;
      
        /*print_r($getData);
        die();
*/        $resultData = [];
        foreach($getData as $key => $data){
            $resultData[] = explode(",", $data);
        } 
       
       if(isset($resultData) && !empty($resultData)){
            foreach($resultData as $key => $resultData){
                $voyantId = $resultData[0];
                $purchaseDateWtTime = $resultData[1];
                $platformInvoiceId = $resultData[2];
                  
                $purchaseDate = $purchaseDateWtTime." 23:59:59";
                $mydate = explode("-", $purchaseDate);
                $year = $mydate[0]; $month = $mydate[1];
                $dateBeginingOfMonth = $year.'-'.$month."-"."01";

                //get each month wise orders...
                $orders = $this->eachMonthWiseOrders($voyantId, $purchaseDate);
                if(isset($orders) && !empty($orders)){
                    foreach($orders as $key => $order){

                        //Orders Updated here...
                        $data1 = array("status" => "paid");
                        Model::factoryInstance("order")->updateByPk($data1, $order['orderId']);           
                    }

                    //get Previous Month Consultations...
                    $consultaionsDetail = $this->getVoyantConsultationCalculation($dateBeginingOfMonth, $purchaseDate);
                    
                    $consultationData = $this->getPendingConsultationsOfPreviousMonth($consultaionsDetail, $voyantId);

                    if(isset($consultationData) && !empty($consultationData)){
                        foreach($consultationData as $key2 => $consultation){
                            $data2 = array("payment_status" => "paid");
                            Model::factoryInstance("userConsultation")->updateByPk($data2, $consultation['userconsultationId']);
                        }  
                    }
                }    
            }
       }
       $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyantInvoice/pending');
       $this->redirect($redirectUrl);
    }
    
}

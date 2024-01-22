<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class User_OrderController extends AppController
{
    /**
    * Initailize controller set access privileges
    */
    public function init()
    {
        $this->acl->allow('user', $this->name, '*');

        if ($this->action == 'details' && 'administrator' == $this->session->get('role') ) {
            // allow details page for invoice
        } else if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action) ) {
            $this->redirect(AppRouter::getRewrittedUrl('/user'));
        }

        $this->set("action",$this->action);

        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }

    /**
    * Managment panel list of all sites which can be managed
    */
    public function indexAction()
    {
       //get the count of consultations...
       $this->set('phoneCount', $this->session->get('userPhoneConsultationCounts'));
       $this->set('webcamCount', $this->session->get('userWebcamConsultationCounts'));
       $this->set('chatCount', $this->session->get('userChatConsultationCounts'));
    }

    public function mailAction($page = 1)
    {
        $itemsPerPage = 1000;

        $c = new Criteria();
        $c->setPagination($page, $itemsPerPage);
        $c->add('userId', $this->userId);
        $c->add('status', array('pending', 'paid'), 'IN');

        $orderItemsCriteria = new Criteria();
        $orderItemsCriteria->addLeftJoin('voyantQuestions','orderItems.itemId','voyantQuestions.questionId');
        $orderItemsCriteria->addLeftJoin('voyants','voyantQuestions.voyantId','voyants.voyantId');
        $orderItemsCriteria->add('itemId',NULL,'!=');
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, packid,quantity, totalPrice,voyantQuestions.title,voyantQuestions.voyantId, voyants.name','criteria' => $orderItemsCriteria));

        $userQuestionsCriteria = new Criteria();
//        $userQuestionsCriteria->add('status', 'pending');
        $c->addWithRelation('userQuestions', array('fields' => 'questionId, orderId, status',
                                                   'criteria' => $userQuestionsCriteria));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $ordersList = $this->order->findAll($c);

        $this->set('orders', $ordersList);
        $totalPages = ceil($this->order->getFoundRowsCount() / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/manage/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));

        //get the count of consultations...
         $this->set('phoneCount', $this->session->get('userPhoneConsultationCounts'));
         $this->set('webcamCount', $this->session->get('userWebcamConsultationCounts'));
         $this->set('chatCount', $this->session->get('userChatConsultationCounts'));

    }

    // public function getConsultationTypeCount($type){
    //     if(!empty($type)){
    //         $c = new Criteria();
    //         $c->add('userId', $this->userId);
    //         $c->add('status', 'E');
    //         $c->add('type', $type);
    //         $userConsultations = $this->userConsultation->findAll($c);
    //         return count($userConsultations);
    //     }
    // }

    public function phoneAction()
    {
         //get the count of consultations...
         $this->set('phoneCount', $this->session->get('userPhoneConsultationCounts'));
         $this->set('webcamCount', $this->session->get('userWebcamConsultationCounts'));
         $this->set('chatCount', $this->session->get('userChatConsultationCounts'));

        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'E');
        $c->add('type', 'phone');
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);
        $userPhoneConsultations = $this->getConsultationsDetails($consultations);
        $this->set('userPhoneConsultations', $userPhoneConsultations);
    }

    public function webcamAction()
    {
        //get the count of consultations...
        $this->set('phoneCount', $this->session->get('userPhoneConsultationCounts'));
        $this->set('webcamCount', $this->session->get('userWebcamConsultationCounts'));
        $this->set('chatCount', $this->session->get('userChatConsultationCounts'));


        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'E');
        $c->add('type', 'webcam');
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);
        $userWebcamConsultations = $this->getConsultationsDetails($consultations);

        $this->set('userWebcamConsultations', $userWebcamConsultations);
    }

    public function chatAction()
    {
        //get the count of consultations...
        $this->set('phoneCount', $this->session->get('userPhoneConsultationCounts'));
        $this->set('webcamCount', $this->session->get('userWebcamConsultationCounts'));
        $this->set('chatCount', $this->session->get('userChatConsultationCounts'));


        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'E');
        $c->add('type', 'chat');
        $c->addOrder("date DESC");
        $c->addWithRelation('voyant', array(
                                'fields' => 'firstName, lastName, email, address, companyTaxNumber, tva,
                                             displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                             displayLastNameOnInvoice, displayTvaOnInvoice,
                                             zipCode, city'));
        $consultations = $this->userConsultation->findAll($c);
        $userChatConsultations = $this->getConsultationsDetails($consultations);

        $this->set('userChatConsultations', $userChatConsultations);
    }

    public function getConsultationsDetails($consultaionsDetail){
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

                            if($since_start->i < 10){
                                $minuteNumbers = "0".$since_start->i;
                            }else{
                                $minuteNumbers = $since_start->i;
                            }

                            if($since_start->s < 10){
                                $secndNumbers = "0".$since_start->s;
                            }else if($since_start->s > 9){
                                $secndNumbers = $since_start->s;
                            }else{
                                $secndNumbers = 00;
                            }

                            $durationMinutes = $hourNumbers.':'.$minuteNumbers.":".$secndNumbers;
                            $duration = strtotime("1970-01-01 $durationMinutes UTC");
                        }
                    }

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
            return $consultationData;
        }
    }

    public function summaryAction($orderId)
    {
        $c = new Criteria();
        $c->add('orderId', $orderId);
        $c->addWithRelation('userQuestions', array('fields' => 'orderId, summary',
                                                   'relations' => array(
                                                   'voyantQuestion' => array(
                                                        'fields' => 'questionId, title')
                                                )));
        $order = $this->order->find($c);

        if (empty($order) || $order->userId != $this->userId) {
            return $this->return404();
        }

        $this->set('order', $order);
    }

    public function refundAction()
    {
        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'paid');
        $c->add('questionStatus', 'pending');
        $orders = $this->order->findAll($c);
        $this->set('orders', $orders);
    }

    public function sendRefundEmailAction()
    {
        $this->viewClass = 'JsonView';
        $order = $this->order->findByPk($this->request->orderId);

        if (empty($order) || $order->userId != $this->userId) {
            $errorMessage = 'Please, select an order';
        }

        if (empty($errorMessage)) {
        Mailer::getInstance()->sendRefundEmails($order->orderId, $this->request->text);
        $this->set('status', 'ok');
        } else {
                $this->set('status', 'error');
                $this->set('message', _t($errorMessage));
            }
    }

    public function orderListAction()
    {
        $c = new Criteria();
        $c->add('userId', $this->userId);
        $c->add('status', 'paid');
        $c->addOrder('purchaseDate', 'DESC');
       // $c->add('questionStatus', 'pending');
        $orderItemsCriteria = new Criteria();
        $orderItemsCriteria->addLeftJoin('voyantQuestions','orderItems.itemId','voyantQuestions.questionId');
        $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, packid,quantity, totalPrice,voyantQuestions.title,packages.packageName','criteria' => $orderItemsCriteria));

        $orders = $this->order->findAll($c);

        /*$packageDetails = $this->getOrderPackageDetails($orders);
        foreach($orders as $key => $order){
            $packIds = $order['packageId'];
            $packIds = explode(",", $packIds);
            $orders[$key]['packageNameWithTime'] =  $packIds;
        }

        $questionDetails = $this->getOrderQuestionDetails($orders);
        foreach($orders as $key => $order){
            $itemIds = $order['itemId'];
            $itemIds = explode(",", $itemIds);
            $orders[$key]['questionName'] =  $itemIds;
        }

        $this->set('packageDetails', $packageDetails);
        $this->set('questionDetails', $questionDetails);*/
        $this->set('orders', $orders);

    }

    /**
     * @param $orders
     * @return packageRecord
     * Get Package details for orders with paid status...
     */
    function getOrderPackageDetails($orders){
        if(isset($orders) && !empty($orders)){
           $packIds = [];
           foreach($orders as $torder){
                if (stripos($torder['title'], 'Time Pack') !== false) {
                    $packIds[] = $torder['packageId'];
                }
           }
           $packIdArr = [];
           if(isset($packIds) && !empty($packIds)){
                foreach($packIds as $packId){
                    $packIdArr[] = explode(",", $packId);
                }
           }
           $results=[];
           if(isset($packIdArr) && !empty($packIdArr)){
                foreach($packIdArr as $packIds){
                    $results = array_merge($results, $packIds);
                }
           }

           $packNameWithTime = [];
           if(isset($results) && !empty($results)){
                foreach($results as $packID){
                    $package = $this->package->findByPk($packID);
                    if(isset($package) && !empty($package)){
                        $packNameWithTime[$package->packageId] = $package->packageName." - ". $package->packageTime." Minutes";
                    }
                }
           }
           return $packNameWithTime;
        }
    }

     /**
     * @param $orders
     * @return questionRecord
     * Get Question details for orders with paid status...
     */
    function getOrderQuestionDetails($orders){
        if(isset($orders) && !empty($orders)){
           $itemIds = [];
           foreach($orders as $torder){
               if ($torder['type']=='VoyantQuestion' || $torder['type']=='Platform') {
                    $itemIds[] = $torder['itemId'];
                }
           }
           $itemIdArr = [];
           if(isset($itemIds) && !empty($itemIds)){
                foreach($itemIds as $itemId){
                    $itemIdArr[] = explode(",", $itemId);
                }
           }
           $results=[];
           if(isset($itemIdArr) && !empty($itemIdArr)){
                foreach($itemIdArr as $itemIds){
                    $results = array_merge($results, $itemIds);
                }
           }
           $questionName = [];
           if(isset($results) && !empty($results)){
                foreach($results as $itemID){
                    $voyantQuestions = $this->voyantQuestion->findByPk($itemID);
                    if(isset($voyantQuestions) && !empty($voyantQuestions)){
                        $questionName[$voyantQuestions->questionId] = $voyantQuestions->title;
                    }
                }
           }
           return $questionName;
        }
    }

    public function detailsAction($orderId)
    {
        $order = Model::factoryInstance('order')->findByPk($orderId);
        $this->set('order', $order);

        $userDetail =  Model::factoryInstance('user')->findByPk($order->userId);
        $this->set('userDetail', $userDetail);

        $platformDetail =  Model::factoryInstance('user')->findByPk(1);
        $this->set('platformDetail', $platformDetail);

        $settings = $this->setting->getArray(null, 'value');
        $this->set('settings', $settings);

        $voyantQuestionArr = [];
        $packageArr = [];
        foreach ($order->getOrderItemArr() as $key=> $orderItem) {
            if(!empty($orderItem['itemId'])){
                $voyantQuestionArr[][$orderItem['quantity']] = Model::factoryInstance('voyantQuestion')->findByPk($orderItem['itemId'])->toArray();
            }

            if(!empty($orderItem['packId'])){
                $packageArr[][$orderItem['quantity']] = Model::factoryInstance('package')->findByPk($orderItem['packId'])->toArray();
            }
        }
        $jointArr = array_merge($voyantQuestionArr,$packageArr);

        $this->set('jointArr', $jointArr);
        $this->set('orderItems', $order->getOrderItemArr());

        $getTotal = $this->getTotal($jointArr);
        $this->set('getTotal', $getTotal);
        $this->set('voyant', $this->voyant->findByPk($order->voyantId));

        $this->set( 'userRole', $this->session->get('role') );
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

    public function getTotal($jointArr)
    {
       if(isset($jointArr) && !empty($jointArr)){
            $total = 0;
            $actualTotal = 0;
            foreach($jointArr as $key => $orderArs){
                foreach($orderArs as $qty => $orderArr){
                    // if(!empty($orderArr['price'])){
                    //     $total+= $orderArr['price']*$qty;
                    // }

                    // if(!empty($orderArr['packagePrice'])){
                    //     $total+= $orderArr['packagePrice']*$qty;
                    // }

                    if(!empty($orderArr['voyantId'])){
                        $voyant = $this->voyant->findByPk($orderArr['voyantId']);

                        // If Only voyant and payment goes to voyant direct...
                        if(!empty($voyant->displayTvaOnInvoice) && !empty($voyant->tva) && $voyant->paymentExpertPlatform == 1  && !empty($orderArr['price'])){
                            $withQty = $orderArr['price']*$qty;
                            $amountWithoutVAT = $withQty * $voyant->tva/100;
                            $total +=  $orderArr['price'] - $amountWithoutVAT;

                                $actualTotal += $orderArr['price']*$qty;
                        }else{
                            if($voyant->paymentExpertPlatform == 1){
                                $total += $orderArr['price']*$qty;
                                $actualTotal += $orderArr['price']*$qty;
                            }
                        }

                        if(isset($voyant) && !empty($voyant) && $voyant->paymentExpertPlatform < 1){
                            $settings = $this->setting->getArray(null, 'value');

                            if(!empty($settings['vatPercent'])){

                                if(!empty($orderArr['price'])){

                                    $withQty = $orderArr['price']*$qty;
                                    $amountWithoutVAT = $withQty * $settings['vatPercent']/100;
                                    $total +=  $orderArr['price'] - $amountWithoutVAT;

                                    $actualTotal += $orderArr['price']*$qty;
                                }

                            }else{

                                if($voyant->paymentExpertPlatform < 1){
                                    $total += $orderArr['price']*$qty;

                                    $actualTotal += $orderArr['price']*$qty;
                                }
                            }
                        }
                    }else{
                        $settings = $this->setting->getArray(null, 'value');
                        if (isset($settings) && !empty($settings)){
                            if(!empty($settings['vatPercent'])){
                                $withQty = $orderArr['packagePrice']*$qty;
                                $amountWithoutVAT = $withQty * $settings['vatPercent']/100;
                                $total +=  $orderArr['packagePrice'] - $amountWithoutVAT;

                                $actualTotal += $orderArr['packagePrice']*$qty;
                            }else{
                                $total += $orderArr['packagePrice']*$qty;

                                $actualTotal += $orderArr['packagePrice']*$qty;
                            }
                        }
                    }
                }
            }

            $arrTotal = [];
            $arrTotal = [$actualTotal,$total];
            return $arrTotal;
        }
    }

    public function invoicePrintAction($orderId){
        $order = Model::factoryInstance('order')->findByPk($orderId);
        $this->set('order', $order);

        $userDetail =  Model::factoryInstance('user')->findByPk($order->userId);
        $this->set('userDetail', $userDetail);

        $platformDetail =  Model::factoryInstance('user')->findByPk(1);
        $this->set('platformDetail', $platformDetail);

        $settings = $this->setting->getArray(null, 'value');
        $this->set('settings', $settings);

        $voyantQuestionArr = [];
        $packageArr = [];
        foreach ($order->getOrderItemArr() as $key=> $orderItem) {
            if(!empty($orderItem['itemId'])){
                $voyantQuestionArr[][$orderItem['quantity']] = Model::factoryInstance('voyantQuestion')->findByPk($orderItem['itemId'])->toArray();
            }

            if(!empty($orderItem['packId'])){
                $packageArr[][$orderItem['quantity']] = Model::factoryInstance('package')->findByPk($orderItem['packId'])->toArray();
            }
        }

        $jointArr = array_merge($voyantQuestionArr,$packageArr);
        $this->set('jointArr', $jointArr);
        $this->set('orderItems', $order->getOrderItemArr());
        $getTotal = $this->getTotal($jointArr);
        $this->set('getTotal', $getTotal);
        $this->set('voyant', $this->voyant->findByPk($order->voyantId));
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class CartController extends AppController
{
    /**
     * Initailize controller set access privileges
     */
    public function init()
    {
        $this->acl->allow('user', $this->name, '*');
        $this->acl->allow('guest', $this->name, 'addItem');
        $this->acl->allow('guest', $this->name, 'checkout');
        $this->acl->allow('guest', $this->name, 'deleteItem');
        $this->acl->allow('guest', $this->name, 'ipn');
		$this->acl->allow('guest', $this->name, 'getMaxUserCreditTime');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action) && $this->action!='pack' && $this->action!='addPack'){
            $this->session->set('redirectUrl', $this->request->getCurrentUrl());
            $this->redirect(AppRouter::getRewrittedUrl('/user'));
        }
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);
    }

    /**
    *@param $voyantQustionId
    *@param $priceId
    */
    public function addItemAction($voyantQustionId, $priceId = null)
    {
        $voyantQuestion = $this->voyantQuestion->findByPk($voyantQustionId);
        $this->set('voyantQuestion', $voyantQuestion);

        if (!empty($priceId) && $priceId != "undefined") {
            $voyantQuestionPrice = $this->voyantQuestionPrice->findByPk($priceId);
            $this->set('voyantQuestionPrice', $voyantQuestionPrice);
        }
        $cart = $this->cart->getCart();
        if (!empty($voyantQuestionPrice)) {
            $quantity = $voyantQuestionPrice['quantity'];
            $totalPrice = $voyantQuestionPrice['price'];
        }else{
            $quantity = 1;
            $totalPrice = $voyantQuestion['price'];
        }

        $type = "VoyantQuestion";
        $packageId = 0;
        $cart->addItem($voyantQustionId, $voyantQuestion['title'], $quantity,
        $totalPrice, $voyantQuestion->voyantId, $packageId, $type, $this->userId);
    }
    public function checkoutAction()
    {
        $cart = $this->cart->getCart();
        $cart->loadItems();
        $cart->loadBaskets();
        $this->set('cart', $cart);
    }

    public function deleteItemAction($cartItemId)
    {
        $this->cart->getCart()->deleteItem($cartItemId);
        $this->redirect($this->moduleLink('checkout'));
    }

    /**
    *@param $voyantOrPackgId
    *@param $type
    */
    public function paymentDetailsAction($voyantId, $packageId, $type)
    {
        $user = $this->user->findByPk(1);
        $this->set('type', $type);
        $cart = $this->cart->getCart();
        $cartID = $cart->cartId;
        $cart->loadItems();
        $cart->loadBaskets();
        $myCart = array();

        if ($type == 'Platform') {
            $myCart = $cart->baskets[ $type ];
        } else {
            $myCart = $cart->baskets[ $voyantId ];
        }

        // echo json_encode($type);
        // exit;

        if($type == 'VoyantQuestion') {
            $voyant = $this->voyant->findByPk($voyantId);
            $paymentprocessors = $this->PaymentProcessor->findByPk("Stripe");
            $this->set('paymentprocessors', $paymentprocessors);
            $this->set('voyant', $voyant);
            $this->set('packageId', 0);
            // echo json_encode($voyant);
            $myCart[ 'type' ] = 'VoyantQuestion';
        }

        if($type=='Platform') {
            if ($cart->baskets[ $type ][ 'isPackTime' ]) {
                $this->set('user', $user);
                $paymentprocessors = $this->PaymentProcessor->findByPk("Stripe");
                $this->set('paymentprocessors', $paymentprocessors);
                $myCart[ 'type' ] = 'TimePack';
                //echo "<pre>";print_r($paymentprocessors->stripePublicKey);die;
            } else {
                $voyant = $this->voyant->findByPk($voyantId);
                $paymentprocessors = $this->PaymentProcessor->findByPk("Stripe");
                $this->set('paymentprocessors', $paymentprocessors);
                $this->set('voyant', $voyant);
                $this->set('user', $user);
                $myCart[ 'type' ] = 'Platform';
            }
            $this->set('packageId', $packageId);
        }

        // $myCart['totalPrice'] = $cart->baskets[ $type ]['totalPrice'];
        $this->set('cart', $myCart);
    }

    /**
     * @param $type
     * get Totle Price of selected items...
     */
    function getCartSelectedItemsPrice($type, $cartID, $voyantId, $packgId){

        if(!empty($cartID) && $type=='VoyantQuestion' && $voyantId > 0 && $packgId==0){
             $c = new Criteria();
             $c->add("cartId", $cartID);
             $c->add("type", "VoyantQuestion");
             $c->add("voyantId", $voyantId);
             $c->add("packageId", 0);

            $totalPrice = 0;
            $cartItems = Model::factoryInstance('cartItem')->findAll($c);
            if(isset($cartItems) && !empty($cartItems)){
                foreach($cartItems as $cartItem){
                    $totalPrice += $cartItem['totalPrice'];
                }
            }
            return $totalPrice;
        }

        if(!empty($cartID) && $type=='TimePack' && $voyantId == 0 && $packgId > 0){
             $c = new Criteria();
             $c->add("cartId", $cartID);
             $c->add("type", "TimePack");
             $c->add("voyantId", 0);
             $c->add("packageId", $packgId);

            $totalPrice = 0;
            $cartItems = Model::factoryInstance('cartItem')->findAll($c);
            if(isset($cartItems) && !empty($cartItems)){
                foreach($cartItems as $cartItem){
                    $totalPrice += $cartItem['totalPrice'];
                }
            }
            return $totalPrice;
        }

        if(!empty($cartID) && $type=='Platform' && $voyantId > 0 && $packgId > 0){

             $vtotalPrice = 0;
             if($voyantId > 0){
                $c = new Criteria();
                $c->add("cartId", $cartID);
                $c->add("type", "VoyantQuestion");
                $c->add("voyantId", $voyantId);
                $cartItems = Model::factoryInstance('cartItem')->findAll($c);
                if(isset($cartItems) && !empty($cartItems)){
                    foreach($cartItems as $cartItem){
                        $vtotalPrice += $cartItem['totalPrice'];
                    }
                }
             }

             $ttotalPrice = 0;
             if($packgId > 0){
                $d = new Criteria();
                $d->add("cartId", $cartID);
                $d->add("type", "TimePack");
                $d->add("packageId", $packgId);
                $cartItems = Model::factoryInstance('cartItem')->findAll($d);
                if(isset($cartItems) && !empty($cartItems)){
                    foreach($cartItems as $cartItem){
                        $ttotalPrice += $cartItem['totalPrice'];
                    }
                }
             }
            return $vtotalPrice+$ttotalPrice;
        }
    }

     /**
     * @param $type
     * reset the cart items...
     */
    // function getCartReset($type, $cartID){
    //     $cart = Model::factoryInstance('cart')->findByPk($cartID);
    //     $c = new Criteria();
    //     if($type=='VoyantQuestion'){
    //        $c->add("type", "TimePack");
    //     }

    //     if($type=='TimePack'){
    //       $c->add("type", "VoyantQuestion");
    //     }
    //     $c->add("cartId", $cartID);
    //     $cartItems = Model::factoryInstance('cartItem')->findAll($c);
    //     // foreach ($cartItems as $cartItem) {
    //     //     $cart->deleteItem($cartItem['cartItemId']);
    //     // }
    // }

    private function configurePaymentProcessor($paymentProcessor)
    {
        $notifyUrl = Config::get('siteRootUrl') . $this->moduleLink('ipn', false);
        $returnUrl = Config::get('siteRootUrl') . AppRouter::getRewrittedUrl('/cart/confirmation', false);
        // $returnUrl = "http://54.70.244.243/cart/confirmation";
        $cancelReturnUrl = Config::get('siteRootUrl') . AppRouter::getRewrittedUrl('/cart/checkout', false);

        $paymentProcessor->setNotifyUrl($notifyUrl)
            ->setReturnUrl($returnUrl)
            ->setCancelReturnUrl($cancelReturnUrl);
    }

    /**
     * @throws Exception
     */
    public function payAction()
    {
        if(!empty($this->request->type)){
            $type = $this->request->type;
            if($type === 'VoyantQuestion' || $type === 'Platform'){
                $voyantId = $this->request->voyantId;
                $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);
            }else{
               $user = $this->user->findByPk(1);
            }

            $paymentMethod = $this->request->paymentMethod;
            if (empty($paymentMethod) || !in_array($paymentMethod, array('payPal', 'check', 'stripe'))
            ) {
                throw new Exception('Unsupported payment method');
            }

            $cart = $this->cart->getCart();
            $cartID = $cart->cartId;
            $cart->loadItems();
            $cart->loadBaskets();
            $this->set('cart', $cart);
            $typeUser = [];
            $paymentExpertPlatform = 0;
            if($type!='TimePack'){
                $paymentExpertPlatform = $voyant->paymentExpertPlatform;
            }

            if($type==="VoyantQuestion" || $type==="Platform"){$typeUser = $voyant;} if($type==="TimePack"){$typeUser = $user;}
            $order = $this->createOrder($cart, $typeUser, $paymentMethod, $type, $paymentExpertPlatform);
            if($type==="VoyantQuestion" && $typeUser->paymentExpertPlatform==1){
                //Here payment send to voyant...
                $this->processPaymentOption($typeUser, $order, $type);
                //$this->getCartEmpty($cartID);
            }else{
                if($paymentMethod !='stripe' && $type!='TimePack'){
                    $this->processPaymentOption($typeUser, $order, $type);
                    //$this->getCartEmpty($cartID);
                }else{
                    //TimePack payPal payment process
                    $this->processPaymentOptionTimepack($typeUser, $order, $type);
                    //$this->getCartEmpty($cartID);
                }
            }
        }
    }

    /**
     * @param CartRecord $cart
     * @param VoyantRecord $voyant
     * @param string $paymentMethod
     * @param string $type
     * @return OrderRecord
     */
    private function createOrder($cart, $typeUser, $paymentMethod, $type, $paymentExpertPlatform)
    {
        // Close cart
        $cart->updateStatus("ordered");

        //echo "<pre>";print_r($cart);die;
        $order = new OrderRecord();
        $order->cartId = $cart->cartId;

        $voyantId = 0;
        $itemId = null;
        $paymentType = '';

        if($type==='VoyantQuestion') {
            $title = 'Question buy ' . $typeUser->firstName . ' ' . $typeUser->lastName;
            $voyantId = $typeUser->voyantId;
            $paymentType = $voyantId;
        }

        $packageId = null;
        if($type==='TimePack') {
            $title = 'Time Pack ' . $typeUser->firstName . ' ' . $typeUser->lastName;
            $paymentType = 'Platform';
        }

        if($type==='Platform') {
            $title = 'Time Pack with Question buy ' . $typeUser->firstName . ' ' . $typeUser->lastName;
            $voyantId = $typeUser->voyantId;
            $paymentType = 'Platform';
        }

        $totalAmount = $cart->baskets[ $paymentType ][ 'totalPrice' ];
        $orderItems = $cart->baskets[ $paymentType ][ 'items' ];

        /** @var CartItemRecord $cartItem */
        foreach ($orderItems as $orderItem) {
            $order->addItem(new OrderItemRecord($orderItem));
            if ('check' === $paymentMethod) {
                $cart->deleteItem($orderItem['cartItemId']);
            }
        }

        $userId = $this->userId;
        $invoiceNumber = rand(1,100);
        $sndPayType = null;
        if ($type == "VoyantQuestion") {
            $sndPayType = 'Voyant';
            $order
                ->setTitle($title)
                ->setAmount($totalAmount)
                ->setUserId($userId)
                ->setVoyantId($voyantId)
                ->setPaymentMethod($paymentMethod)
                ->setInvoiceNumber($invoiceNumber)
                ->setPaymentType($sndPayType)
                ->save($voyantId);
        }

        if ($type == "Platform") {
            $sndPayType = 'Platform';
            $order
                ->setTitle($title)
                ->setAmount($totalAmount)
                ->setUserId($userId)
                ->setVoyantId($voyantId)
                ->setPaymentStatus()
                ->setPaymentMethod($paymentMethod)
                ->setInvoiceNumber($invoiceNumber)
                ->setPaymentType($sndPayType)
                ->save($voyantId);
        }

        if ($type == "TimePack") {
            $sndPayType = 'Platform';
            $order
                ->setTitle($title)
                ->setAmount($totalAmount)
                ->setUserId($userId)
                ->setVoyantId($voyantId)
                ->setPaymentStatus()
                ->setPaymentMethod($paymentMethod)
                ->setInvoiceNumber($invoiceNumber)
                ->setPaymentType($sndPayType)
                ->save();
        }

        // } else if($type === 'VoyantQuestion' && $paymentExpertPlatform==0 || empty($paymentExpertPlatform)){
        //     $sndPayType = 'Platform';
        //     $order->setTitle($title)->setUserId($userId)->setVoyantId($voyantId)->setPaymentMethod($paymentMethod)->setInvoiceNumber($invoiceNumber)->setPaymentType($sndPayType)->save($voyantId);

        // }else if($type === 'Platform' && $paymentExpertPlatform==0 || empty($paymentExpertPlatform)){
        //     $sndPayType = 'Platform';
        //     $order->setTitle($title)->setUserId($userId)->setVoyantId($voyantId)->setPaymentStatus()->setPaymentMethod($paymentMethod)->setInvoiceNumber($invoiceNumber)->setPaymentType($sndPayType)->save($voyantId);

        // }else{
        //     //for time pack users only...
        //     $sndPayType = 'Platform';
        //     $order->setTitle($title)->setUserId($userId)->setVoyantId($voyantId)->setPaymentStatus()->setPaymentMethod($paymentMethod)->setInvoiceNumber($invoiceNumber)->setPaymentType($sndPayType)->save();
        // }
        return $order;
    }

    /**
     * @param $voyant
     * @param $order
     * @param $type
     */
    public function processPaymentOption($voyant, $order, $type)
    {
        if ('payPal' === $this->request->paymentMethod) {
            $paymentProcessor = new PayPalPaymentProcessor();
            if(($type==='VoyantQuestion' || $type==='Platform') && $voyant->paymentExpertPlatform==1){
                    $semail = $voyant->payPalEmail;
                //$semail = 'sb-xhb43w6399630@business.example.com';
            }else if($type==='VoyantQuestion' || $type==='Platform' && empty($voyant->paymentExpertPlatform) || $voyant->paymentExpertPlatform==0){
                $paymentprocessor = Model::factoryInstance('paymentprocessor')->findByPk('PayPal');
                $semail = $paymentprocessor->email;
            }else{
                $semail = '';
            }
            $paymentProcessor->setReceiverEmail($semail);
            $this->configurePaymentProcessor($paymentProcessor);
            $this->set('paymentDetails', $paymentProcessor->getPaymentDetails($order));
        }

        if ('check' === $this->request->paymentMethod) {
            Mailer::getInstance()->sendEmailToUserAfterUserChooseCheck($order->orderId);
            Mailer::getInstance()->sendEmailToVoyantAfterUserChooseCheck($order->orderId);
            $this->redirect($this->moduleLink('confirmation'));
        }
    }

    public function processPaymentOptionTimepack($user, $order, $type)
    {
        if ('payPal' === $this->request->paymentMethod) {
                $paymentProcessor = new PayPalPaymentProcessor();
                $paymentprocessor = Model::factoryInstance('paymentprocessor')->findByPk('PayPal');
                $semail = $paymentprocessor->email;

                $paymentProcessor->setReceiverEmail($semail);
                $this->configurePaymentProcessor($paymentProcessor);
                $this->set('paymentDetails', $paymentProcessor->getPaymentDetails($order));
        }
    }

    public function ipnAction()
    {
        $paymentProcessor = new PayPalPaymentProcessor();
        $paymentProcessor->handleIpn();
        $this->autoRender = false;
    }

    // public function getIntentAction()
    // {
    //     $json = file_get_contents('php://input');
    //     $data = json_decode($json);

    //     $voyantId = $data->voyantId;
    //     $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);
    //     $cart = $this->cart->getCart();
    //     //$cart->loadItems($voyantId);
    //     $cart->loadItems();
    //     $cart->loadBaskets();
    //     $currency = Config::get('currencyName');
    //     $result = (new StripePaymentProcessor())
    //                 ->setVoyant($voyant)
    //                 ->createIntent(
    //                 $this->userId,
    //                 $cart->totalPrice,
    //                 $currency
    //             );
    //     echo $result;
    //     exit;
    // }

    public function getIntentAction()
    {
        $json = file_get_contents('php://input');
        $data = json_decode($json);
        $type = $this->request->type;
        $paymentType = '';

        if($type != 'TimePack') {
            $voyantId = $this->request->voyantId;
            $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);
            if ($type == 'Platform') {
                $paymentType = 'Platform';
            } else {
                $paymentType = $voyantId;
            }
        } else {
            $paymentType = 'Platform';
        }

        $cart = $this->cart->getCart();
        $cart->loadItems();
        $cart->loadBaskets();

        $totalPrice = $cart->baskets[ $paymentType ][ 'totalPrice' ];
        $currency = Config::get('currencyName');

        if($this->request->type!='TimePack'){
            $result = (new StripePaymentProcessor())
                        ->setVoyant($voyant)
                        ->createIntent(
                        $this->userId,
                        $totalPrice,
                        $currency
                    );
        }

        if($this->request->type=='TimePack'){
            $result = (new StripePaymentProcessor())
                        ->createIntentOnlyForTimePack(
                        $this->userId,
                        $totalPrice,
                        $currency
                    );
        }
        echo $result;
        exit;
    }
    public function stripeSubmitAction()
    {
        $this->viewClass = 'JsonView';
        try {
            //echo "<pre>";print_r($this->request);die;
            $intentId = $this->request->intentId;
            // $packageId = $this->request->packageId;
            $type = $this->request->type;
            $paymentType = '';
            $voyantId = $type != 'TimePack' ?
                        $this->request->voyantId : '';

            $voyant = $type != 'TimePack' ?
                        Model::factoryInstance('voyant')->findByPk($voyantId) : null;

            $cart = $this->cart->getCart();
            $cart->loadItems();
            $cart->loadBaskets();

            // $cartID = $cart->cartId;
            // $cart['totalPrice'] = $this->getCartSelectedItemsPrice($type, $cartID, $voyantId, $packageId);
            // //echo "<pre>";print_r($cart);die;

            $typeUser = [];
            if ($type === "TimePack") {
                $typeUser = $this->user->findByPk(1);
                $paymentExpertPlatform = 0;
                $paymentType = 'Platform';
            }

            if($type==="Platform") {
                $typeUser = $voyant;
                $paymentExpertPlatform = $voyant->paymentExpertPlatform;
                $paymentType = 'Platform';
            }

            if($type==="VoyantQuestion") {
                $typeUser = $voyant;
                $paymentExpertPlatform = $voyant->paymentExpertPlatform;
                $paymentType = $voyantId;
            }

            $cart['totalPrice'] = $cart->baskets[ $paymentType ][ 'totalPrice' ];
            $cartItems = $cart->baskets[ $paymentType ][ 'items' ];
            $order = $this->createOrder($cart, $typeUser, 'stripe', $type, $paymentExpertPlatform);

            //$order = $this->createOrder($cart, $voyant, 'stripe');
            /** @var OrderRecord $createdOrder */
            $createdOrder = Model::factoryInstance('order')->findByPk($order->getOrderId());

            if($type==="VoyantQuestion" || $type==="Platform") {
                $submit = (new StripePaymentProcessor())
                    ->setOrderStatus($createdOrder->status)
                    ->setCurrentOrder($createdOrder)
                    ->setVoyant($voyant)
                    ->submit(
                        $this->request,
                        $this->userId,
                        $type,
                        $cartItems
                    );
            }

            if($type==="TimePack") {
                $submit = (new StripePaymentProcessor())
                    ->setOrderStatus($createdOrder->status)
                    ->setCurrentOrder($createdOrder)
                    ->submit(
                        $this->request,
                        $this->userId,
                        $type,
                        $cartItems
                    );
            }

            if ($submit) {
                $this->set('status', 'ok');
                $this->set('redirectUrl', Config::get('siteRootUrl') . AppRouter::getRewrittedUrl('/cart/confirmation', false));
                return;
            }
        } catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }
        return;
    }

    public function getUserCreditTimeAction($userId = 0, $voyantId = 0){
        $this->viewClass = 'JsonView';
         try{
            if(!empty($userId)){
                $sessUserId =  $userId;
            }
            else{
                $sessUserId =  $this->request->sessUserId;
            }
            $c = new Criteria();
            $c->add('userId', $sessUserId);
            $user = Model::factoryInstance('user')->findAll($c);
            $userID = $user[0]['userId'];
            if(!empty($userID)) {
                $d = new Criteria();
                $d->add('userId', $userID);
                $d->add('status', 'paid');
                $d->add('questionStatus', 'pending');
                $d->add('title', '%Time Pack%', 'LIKE');
                $orderItemsCriteria = new Criteria();
                $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
                $orderItemsCriteria->add('packId',NULL,'!=');
                $d->addWithRelation('orderItems', array('fields' => 'orderId,packid,packages.packageTime','criteria' => $orderItemsCriteria));
                $order = $this->order->findAll($d);

                $usedTime = 0;
                $e = new Criteria();
                $e->add('userId', $userID);
                $e->add('status', 'E');
                $userconsultation = $this->userConsultation->findAll($e);
               // echo "<pre>";print_r($userconsultation).'<<><>';die;
                if($userconsultation) {
                    foreach($userconsultation as $c_key=>$user_value) {
                        if($user_value['duration']!=NULL) {
                          $time = explode(':', $user_value['duration']);
                          $usedTime+= ($time[0]*60) + ($time[1]) + ($time[2]/60);
                        } else {
                            if($user_value['start_time']!=NULL && $user_value['end_time']!=NULL)
                            {
                                $datetime1 = new DateTime($user_value['start_time']);
                                $datetime2 = new DateTime($user_value['end_time']);
                                $interval = $datetime1->diff($datetime2);
                                $user_value['duration'] = $interval->format('%H:%I:%S');
                                $time = explode(':', $user_value['duration']);
                                $usedTime+= ($time[0]*60) + ($time[1]) + ($time[2]/60);
                            }
                        }
                    }
                }

                $totalTime = 0;
                if(isset($order) && !empty($order)) {
                   $packIds = [];
                   foreach($order as $torder){
                        foreach ($torder['orderItems'] as $key => $record){
                            $totalTime += $record['packageTime'];
                        }
                   }

                   //echo $totalTime.'<<><>'.$usedTime;die;
                   if($totalTime >= $usedTime){
                        $totalTime = $totalTime-$usedTime;
                   }else{
                        $totalTime = 0;
                   }

                    /*$hours = floor($totalTime / 60);
                    $min = $totalTime - ($hours * 60);
                    $seconds = $totalTime - ($min*60);*/
                    $init = $totalTime*60; // convert min. into seconds
                    $hours = floor($init / 3600);
                    $minutes = floor(($init / 60) % 60);
                    $seconds = $init % 60;
                    $hours = ($hours ? ($hours > 9 ? $hours : "0" . $hours) : "00");
                    $minutes = ($minutes ? ($minutes > 9 ? $minutes : "0" . $minutes) : "00");
                    $seconds = ($seconds ? ($seconds > 9 ? $seconds : "0" . $seconds) : "00");
                    $totTime = $hours."h ".$minutes."m ".$seconds."s";

                    $start = $this->userConsultation->getActiveStartSession($voyantId);
					$date = new DateTime('now', new DateTimeZone('Europe/Paris'));
                    $timeSpent = floor(abs(strtotime($date->format("Y-m-d H:i:s")) - strtotime($start)) / 60);
                    if(!empty($userId)){
                        echo json_encode(["time" => $totTime, "totalTime" => floor($totalTime-$timeSpent)]);
                    }
                    else{
                        $this->set('time', $totTime);
                    }

                    return;
                }
            }

         } catch (\Exception $e) {
            $this->set('status', 'error');
            $this->set('message', $e->getMessage());
            return;
        }
        return;

    }

    public function getMaxUserCreditTimeAction($voyantId = 0)
    {
        $userId = $this->userConsultation->getActiveUser($voyantId);
        $this->getUserCreditTimeAction($userId, $voyantId);
        return false;
    }


     /**
     * Get all Package Details...
     */
    public function packAction()
    {
        $c = new Criteria();
        $c->add('packageDisplay', 1);
        $packages = Model::factoryInstance("package")->findAll($c);
        $this->set('packages', $packages);
    }

     /**
     * @param $packageId
     * Add Time Pacakge in the table cartItems...
     */
    public function addPackAction($packageId)
    {
        $timePackage = $this->package->findByPk($packageId);
        $this->set('timePackage', $timePackage);
        $quantity = 1;
        $totalPrice = $timePackage['packagePrice'];
        $cart = $this->cart->getCart();
        $c = new Criteria();
        $c->add('cartId', $cart->cartId);
        $c->add('type', 'TimePack');
        $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        if(!empty($cartItems[0]['itemId'])){
            $packId = $cartItems[0]['itemId'];
        }else{
             $packId = $packageId;
        }
        $type = "TimePack";
        $voyantId = 0;
        $cart->addItem($packageId, $timePackage['packageName'], $quantity,
        $totalPrice, $voyantId, $packId, $type);
    }

    /**
     * @param $cartId
     * Empty the Cart using cartid...
     */
    function getCartEmpty($cartID){
        $cart = Model::factoryInstance('cart')->findByPk($cartID);
            $c = new Criteria();
            $c->add('cartId', $cart->cartId);
            $cartItems = Model::factoryInstance('cartItem')->findAll($c);
            foreach ($cartItems as $cartItem) {
                $cart->deleteItem($cartItem['cartItemId']);
            }
            $this->redirect($this->moduleLink('confirmation'));
    }

    public function confirmationAction()
    {
        //
    }
}

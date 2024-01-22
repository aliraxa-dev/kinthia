<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class PayPalPaymentProcessor extends PaymentProcessor
{
    private $processorId = "PayPal";
    private $normalFormActionUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr";
    private $testModeFormActionUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr";
    private $currentOrder;
    private $debug = true;
    private $receiverEmail;

    public function __construct()
    {
        parent::__construct($this->processorId);
    }

    public function getActionUrl()
    {
        if ($this->settings->testMode) {
            return $this->testModeFormActionUrl;
        } else {
            return $this->normalFormActionUrl;
        }
    }

    public function getPaymentDetails(OrderRecord $order)
    {
        $setting = $this->settings->toArray();
        $formFields = array(
            "cmd" => "_cart",
            "upload" => "1",
            "business" => $this->receiverEmail,
            "custom" => $order->getOrderId(),
            "currency_code" => $order->getCurrency(),
            "no_shipping" => "1",
            "no_note" => "1",
            "rm" => "2");

            $voyantQuestionArr = []; $packageArr = []; $orderItemTbl = [];
            foreach ($order->getOrderItemArr() as $orderItem) {
                // $lp++;
                // $formFields['item_name_' . $lp] = $orderItem['voyantQuestion']['title'];
                // $formFields['amount_' . $lp] = $orderItem['voyantQuestion']['price'];
                // $formFields['quantity_' . $lp] = $orderItem['quantity'];

                // $standardTotalPrice = $orderItem['voyantQuestion']['price'] * $orderItem['quantity'];
                // $formFields['discount_amount_' . $lp] = $standardTotalPrice - $orderItem['totalPrice'];

                if(!empty($orderItem['itemId'])){
                    $voyantQuestionArr[][$orderItem['quantity']] = Model::factoryInstance('voyantQuestion')->findByPk($orderItem['itemId'])->toArray();
                }

                if(!empty($orderItem['packId'])){
                    $packageArr[][$orderItem['quantity']] = Model::factoryInstance('package')->findByPk($orderItem['packId'])->toArray();
                }
                //$orderItemTbl[] = $orderItem;
            }

           $lp = 0;
           $jointArr = array_merge($voyantQuestionArr,$packageArr);
           if(isset($jointArr) && !empty($jointArr)){
           foreach ($jointArr as $key=> $orderItems) {
            foreach ($orderItems as $qty=> $orderItem) {
                $lp++;
                //Title...
                if(!empty($orderItem['title'])){
                    $formFields['item_name_' . $lp] = $orderItem['title'];
                }

                if(!empty($orderItem['packageName'])){
                    $formFields['item_name_' . $lp] = $orderItem['packageName'];
                }

                //Price...
                if(!empty($orderItem['price'])){
                    $formFields['amount_' . $lp] = $orderItem['price'];
                }

                if(!empty($orderItem['packagePrice'])){
                    $formFields['amount_' . $lp] = $orderItem['packagePrice'];
                }

                if(!empty($orderItem['questionId'])){

                  $formFields['quantity_' . $lp] = $qty;
                  if(!empty($orderItem['price'])){
                    $standardTotalPrice = $orderItem['price'] * $qty;
                  }
                  $formFields['discount_amount_' . $lp] = $standardTotalPrice - $orderItem['price'];
               }

               if(!empty($orderItem['packageId'])){
                  $formFields['quantity_' . $lp] = $qty;
                  if(!empty($orderItem['packagePrice'])){
                    $standardTotalPrice = $orderItem['packagePrice'] * $qty;
                  }
                  $formFields['discount_amount_' . $lp] = $standardTotalPrice - $orderItem['packagePrice'];
               }
            }}
        }

        if (!empty($setting['notifyUrl'])) {
            $formFields['notify_url'] = $setting['notifyUrl'];
        }

        if (!empty($setting['returnUrl'])) {
            $formFields['return'] = $setting['returnUrl'];
        }

        if (!empty($setting['cancelReturnUrl'])) {
            $formFields['cancel_return'] = $setting['cancelReturnUrl'];
        }

        //echo "<pre>";print_r($setting);
        //echo "<pre>";print_r($formFields);die;
        $paymentDetails = array("setting" => $setting,
            "order" => array("title" => $order->getTitle(),
            "amount" => $order->getAmount()),
            "actionUrl" => $this->getActionUrl(),
            "formFields" => $formFields);

        return $paymentDetails;
    }

    public function processPayment()
    {
        return true;
    }

    public function setNotifyUrl($url)
    {
        $this->settings->notifyUrl = $url;
        return $this;
    }

    public function setCancelReturnUrl($url)
    {
        $this->settings->cancelReturnUrl = $url;
        return $this;
    }

    public function setReturnUrl($url)
    {
        $this->settings->returnUrl = $url;
        return $this;
    }

    private function payLog($msg, $type = "error") //$type = normal or error
    {
        if ($this->debug) {
            if ($type == "error") {
                $msg = "ERROR: " . $msg;
            }
            $msg = "<br/>" . date("Y-m-d H:i:s") . " " . $msg . "<br/>";
            $fp = fopen(CODE_ROOT_DIR . "ipn.html", "a");
            fwrite($fp, $msg);
            fclose($fp);
        }

        return ($type != "error");
    }

    private function onComplete($ipnData)
    {
        if (in_array($this->currentOrder->status, array("unpaid", "pending"))) {
            $this->payLog("Current order status: " . $this->currentOrder->status); // Log the current order status

            $this->currentOrder->setStatus("paid", array('ipnData' => $ipnData));
            $this->payLog("Order status set to paid"); // Log when the order status is set to paid

            $cartID = $this->currentOrder->cartId;
            $this->getCartEmpty($cartID);
            $this->payLog("Cart emptied"); // Log when the cart is emptied

            $this->updateQuestionData($ipnData);

            $this->payLog("Payment was completed successfully");
            return true;
        }
    }

     private function getCartEmpty($cartID){
        // $cart = Model::factoryInstance('cart')->findByPk($cartID);
        // if(isset($cart) && !empty($cart)){
        //     $c = new Criteria();
        //     $c->add('cartId', $cart->cartId);
        //     $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        //     foreach ($cartItems as $cartItem) {
        //         $cart->deleteItem($cartItem['cartItemId']);
        //     }
        //     return true;
        // }

        $vID = 0;
        $orderData = Model::factoryInstance('order')->findByPk($this->currentOrder->getOrderId());
        if(!empty($orderData->voyantId)){
            $vID = $orderData->voyantId;
        }

        $paymentExpertPlatform = 0;
        if($vID > 0){
            $voyant = Model::factoryInstance('voyant')->findByPk($vID);
            $paymentExpertPlatform = $voyant->paymentExpertPlatform;
        }

        $cart = Model::factoryInstance('cart')->findByPk($cartID);
        if(!empty($orderData->voyantId) && $orderData->type=='Voyant' && $paymentExpertPlatform > 0){
            $c = new Criteria();
            $c->add("voyantId", $vID);
            $c->add("cartId", $this->currentOrder->cartId);
            $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        }

        if(!empty($orderData->voyantId) && $orderData->type=='Voyant' &&  $paymentExpertPlatform == 0 || empty($paymentExpertPlatform)){
            $c = new Criteria();
            $c->add("voyantId", $vID);
            $c->add("cartId", $this->currentOrder->cartId);
            $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        }

        if(!empty($orderData->voyantId) && $orderData->type=='Platform'){

            $d = new Criteria();
            $d->add("voyantId", $orderData->voyantId);
            $d->add("cartId", $this->currentOrder->cartId);
            $cartItems1 = Model::factoryInstance('cartItem')->findAll($d);

            $c = new Criteria();
            $c->add('type', 'TimePack');
            $c->add("cartId", $this->currentOrder->cartId);
            $cartItems2 = Model::factoryInstance('cartItem')->findAll($c);

            $cartItems = array_merge($cartItems1,$cartItems2);
        }

        if($orderData->type=='Platform' && (empty($orderData->voyantId) || $orderData->voyantId==0)){
            $c = new Criteria();
            $c->add('type', 'TimePack');
            $c->add("cartId", $this->currentOrder->cartId);
            $cartItems1 = Model::factoryInstance('cartItem')->findAll($c);

            $d = new Criteria();
            $d->add("voyantId", 0);
            $d->add("cartId", $this->currentOrder->cartId);
            $cartItems2 = Model::factoryInstance('cartItem')->findAll($d);

            $cartItems = array_merge($cartItems1,$cartItems2);
        }
        // echo "<pre>";print_r($cartItems);die;
        foreach ($cartItems as $cartItem) {
            $cart->deleteItem($cartItem['cartItemId']);
        }
    }

    private function onPending()
    {
        if ($this->currentOrder->status == "unpaid") {

            $myfile = fopen("newfilePending.txt", "w") or die("Unable to open file!");
            $txt = print_r($this->currentOrder->status, true);
            fwrite($myfile, $txt);

            $this->currentOrder->setStatus("pending");
            $this->payLog("Payment status was changed to pending");
        }
    }

    private function onDenied()
    {
         $this->currentOrder->setStatus("denied");
    }

    private function validatePayment($ipnData)
    {
        if (empty($this->currentOrder)) {
            return "Payment don't exists";
        }

        $voyantId = $this->currentOrder->voyantId;
        if(!empty($voyantId)){
            $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);

            if ($ipnData['receiver_email'] != $voyant->payPalEmail) {
                return "Bad receiver mail";
            }
            if ($ipnData['mc_gross'] != $this->currentOrder->amount) {
                return "Bad amount";
            }
            if ($ipnData['mc_currency'] != $this->currentOrder->currency) {
                return "Bad currency";
            }
        }
        return "";
    }

    public function handleIpn()
    {
        $ipnData = Request::getInstance()->toArray();
        $postData = 'cmd=_notify-validate';

        foreach ($ipnData as $key => $value) {
            $postData .= "&" . urlencode($key) . "=" . urlencode($value);
        }

        $httpClient = new HttpClient();
        $url = $this->getActionUrl();
        $buff = $httpClient->getSiteContent($url, false, true, false, "POST", $postData);


        if (strcmp($buff, "VERIFIED") != 0) {
            return $this->payLog("Request isn't VERIFIED", "error");
        }

        $orderId = $ipnData['custom'];
        $currOrder = Model::factoryInstance("order")->findByPk($orderId);
        $this->currentOrder = $currOrder;

        if (empty($this->currentOrder)) {
            return $this->payLog("Order not found", "error");
        }

        $errorMessage = $this->validatePayment($ipnData);
        if ($errorMessage) return $this->payLog($errorMessage, "error");

        $txn_type = $ipnData['txn_type'];
        $payment_status = $ipnData['payment_status'];
        $this->payLog("Status " . $payment_status);
        switch ($txn_type) {
            case "cart":
                switch ($payment_status) {
                    case "Completed":
                        $this->onComplete($ipnData);
                        break;
                    case "Pending":
                        $this->onPending();
                        break;
                    case "Denied":
                        $this->onDenied();
                        break;
                }
                break;
            default:
                return $this->payLog("Unhandled txn_type", "error");
        }


        return $this->payLog("Finished");
    }
    public function setReceiverEmail($email)
    {
        $this->receiverEmail = $email;
    }

    private function updateQuestionData($ipnData) {
        if ($ipnData['payment_status'] == "Completed") {
            $order = $this->currentOrder;
            if ($order->paymentMethod == "payPal") {
                $type = $order->type;

                $a = new Criteria();
                $a->add('orderId', $order->orderId);
                $cartItems = Model::factoryInstance('orderItem')->findAll($a);

                $voyant = Model::factoryInstance('voyant')->findByPk($order->voyantId);

                foreach ($cartItems as $cartItem) {
                    $vatExclude = 1 + ($voyant->tva / 100);
                    $voyantQPercentage = $voyant->paidBackQuestion;
                    $questionPrice = $cartItem['totalPrice'];
                    $priveVatExcluded = ($questionPrice / $vatExclude);

                    if ($order->type === 'Voyant' && $voyant->displayTvaOnInvoice === '1') {
                        // Expert receives 100% of the money, including VAT
                        $expertEarning = $questionPrice;
                    } else {
                        // Calculate the expert's earning based on the percentage
                        $expertEarning = ($voyantQPercentage / 100) * $priveVatExcluded;
                    }

                    $data = array('expertQEarning' => $expertEarning, 'whoIsPaid' => $type);
                    $userQuestion = new UserQuestionRecord;

                    $c = new Criteria();
                    $c->add('orderId', $order->orderId);
                    $c->add('voyantQuestionId', $cartItem['itemId']);
                    $c->add('voyantId', $order->voyantId);

                    $userQuestion->update($data, $c);
                }

            }

        }
    }

}

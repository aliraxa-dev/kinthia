<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/**
 * Class StripePaymentProcessor
 */
class StripePaymentProcessor extends PaymentProcessor
{
    /** @var string  */
    private $processorId = "Stripe";

    /** @var OrderRecord */
    private $currentOrder;

    /** @var bool  */
    private $debug = true;

    /** @var VoyantRecord */
    private $voyant;

    /** @var string */
    private $orderStatus;

    /**
     * StripePaymentProcessor constructor.
     */
    public function __construct()
    {
        parent::__construct($this->processorId);
        require_once(CODE_ROOT_DIR . 'components/stripe/init.php');
    }

    /**
     * @param $request
     * @param $userId
     * @throws Exception
     * @return bool
     */
    public function submit($request, $userId, $type, $cartItems)
    {
        if($type==="VoyantQuestion" || $type==="Platform") {
            \Stripe\Stripe::setApiKey($this->getVoyant()->stripeSecretKey);
        }

        if($type==="TimePack") {
            \Stripe\Stripe::setApiKey('sk_test_a3dGzXANyQLiurVkHc8K7oHy');
        }

        $user = Model::factoryInstance('user')->findByPk($userId);     
        
        
        // update intent        
        try {
            $paymentIntent = \Stripe\PaymentIntent::update($request->intentId, [
                'description' => sprintf('Order ID: %s Name: %s', $this->currentOrder->getOrderId(), $user->name),
                'metadata' => array(
                    'order_id' => $this->currentOrder->getOrderId(),
                    'user_id' => $userId
                ),
            ]);    
            $this->currentOrder->setStatus("paid", array('stripeData' => $request->intentId));
        }
        catch (Error $e) {
            http_response_code(500);
            $result = json_encode(['error' => $e->getMessage()]);
        }

        //getting Order
        $vID = 0;
        $orderData = Model::factoryInstance('order')->findByPk($this->currentOrder->getOrderId());
        if(!empty($orderData->voyantId)) {
            $vID = $orderData->voyantId;
        }
       
        $paymentExpertPlatform = 0;
        if($vID > 0) {
            $voyant = Model::factoryInstance('voyant')->findByPk($vID);
            $paymentExpertPlatform = $voyant->paymentExpertPlatform; 
        }
        
        /** @var CartRecord $cart */
        $cart = Model::factoryInstance('cart')->findByPk($this->currentOrder->cartId);
          
        $c = new Criteria();
        $c->add("orderId", $this->currentOrder->getOrderId());

        // if(!empty($orderData->voyantId) && $orderData->type=='Voyant' && $paymentExpertPlatform > 0) {
        //     $c = new Criteria();
        //     $c->add("voyantId", $vID);
        //     $c->add("cartId", $this->currentOrder->cartId);
        //     $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        // }

        // if(!empty($orderData->voyantId) && $orderData->type=='Voyant' &&  $paymentExpertPlatform == 0 || empty($paymentExpertPlatform)){
        //     $c = new Criteria();
        //     $c->add("voyantId", $vID);
        //     $c->add("cartId", $this->currentOrder->cartId);
        //     $cartItems = Model::factoryInstance('cartItem')->findAll($c);
        // }

        // // if(!empty($orderData->voyantId) && $orderData->type=='Platform'){
        
        // //     $d = new Criteria();
        // //     $d->add("voyantId", $orderData->voyantId);
        // //     $d->add("cartId", $this->currentOrder->cartId);
        // //     $cartItems1 = Model::factoryInstance('cartItem')->findAll($d);

        // //     $c = new Criteria();
        // //     $c->add('type', 'TimePack');
        // //     $c->add("cartId", $this->currentOrder->cartId);
        // //     $cartItems2 = Model::factoryInstance('cartItem')->findAll($c);

        // //     $cartItems = array_merge($cartItems1,$cartItems2);
        // // }

        // if($orderData->type=='Platform' && (empty($orderData->voyantId) || $orderData->voyantId==0)){
        //     $c = new Criteria();
        //     $c->add('type', 'TimePack');
        //     $c->add("cartId", $this->currentOrder->cartId);
        //     $cartItems1 = Model::factoryInstance('cartItem')->findAll($c);

        //     $d = new Criteria();
        //     $d->add("voyantId", 0);
        //     $d->add("cartId", $this->currentOrder->cartId);
        //     $cartItems2 = Model::factoryInstance('cartItem')->findAll($d);

        //     $cartItems = array_merge($cartItems1,$cartItems2);
        // }

       // echo "<pre>";print_r($cartItems);die;
        foreach ($cartItems as $cartItem) {
            $cart->deleteItem($cartItem['cartItemId']);
        }
        
        $this->payLog("Payment was completed successfully");
        return true;
    }
    /*
        @return clientSecret
        Amit Dave
    */
    public function createIntent($userId,$amount,$currency)
    {
        \Stripe\Stripe::setApiKey($this->getVoyant()->stripeSecretKey);
        //\Stripe\Stripe::setApiKey('sk_test_a3dGzXANyQLiurVkHc8K7oHy');
        
        $user = Model::factoryInstance('user')->findByPk($userId);
        $customer = \Stripe\Customer::create(array(
            'email' => $user->email,
        ));
        try {
            $paymentIntent = \Stripe\PaymentIntent::create([
                'amount' => $amount * 100,
                'currency' => $currency,
                'customer' => $customer,
                'description' => '',
                'metadata' => array(
                    'order_id' => '',
                    'user_id' => $userId
                ),
                
            ]);  
            // print_r($paymentIntent);       
            
            $output = [
                'clientSecret' => $paymentIntent->client_secret,
                'intentId' => $paymentIntent->id,
            ];
        
            $result = json_encode($output); 
            
        } catch (Error $e) {
              http_response_code(500);
              $result = json_encode(['error' => $e->getMessage()]);
        }
        
        return $result;
    }

    /*
        @return clientSecret
        Amit Dave
    */
    public function createIntentOnlyForTimePack($userId,$amount,$currency)
    {
        //\Stripe\Stripe::setApiKey($this->getVoyant()->stripeSecretKey);
        $paymentprocessor = Model::factoryInstance('paymentprocessor')->findByPk('Stripe');
        if(!empty($paymentprocessor->stripePrivateKey)){            
            //\Stripe\Stripe::setApiKey($paymentprocessor->stripePrivateKey);
           \Stripe\Stripe::setApiKey('sk_test_a3dGzXANyQLiurVkHc8K7oHy');
            $user = Model::factoryInstance('user')->findByPk($userId);
            $customer = \Stripe\Customer::create(array(
                'email' => $user->email,
            ));
            try {
                $paymentIntent = \Stripe\PaymentIntent::create([
                    'amount' => $amount * 100,
                    'currency' => $currency,
                    'customer' => $customer,
                    'description' => '',
                    'metadata' => array(
                        'order_id' => '',
                        'user_id' => $userId
                    ),
                    
                ]);         
                
                $output = [
                    'clientSecret' => $paymentIntent->client_secret,
                    'intentId' => $paymentIntent->id,
                ];
            
                $result = json_encode($output); 
                
            } catch (Error $e) {
                http_response_code(500);
                $result = json_encode(['error' => $e->getMessage()]);
            }
            
            return $result;
        }        
    }

    /**
     * @param $msg
     * @param string $type
     * @return bool
     */
    private function payLog($msg, $type = "error") //$type = normal or error
    {
        if ($this->debug) {
            if ($type == "error") {
                $msg = "ERROR: " . $msg;
            }
            $fp = fopen(CODE_ROOT_DIR . "ipn.html", "a");
            fwrite($fp, $msg);
            fclose($fp);
        }

        return ($type != "error");
    }

    /**
     * @param OrderRecord $order
     * @return |null
     */
    public function getPaymentDetails(OrderRecord $order)
    {
        return null;
    }

    public function processPayment()
    {

    }

    /**
     * @param $url
     * @return $this
     */
    public function setNotifyUrl($url)
    {
        $this->settings->notifyUrl = $url;
        return $this;
    }

    /**
     * @param $url
     * @return $this
     */
    public function setCancelReturnUrl($url)
    {
        $this->settings->cancelReturnUrl = $url;
        return $this;
    }

    /**
     * @param $url
     * @return $this
     */
    public function setReturnUrl($url)
    {
        $this->settings->returnUrl = $url;
        return $this;
    }

    /**
     * @param OrderRecord $currentOrder
     * @return StripePaymentProcessor
     */
    public function setCurrentOrder(OrderRecord $currentOrder)
    {
        $this->currentOrder = $currentOrder;
        return $this;
    }

    /**
     * @return VoyantRecord
     */
    public function getVoyant(): VoyantRecord
    {
        return $this->voyant;
    }

    /**
     * @param VoyantRecord $voyant
     * @return StripePaymentProcessor
     */
    public function setVoyant(VoyantRecord $voyant): StripePaymentProcessor
    {   
        $this->voyant = $voyant;
        return $this;
    }

    /**
     * @return string
     */
    public function getOrderStatus(): string
    {
        return $this->orderStatus;
    }

    /**
     * @param string $orderStatus
     * @return StripePaymentProcessor
     */
    public function setOrderStatus(string $orderStatus): StripePaymentProcessor
    {
        $this->orderStatus = $orderStatus;
        return $this;
    }
}
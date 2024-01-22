<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
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
    public function submit($request, $userId)
    {
        if (empty($request->stripeToken)) {
            return false;
        }
        \Stripe\Stripe::setApiKey($this->getVoyant()->stripeSecretKey);

        $user = Model::factoryInstance('user')->findByPk($userId);
        $customer = \Stripe\Customer::create(array(
            'email' => $user->email,
            'source' => $request->stripeToken
        ));


        $charge = \Stripe\Charge::create(array(
            'customer' => $customer->id,
            'amount' => $this->currentOrder->amount * 100,
            'currency' => $this->currentOrder->currency,
            'description' => sprintf('Order ID: %s Name: %s', $this->currentOrder->getOrderId(), $user->name),
            'capture' => $this->getVoyant()->stripeCaptureCharge === 1 ? false : true,
            'metadata' => array(
                'order_id' => $this->currentOrder->getOrderId(),
                'user_id' => $userId
            )
        ));

        $chargeJson = $charge->jsonSerialize();

        $this->currentOrder->stripeData = json_encode([
            'id' => $chargeJson['id'] ?? null
        ]);

        if (
            $chargeJson['amount_refunded'] == 0 &&
            empty($chargeJson['failure_code']) &&
            $chargeJson['paid'] == 1
            && $chargeJson['captured'] == 1
        ) {
            $status = $chargeJson['status'];
            if (
                $status == 'succeeded' &&
                in_array($this->getOrderStatus(), array("unpaid", "pending"))
            ) {
                $this->currentOrder->setStatus("paid");
                /** @var CartRecord $cart */
                $cart = Model::factoryInstance('cart')->findByPk($this->currentOrder->cartId);
                $c = new Criteria();
                $c->add('cartId', $cart->cartId);
                $cartItems = Model::factoryInstance('cartItem')->findAll($c);
                /** @var CartItemRecord $cartItem */
                foreach ($cartItems as $cartItem) {
                    $cart->deleteItem($cartItem['cartItemId']);
                }
                $this->payLog("Payment was completed successfully");
                return true;
            } else {
                $this->currentOrder->setStatus("denied");
                return false;
            }
        } else {
            $this->currentOrder->setStatus("unpaid");
            return false;
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

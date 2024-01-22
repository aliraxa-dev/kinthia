<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
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

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->session->set('redirectUrl', $this->request->getCurrentUrl());
            $this->redirect(AppRouter::getRewrittedUrl('/user'));
        }
    }

    public function addItemAction($voyantQustionId, $priceId = null)
    {
        $voyantQuestion = $this->voyantQuestion->findByPk($voyantQustionId);

        if (!empty($priceId)) {
            $voyantQuestionPrice = $this->voyantQuestionPrice->findByPk($priceId);
            $this->set('voyantQuestionPrice', $voyantQuestionPrice);
        }

        $this->set('voyantQuestion', $voyantQuestion);

        $cart = $this->cart->getCart();

        if (!empty($voyantQuestionPrice)) {
            $quantity = $voyantQuestionPrice['quantity'];
            $totalPrice = $voyantQuestionPrice['price'];
        } else {
            $quantity = 1;
            $totalPrice = $voyantQuestion['price'];
        }

        $cart->addItem($voyantQustionId, $voyantQuestion['title'], $quantity,
            $totalPrice, $voyantQuestion->voyantId);
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

    public function paymentDetailsAction($voyantId)
    {
        $voyant = $this->voyant->findByPk($voyantId);
        $this->set('voyant', $voyant);

        $cart = $this->cart->getCart();
        $cart->loadItems();
        $cart->loadBaskets();

        $this->set('cart', $cart);
    }

    private function configurePaymentProcessor($paymentProcessor)
    {
        $notifyUrl = Config::get('siteRootUrl') . $this->moduleLink('ipn', false);
        $returnUrl = Config::get('siteRootUrl') . AppRouter::getRewrittedUrl('/cart/confirmation', false);
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
        $voyantId = $this->request->voyantId;
        $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);

        if (empty($voyant)) {
            throw new Exception('Undefined voyant');
        }

        $paymentMethod = $this->request->paymentMethod;
        if (empty($paymentMethod)
            || !in_array($paymentMethod, array('payPal', 'check', 'stripe'))
        ) {
            throw new Exception('Unsupported payment method');
        }

        $cart = $this->cart->getCart();
        $cart->loadItems($voyantId);
        $cart->loadBaskets();

        $this->set('cart', $cart);


        $order = $this->createOrder($cart, $voyant, $paymentMethod);

        $this->processPaymentOption($voyant, $order);
    }

    /**
     * @param CartRecord $cart
     * @param VoyantRecord $voyant
     * @param string $paymentMethod
     * @return OrderRecord
     */
    private function createOrder($cart, $voyant, $paymentMethod)
    {
        $order = new OrderRecord();
        $order->cartId = $cart->cartId;
        /** @var CartItemRecord $cartItem */
        foreach ($cart->cartItems as $cartItem) {
            $order->addItem(new OrderItemRecord($cartItem));
            if ('check' === $paymentMethod) {
                $cart->deleteItem($cartItem['cartItemId']);
            }
        }

        $userId = $this->userId;
        $title = 'Question buy ' . $voyant->firstName . ' ' . $voyant->lastName;
        $order->setTitle($title)
            ->setUserId($userId)
            ->setVoyantId($voyant->voyantId)
            ->setPaymentMethod($paymentMethod)
            ->save();

        return $order;
    }

    /**
     * @param $voyant
     * @param $order
     */
    public function processPaymentOption($voyant, $order)
    {
        if ('payPal' === $this->request->paymentMethod) {
            $paymentProcessor = new PayPalPaymentProcessor();
            $paymentProcessor->setReceiverEmail($voyant->payPalEmail);
            $this->configurePaymentProcessor($paymentProcessor);
            $this->set('paymentDetails', $paymentProcessor->getPaymentDetails($order));
        }

        if ('check' === $this->request->paymentMethod) {
            Mailer::getInstance()->sendEmailToUserAfterUserChooseCheck($order->orderId);
            Mailer::getInstance()->sendEmailToVoyantAfterUserChooseCheck($order->orderId);

            $this->redirect($this->moduleLink('confirmation'));
        }
    }

    public function ipnAction()
    {
        $paymentProcessor = new PayPalPaymentProcessor();
        $paymentProcessor->handleIpn();
        $this->autoRender = false;
    }

    public function stripeSubmitAction()
    {
        $this->viewClass = 'JsonView';
        try {
            $voyantId = $this->request->voyantId;
            $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);
            $cart = $this->cart->getCart();
            $cart->loadItems($voyantId);
            $cart->loadBaskets();
            $order = $this->createOrder($cart, $voyant, 'stripe');
            /** @var OrderRecord $createdOrder */
            $createdOrder = Model::factoryInstance('order')->findByPk($order->getOrderId());
            $submit = (new StripePaymentProcessor())
                ->setOrderStatus($createdOrder->status)
                ->setCurrentOrder($createdOrder)
                ->setVoyant($voyant)
                ->submit(
                    $this->request,
                    $this->userId
                );
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

    public function confirmationAction()
    {

    }
}

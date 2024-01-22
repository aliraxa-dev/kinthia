<?php

/**
 * Class PaymentProcessor
 */
abstract class PaymentProcessor extends CoreObject
{
    protected $settings;

    abstract function getPaymentDetails(OrderRecord $order);

    function __construct($processId)
    {
        $this->settings = Model::factoryInstance("paymentProcessor")->findByPk($processId);
    }
}

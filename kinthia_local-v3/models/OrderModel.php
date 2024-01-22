<?php
//////////////////////////////////////////////////////////////////////////////////
//                       copyright (c) Arfooo Annuaire                          //
//                   by Hocine Guillaume (c) 2007 - 2008                        //
//                          http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class OrderModel extends Model
{
    protected $primaryKey = 'orderId';
    protected $relations = array('user'   => array('type'       => 'oneToOne',
                                                   'foreignKey' => 'userId'),

                                 'voyant' => array('type'       => 'oneToOne',
                                                   'foreignKey' => 'voyantId'),

                                 'orderItems' => array('type'       => 'oneToMany',
                                                       'foreignKey' => 'orderId'),
                                 'cart' => array('type'       => 'oneToOne',    
                                                          'foreignKey' => 'cartId'),    
                                'cartitem' => array('type'       => 'oneToOne', 
                                                          'foreignKey' => 'cartId'),

                                 'userQuestions' => array('type'       => 'oneToMany',
                                                          'foreignKey' => 'orderId')
                                                   );
}

class OrderRecord extends ModelRecord
{
    private $items = array();

    function setTitle($title)
    {
        $this->title = $title;
        return $this;
    }

    function getTitle()
    {
        return $this->title;
    }

    function getOrderId()
    {
        return $this->orderId;
    }

    function addItem($item)
    {
        $this->items[] = $item;
        return $this;
    }

    function setAmount ($amount) {
        $this->amount = $amount;
        return $this;
    }

    function setUserId($userId)
    {
        $this->userId = $userId;
        return $this;
    }

    function setVoyantId($voyantId)
    {
        $this->voyantId = $voyantId;
        return $this;
    }

    //for time packs package id
    function setPackageId($packageId)
    {
        $this->packageId = $packageId;
        return $this;
    }

    //for Type...
    function setPaymentType($type)
    {
        $this->type = $type;
        return $this;
    }

    function setPaymentStatus()
    {
        $this->status = 'pending';
        return $this;
    }

    function setItemId($itemId)
    {
        $this->itemId = $itemId;
        return $this;
    }

    function setInvoiceNumber($invoiceNumber){
        $this->invoiceId = $invoiceNumber;
        return $this;
    }

    function setPaymentMethod($paymentMethod)
    {
        $this->paymentMethod = $paymentMethod;
        return $this;
    }

    function getAmount()
    {
        return $this->amount;
    }

    function getCurrency()
    {
        return $this->currency;
    }

    function save($voyantId=NULL)
    {
        if (!$this->_new) {
            parent::save();
            return;
        }

        // foreach ($this->items as $item) {
        //     $data = explode('||', $item->quantity);

        //     if(!empty($data[1]) && $data[1] > 0) {
        //         if($voyantId > 0 && $data[1]==$voyantId) {
        //             $amount += $item->totalPrice;
        //         }
        //     } else {
        //         if(!empty($voyantId)) {
        //             $voyant = Model::factoryInstance('voyant')->findByPk($voyantId);
        //             if ($voyant->paymentExpertPlatform==0 || empty($voyant->paymentExpertPlatform)) {
        //                 $amount += $item->totalPrice;
        //             }
        //         } else {
        //             if (isset($item->packId) && !empty($item->packId) && $data[1] == 0) {
        //                 $amount += $item->totalPrice;
        //             }
        //         }
        //     }
        // }

        // //Save data into order table
        // $this->amount = $amount;

        $this->currency = Config::get('currencyName');
        $this->ip = Request::getInstance()->getIp();
        if ($this->paymentMethod == 'check') {
            $this->status = 'pending';
        }

        parent::save();

        //Save data into order details table
        foreach ($this->items as $item) {
            $data = explode('||', $item->quantity);
            $item->orderId = $this->orderId;
            $item->quantity = $data[0];
            $item->save();
        }
    }

    public function getStatus()
    {
        return $this->status;
    }

    public function getOrderItems()
    {
        $c = new Criteria();
        $c->add('orderId', $this->orderId);
        $c->add('itemId', null, '!=');
        $c->addWithRelation('voyantQuestion', array('fields' => 'price, title'));
        return Model::factoryInstance('orderItem')->findAll($c);
    }

    public function getOrderItemArr()
    {
        $c = new Criteria();
        $c->add('orderId', $this->orderId);
        return Model::factoryInstance('orderItem')->findAll($c);
    }

    private function saveInvoiceData()
    {
        $currentOrder = Model::factoryInstance('order')->findByPk($this->orderId);
        $c = new Criteria();
        $c->add('orderId', $this->orderId);
        $c->addWithRelation('user', array('fields' => 'name, firstName, lastName'));
        if(!empty($currentOrder->voyantId) && ($currentOrder->type==="Voyant" || $currentOrder->type==="Platform")){
            $c->addWithRelation('voyant', array(
                                    'fields' => 'firstName, lastName, address, companyTaxNumber, tva,
                                                displayNameOnInvoice, name, displayFirstNameOnInvoice,
                                                displayLastNameOnInvoice, displayTvaOnInvoice,
                                                zipCode, city'));
        }
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, packId, quantity, totalPrice',
                                                'relations' => array(
                                                    'voyantQuestion' => array(
                                                        'fields' => 'questionId, title')
                                                )));

        $order = Model::factoryInstance('order')->find($c, 'orderId, purchaseDate, invoiceId, amount,
                                                            orders.userId, orders.voyantId');
        $invoiceData = serialize($order->toArray());
        Model::factoryInstance('order')->updateByPk(array('invoiceData' => $invoiceData), $this->orderId);
    }

    public function getInvoice()
    {
        return unserialize($this->invoiceData);
    }

    function userPackageDataUpdate($orderId){
        if(!empty($orderId)){
            $c = new Criteria();
            $c->add('orderId', $orderId);
            $c->add('packId', null, '!=');
            $orderItems = Model::factoryInstance('orderItem')->findAll($c);
            $order = Model::factoryInstance('order')->findByPk($orderId);

            foreach ($orderItems as $orderItem) {
                for ($i = 1; $i <= $orderItem['quantity']; $i++) {
                    if(!empty($orderItem['packId'])){$packID = $orderItem['packId'];}else{$packID =0;}
                        $userPackage = new UserPackageRecord();
                        $userPackage->fromArray(array('userId'=> $order->userId,
                        'packageId' => $packID,
                        'orderId' => $order->orderId));
                        $userPackage->save();
                }
            }
            return true;
        }
    }

    public function setPaid($options = array())
    {
        $c = new Criteria();
        $c->add('voyantId', $this->voyantId);
        $invoiceId = intval(Model::factoryInstance('order')->get('MAX(invoiceId)', $c)) + 1;
        $this->status = 'paid';
        $this->invoiceId = $invoiceId;
        if (isset($options['ipnData'])) {
            $this->payPalId = $options['ipnData']['txn_id'];
        } elseif(isset($options['stripeData'])) {
            $this->stripeData = $options['stripeData'];
        }
        $this->save();

        foreach ($this->getOrderItems() as $orderItem) {
            for ($i = 1; $i <= $orderItem['quantity']; $i++) {
                $userQuestion = new UserQuestionRecord();
                $userQuestion->fromArray(array(
                                        'userId' => $this->userId,
                                        'voyantQuestionId' => $orderItem['itemId'],
                                        'orderId' => $this->orderId
                                    ));
                $userQuestion->save();
            }
        }

        //save data into userPackage Model...
        $this->userPackageDataUpdate($this->orderId);
        $this->saveInvoiceData();

        $currentOrder = Model::factoryInstance('order')->findByPk($this->orderId);
        if($currentOrder->voyantId > 0 && ($currentOrder->type==="Voyant" || $currentOrder->type==="Platform")){
            if (Config::get('sendEmailToUserAfterUserBoughtQuestion'))
            {
                Mailer::getInstance()->sendEmailToUserAfterUserBoughtQuestion($this->orderId);
            }

            if (Config::get('sendEmailToVoyantAfterUserBoughtQuestion') && $this->paymentMethod != 'check')
            {
                Mailer::getInstance()->sendEmailToVoyantAfterUserBoughtQuestion($this->orderId);
            }
        }
         // for packages
        if(($currentOrder->type==="Platform") && ($currentOrder->voyantId == 0)){
            // print_r($this->orderId);die();
             if (Config::get('sendEmailToUserAfterUserBoughtPackage'))

             {
                Mailer::getInstance()->sendEmailToUserAfterUserBoughtPackage($this->orderId,0);
             }
         }
    }

    public function setStatus($status, $options = array())
    {
        if (!in_array($status, array('pending', 'denied', 'paid'))) {
            throw new Exception("Can't set order status: $status");
        }

        if ($status == 'paid') {

            $this->setPaid($options);
        } else {
            $this->status = $status;
            $this->save();
        }
    }
    public function setOrderStatus($status, $options = array())
    {
        if (!in_array($status, array('unpaid', 'paid', 'refund'))) {
            throw new Exception("Can't set order status: $status");
        }
        $this->status = $status;
        $this->save();
    }

}


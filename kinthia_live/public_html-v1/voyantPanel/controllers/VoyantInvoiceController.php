<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_VoyantInvoiceController extends AppController
{
    /**
    * set access privileges
    */
    
    public function indexAction()
    {        
       $voyant = $this->voyant->findByPk($this->userId);
     
       $orders = [];
       
       if($voyant->paymentExpertPlatform==1){

            $c = new Criteria();
            $c->add('status', 'paid');
            $c->add('type', 'Voyant');
            // $c->add('type', 'Platform');

            $c->add("voyantId", $this->userId);
            
            $c->addOrder("purchaseDate DESC");
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
                        if(!empty($voyant['displayTvaOnInvoice']) && !empty($voyant['tva'])){
                            $persn = $tot * $voyant['tva']/100;
                            $tot = $tot+ $persn;
                        }
                        
                        $totalQuestPrice[$order['orderId']] = $tot;
                    }
                    $orders[$key]['totalQuestPrice'] = $tot;
                }
            }
        }
        $this->set('orders', $orders);

        /**
        * set statistic
        */
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function detailsAction($orderId)
    {
        $order = Model::factoryInstance('order')->findByPk($orderId);
        $this->set('order', $order);

        $userDetail =  Model::factoryInstance('user')->findByPk($order->userId);
        $this->set('userDetail', $userDetail);
        
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
       
        /**
        * set statistic
        */
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));
    }

    public function printAction($orderId)
    {
        $order = Model::factoryInstance('order')->findByPk($orderId);
        $this->set('order', $order);

        $userDetail =  Model::factoryInstance('user')->findByPk($order->userId);
        $this->set('userDetail', $userDetail);

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
        $this->set('voyant', $this->voyant->findByPk($this->userId));
    }

    public function getTotal($jointArr)
    {
       if(isset($jointArr) && !empty($jointArr)){
        $total = 0;
            foreach($jointArr as $key => $orderArs){
                foreach($orderArs as $qty => $orderArr){
                    if(!empty($orderArr['price'])){
                        $total+= $orderArr['price']*$qty;
                    }

                    if(!empty($orderArr['packagePrice'])){
                        $total+= $orderArr['packagePrice']*$qty;
                    }
                }
            }
            return $total;
       }       
    }

    public function listAction()
    {
       
        $this->set('voyant', $this->voyant->findByPk($this->userId));
        /**
        * set statistic
        */
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId)
        ));      
    }
}

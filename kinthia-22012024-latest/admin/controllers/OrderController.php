<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_OrderController extends AppController
{
    /**
     * set access privileges
     */

    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }

    }

    public function pendingAction($page = 1)
    {
        $itemsPerPage = 10;
        $c = new Criteria();
        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $this->set('orders', $this->voyant->getVoyantPendingCheckOrders($c));
        $totalCount = $this->order->getFoundRowsCount();
        $this->set('pendingCheckOrdersCount', $totalCount);
        $totalPages = ceil($totalCount / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/admin/order/pending/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));

        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));

    }

    function updateStatusAction()
    {
        if (!empty($this->request->orderIds)
            && in_array($this->request->status, array('paid', 'delete'))
        ) {
            $c = new Criteria();
            $c->add('orderId', $this->request->orderIds, 'IN');
            $c->add('status', 'pending');

            if ($this->request->status == 'delete') {
                $this->order->del($c);
            } else {
                $orders = $this->order->findAll($c, '*', true);

                foreach ($orders as $order) {
                    $order->setPaid();
                }
            }
        }

        $this->redirect($this->moduleLink('pending'));
    }
    public function listAction($page = 1)
    {
        $itemsPerPage = 50;
        $c = new Criteria();
        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $c->addOrder("purchaseDate DESC");
        $this->set('ordersArr',$this->voyant->getVoyantOrdersList($c));
        $totalCount = $this->order->getFoundRowsCount();
        $this->set('pendingCheckOrdersCount', $totalCount);
        $totalPages = ceil($totalCount / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/admin/order/list/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function detailsAction($id = 1)
    {
        $c = new Criteria();
        $c->add('orderId', $id);
        $c->addWithRelation('user', array('fields' => 'name, firstName, lastName, email,ordersCount,createdAt'));
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, packId, quantity, totalPrice',
            'relations' => array(
                'voyantQuestion' => array(
                    'fields' => 'questionId, title')
            )));
        $c->setLimit(1);
        $orderDetails = $this->voyant->getVoyantOrderDetails($c);
        // echo "<pre>"; print_r($orderDetails); exit;
        $this->set('orderDetails',$this->voyant->getVoyantOrderDetails($c));
        // packages details
        $p = new Criteria();
        $p->add('orderId', $id);
        $orderItemsCriteria = new Criteria();
        $orderItemsCriteria->addLeftJoin('packages','orderItems.packId','packages.packageId');
        $orderItemsCriteria->add('packId',NULL,'!=');
        $p->addWithRelation('orderItems', array('fields' => 'orderId,packid,packages.packageName,packages.packagePrice','criteria' => $orderItemsCriteria)
            );
        $orderPackages = $this->voyant->getVoyantOrderDetails($p);
        $this->set('orderPackages',$this->voyant->getVoyantOrderDetails($p));
        $ordersCount = count($orderDetails['orderItems']) + count($orderPackages['orderItems']);
        $this->set('orderItemsCount',$ordersCount);
        // order's count and earning aginst current orderId
        $totalOrdersEarning = 0;
        $totalOrdersCount = 0;
        if(isset($orderDetails['userId'])){
            $ordersRecordCount = new Criteria();
            $ordersRecordCount->add('orders.userId', $orderDetails['userId']);
            $ordersRecordCountRecord = $this->voyant->getVoyantOrdersList($ordersRecordCount);
            foreach ($ordersRecordCountRecord as $order) {
                $totalOrdersEarning += $order['amount'];
                $totalOrdersCount++;
            }
        }else{
            $totalOrdersEarning = 0;
            $totalOrdersCount = 0;
        }
        $this->set('totalOrdersEarning', $totalOrdersEarning);
        $this->set('totalOrdersCount', $totalOrdersCount);
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));

    }

    public function invoiceDetailsAction()
    {

       $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function invoicePrintAction()
    {

       $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    /**
     *  cart listing function
    */
    public function cartAction($page = 1)
    {
        $itemsPerPage = 50; //per page record
        $c = new Criteria();
        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $c->addOrder("creationDate DESC");
        $c->addWithRelation('user', array('fields' => 'name'));
        $c->addWithRelation('cartitem', array('fields' => 'cartItemId, cartId, totalPrice'));

        $this->cartList = $this->voyant->getVoyantCartDetails($c);

        $mergedCartList = array();

        foreach ($this->cartList as $cart) {
            $cartId = $cart['cartitem']['cartId'];
            if (array_key_exists($cartId, $mergedCartList)) {
                $mergedCartList[$cartId]['cartitem'][] = $cart['cartitem'];
            } else {
                $cart['cartitem'] = array($cart['cartitem']); // Ensure 'cartitem' is an array
                $mergedCartList[$cartId] = $cart;
            }
        }
        foreach ($mergedCartList as &$mergedCart) {
            $totalPriceSum = 0;

            foreach ($mergedCart['cartitem'] as $cartitem) {
                $totalPriceSum += floatval($cartitem['totalPrice']);
            }
            $mergedCart['totalPriceSum'] = number_format($totalPriceSum, 2); // Format the sum as needed
        }
        $this->cartList = array_values($mergedCartList);

        $this->set('cartRecordList', $this->cartList);

        $totalCount = $this->cart->getFoundRowsCount();

        // echo '<pre>'; print_r($this->cartList); exit;
        $totalPages = ceil($totalCount / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/admin/order/cart/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));

        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function cartDetailsAction($id = 1)
    {
        $c = new Criteria();
        $c->add('carts.cartId', $id);
        $c->addWithRelation('user', array('fields' => 'name, firstName, lastName, email,ordersCount,createdAt'));
        $c->addWithRelation('cartitem', array('fields' => 'itemId, cartItemId, name, quantity, totalPrice'));

        $cartDetails = $this->voyant->getVoyantcartDetails($c);
        $this->set('cartDetails',$this->voyant->getVoyantcartDetails($c));

        $cartCount = count($cartDetails);
        $this->set('cartItemsCount',$cartCount);
        // order's count and earning aginst current orderId
        $totalOrdersEarning = 0.0;
        $totalOrdersCount = 0;

        if (isset($cartDetails[0]['userId'])) {
            $ordersRecordCount = new Criteria();
            $ordersRecordCount->add('orders.userId', $cartDetails[0]['userId']);
            $ordersRecordCountRecord = $this->voyant->getVoyantOrdersList($ordersRecordCount);

            foreach ($ordersRecordCountRecord as $cart) {
                $totalOrdersEarning += (float)$cart['amount'];
                $totalOrdersCount++;
            }
        } else {
            $totalOrdersEarning = 0.0;
            $totalOrdersCount = 0;
        }

        // current cart total price
        $cartToalEarning = 0.0;
        if(isset($cartDetails[0]['userId'])){
            foreach ($cartDetails as $price) {
                $cartToalEarning += (float)$price['totalPrice'];
            }
        } else {
            $cartToalEarning = 0.0;
        }
        // list of cartitems for the list of cart detail table
        $itemsList = array();
        if (isset($cartDetails[0]['userId'])) {
            foreach ($cartDetails as $list) {
                $itemsList[] = $list['cartitem'];
            }
        }

        $this->set('itemsList', $itemsList);

        $this->set('cartToalEarning', $cartToalEarning);
        $this->set('totalOrdersEarning', $totalOrdersEarning);
        $this->set('totalOrdersCount', $totalOrdersCount);

        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));

    }

    public function consultationAction($page = 1)
    {
        $itemsPerPage = 50; // per page record
        $c = new Criteria();
        // Check if start and end dates are provided
        if (isset($_GET['start_date']) && isset($_GET['end_date'])) {
            $startDate = $_GET['start_date'];
            $endDate = $_GET['end_date'];
            // Add conditions for the date range
            $c->add('date', $startDate, '>=');
            // and date is less than or equal to end date
            $c->add('date', $endDate, '<=');
        }

        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $c->addOrder("userconsultationId DESC");
        $c->addWithRelation('user', array('fields' => 'name, firstName, lastName, email,ordersCount,createdAt'));
        $c->addWithRelation('voyant', array('fields' => 'name, firstName, lastName, email'));
        // show the data from userconsultation table after filtering
        $consultationList = $this->voyant->getVoyantConsultations($c);

        // get the data from userconsultation table
        $this->set('consultationArr', $consultationList);


        $totalCount = $this->userConsultation->getFoundRowsCount();
        $totalPages = ceil($totalCount / $itemsPerPage);

        $this->set('pageNavigation', array('baseLink'    => '/admin/order/consultation/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }


    public function consultationQAction($page = 1)
    {
        $itemsPerPage = 50; //per page record
        $c = new Criteria();
        $c->setPagination($page, $itemsPerPage);
        $c->setCalcFoundRows(true);
        $c->addOrder("orderId DESC");
        $c->add("whoIsPaid", '', "!=");
        $c->addWithRelation('voyantQuestion', array('fields' => 'title'));
        $c->addWithRelation('voyant', array('fields' => 'name'));
        $c->addWithRelation('user', array('fields' => 'name,ordersCount,createdAt'));
        $consultationQList = $this->voyant->getVoyantConsultationQ($c);

        // get the data from userconsultation table
        $this->set('consultationQArr', $consultationQList);

        $totalCount = $this->userQuestion->getFoundRowsCount();
        $totalPages = ceil($totalCount / $itemsPerPage);
        $this->set('pageNavigation', array('baseLink'    => '/admin/order/consultationQ/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));

        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));

    }

    public function updateOrderStatusAction()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $newStatus = $_POST['updateOrderStatusVal'];
            $orderId = $_POST['orderIdVal'];
            if (in_array($newStatus, ['paid', 'denied', 'unpaid', 'pending', 'refund'])) {
                $c = new Criteria();
                $c->add('orderId', $orderId);
                $order = $this->order->find($c, '*', true);
                $order->setOrderStatus($newStatus);
            }
        }
        $referer = $_SERVER['HTTP_REFERER'];
        header("Location: $referer");
        exit();
    }

}


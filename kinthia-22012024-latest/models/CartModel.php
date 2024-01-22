<?php
////////////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                            //
//                    by Hocine Guillaume (c) 2007 - 2008                          //
//                           http://www.arfooo.com/                               //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/    //
//////////////////////////////////////////////////////////////////////////////////

class CartModel extends Model
{
    protected $primaryKey = "cartId";
    protected $relations = array('order' => array('type'       => 'oneToOne',
        'foreignKey' => 'cartId'),
    'user'   => array('type'       => 'oneToOne',
                                                   'foreignKey' => 'userId'),
        'cartitem' => array('type'       => 'oneToOne',
        'foreignKey' => 'cartId'),
        'userQuestion' => array('type'       => 'oneToOne',
        'foreignKey' => 'orderId')
    );
    function getCart($userId = 0)
    {
        $cartId = Request::getInstance()->getCookie("cartId");
		if(!$cartId) {
			$cart = $this->generateCartCookie();
		} else {
			$cart = $this->findByPk($cartId);

			if (!empty($cartId) && !$cart) {
				// Delete old cookie if exist
				setCookie("cartId", $cartId, time() - 3600, "/");
			}

			if(!$cart) {
				$cart = $this->generateCartCookie();
			}

            //Auto update userId if still empty
            if(empty($cart['userId']) && $userId != 0 && !empty($cart['itemsCount'])) {
                $data = array("userId" => $userId);
                Model::factoryInstance("cart")->updateByPk($data, $cartId);
            }
		}

        return $cart;
    }

    public function updateUserId($userId = 0)
    {
        if($userId == 0) return;

        $data = array("userId" => $userId);
        Model::factoryInstance("cart")->updateByPk($data, $this->cartId);
    }

    public function updateStatus($status = "pending")
    {
        $data = array("status" => $status);
        Model::factoryInstance("cart")->updateByPk($data, $this->cartId);
    }

    private function generateCartCookie(){
        $cart = false;

        try{
            $cart = $this->handleDoubleCookie();
        } catch(Exception $e) {}

        if(!$cart){
            $cart = new CartRecord();
            $cart->cartId = md5(rand());
            $cart->itemsCount = 0;
            $cart->status = "init";
            $cart->save();

            //Response::getInstance()->setCookie("cartId", $cart->cartId, time() + 60*60*24*7);//7 days
            setCookie("cartId", $cart->cartId, time() + 60*60*24*7, "/"); // 7 day
        }

        return $cart;
    }

    private function handleDoubleCookie(){
        $cart = false;

        foreach (headers_list() as $header) {
            if (strpos($header, 'Set-Cookie: cartId=') !== false) {
                if (preg_match('/Set-Cookie: cartId=(.*?);/', $header, $match) == 1) {
                    if (strpos($header, 'Max-Age=0') === false) {
                        $cart = $this->findByPk($match[1]);
                        break;
                    }
                }
            }
        }

        return $cart;
    }
}

class CartRecord extends ModelRecord
{
    /**
     * Modified this method for insert two more fields in the cartItems table $packageId and $type...
     */
    public function addItem($itemId, $name, $quantity, $totalPrice, $voyantId, $packageId, $type, $userId = 0)
    {
        $cartItem = new CartItemRecord(array('cartId' => $this->cartId, 'name'=> $name,'itemId'=> $itemId, 'quantity' => $quantity, 'totalPrice' => $totalPrice,'voyantId'   => $voyantId, 'packageId' => $packageId, 'type' => $type));

        $cartItem->save();
        $this->updateItemsCount($userId);
    }

    public function deleteItem($cartItemId)
    {
        $c = new Criteria();
        $c->add("cartId", $this->cartId);
        $c->add("cartItemId", $cartItemId);
        Model::factoryInstance("cartItem")->del($c);

        $this->updateItemsCount();
    }

    public function destroy()
    {
        $c = new Criteria();
        $c->add("cartId", $this->cartId);
        Model::factoryInstance("cartItem")->del($c);
        Model::factoryInstance("cart")->del($c);
    }

    private function updateItemsCount($userId = 0)
    {
        $c = new Criteria();
        $c->add("cartId", $this->cartId);
        $this->itemsCount = Model::factoryInstance("cartItem")->getCount($c);
        if($this->itemsCount==NULL)
        $this->itemsCount=0;
        $data = array("itemsCount" => $this->itemsCount, "status" => "pending");
        Model::factoryInstance("cart")->updateByPk($data, $this->cartId);

        if($userId != 0){
            $data = array("userId" => $userId);
            Model::factoryInstance("cart")->updateByPk($data, $this->cartId);
        }
    }

    /**
     * @param $voyantId
     * @param $packageId
     */
    public function loadItems($voyantId = null, $packageId = null)
    {
        $c = new Criteria();
        $c->add("cartId", $this->cartId);
        if ($voyantId) {
            $c->add("voyantId", $voyantId);
        }
        if ($packageId) {
            $c->add("packageId", $packageId);
        }

        $this->cartItems = Model::factoryInstance("cartItem")->findAll($c);
        $totalPrice = 0;
        foreach ($this->cartItems as $cartItem) {
            $totalPrice += $cartItem['totalPrice'];
        }

        $this->totalPrice = $totalPrice;
        $this->updateItemsCount();
    }

     /**
     * Modified this method for adding add time packs in the basket...
     */
    public function loadBaskets()
    {
        $baskets = array();
        $itemIds_Q = array();
        $itemIds_P = array();
        $types = array();
        $voyantIds = array();
        $packageId = 0;
        $basket = array(
            'totalPrice'    => 0,
            'voyant'        => array(),
            'package'       => array(),
            'type'          => '',
            'isPackTime'    =>  false,
        );

        //echo "<pre>";print_r($this->cartItems); die;
        $platformArr = []; $expertArr = [];
        foreach ($this->cartItems as $cartItem) {
            if($cartItem['type'] == 'TimePack') {
                $cartItem['paymentExpertPlatform'] = 0;
                $platformArr[] = $cartItem;
            }

            if($cartItem['type'] == 'VoyantQuestion') {
                $voy = Model::factoryInstance("voyant")->findByPk($cartItem['voyantId']);
                $cartItem['voyantName'] = $voy['name'];
                $cartItem['paymentExpertPlatform'] = $voy['paymentExpertPlatform'];
                if ($cartItem['paymentExpertPlatform'] == 1) {
                    $expertArr[] = $cartItem;
                    $voyantIds[] = $cartItem[ 'voyantId' ];
                } else {
                    $platformArr[] = $cartItem;
                }
            }
        }

        $voyantIds = array_unique($voyantIds);
        $packTimeArr = [];
        foreach ($platformArr as $platformItem) {
            $packageId = $platformItem['packageId'];
            $voyantId = $platformItem['voyantId'];
            $package = $packageId == 0 ?
                array('packageId' => 0) :
                Model::factoryInstance("package")->findByPk($packageId);

            $voyant = $voyantId == 0 ?
                array('voyantId' => 0) :
                Model::factoryInstance("voyant")->findByPk($voyantId);

            $packTimeArr[] = $platformItem[ 'type' ];
            $basket[ 'totalPrice' ] += $platformItem[ 'totalPrice' ];
            $basket[ 'voyant' ] = $voyant;
            $basket[ 'package' ] = $package;
            $basket[ 'items' ][] = $platformItem;
        }

        if (count($packTimeArr) > 0) {
            $basket[ 'isPackTime' ] = count(array_unique($packTimeArr)) == 1 && $packTimeArr[ 0 ] == "TimePack";
            $basket[ 'type' ] = 'Platform';
            $baskets[ 'Platform' ] = $basket;
        }

        // echo json_encode($voyantArr);
        // echo '<br></br>';
        $basket = array(
            'totalPrice'    => 0,
            'voyant'        => array(),
            'package'       => array(),
            'type'          => '',
            'isPackTime'    =>  false,
        );

        // For the experts option
        foreach ($voyantIds as $voyantId) {
            $voyant = Model::factoryInstance("voyant")->findByPk($voyantId);
            $basket[ 'voyant' ] = $voyant;
            $basket[ 'totalPrice' ] = 0;
            $basket[ 'items' ] = [];

            foreach ($expertArr as $expertItem) {
                if ($voyantId == $expertItem[ 'voyantId' ]) {
                    $basket[ 'totalPrice' ] += $expertItem[ 'totalPrice' ];
                    $basket[ 'type' ] = $expertItem[ 'type' ];
                    $basket[ 'items' ][] = $expertItem;
                }
            }
            $baskets[ $voyantId ] = $basket;
        }

    //     foreach ($this->cartItems as $cartItem) {
    //         if(!empty($cartItem['type']) && $cartItem['type'] == 'VoyantQuestion'){
    //            $itemIds_Q[] = $cartItem['itemId'];
    //            $voyantIds[] = $cartItem['voyantId'];
    //         }
    //         if(!empty($cartItem['type']) && $cartItem['type'] == 'TimePack'){
    //             $itemIds_P[] = $cartItem['itemId'];
    //         }
    //         $types[] = $cartItem['type'];
    //         if($cartItem['packageId'] > 0){
    //             $packageId = $cartItem['packageId'];
    //         }
    //     }
    //     $types = array_values(array_unique($types));
    //     $voyantIds = array_values(array_unique($voyantIds));
    //    //echo "<pre>";print_r($voyantIds);die;
    //     $c = new Criteria();
    //     if(isset($types) && in_array('VoyantQuestion', $types)) {
    //         $c->add('questionId', $itemIds_Q, 'IN');
    //         $voyantQuestions = Model::factoryInstance("voyantQuestion")->getArray($c, 'imageSrc');
    //     }

    //     $d = new Criteria();
    //     if(isset($types) && in_array('TimePack', $types)) {
    //         $d->add('packageId', $itemIds_P, 'IN');
    //         $timePacks = Model::factoryInstance("package")->getArray($d, 'packageTime');
    //     }

    //     // echo json_encode($this->cartItems);
    //     foreach ($this->cartItems as $cartItem) {
    //         // When Only Voyant Questions with no Time Packs...
    //         // if(in_array('VoyantQuestion', $types) && !in_array('TimePack', $types) && sizeof($voyantIds)==1) {
    //         //     $cartItem['imageSrc'] = $voyantQuestions[$cartItem['itemId']];
    //         //     $basket =& $baskets[$cartItem['voyantId']];

    //         //     if (!isset($basket)) {
    //         //           $voyant = Model::factoryInstance("voyant")->findByPk($cartItem['voyantId']);
    //         //           $basket = array('totalPrice' => 0,
    //         //                           'voyant'     => $voyant,'type' =>'VoyantQuestion');
    //         //     }
    //         // }

    //         //When Only Time Packs and not voyant Questions...
    //         if(in_array('TimePack', $types) && !in_array('VoyantQuestion', $types)) {
    //             $cartItem['packageTime'] = $timePacks[$cartItem['itemId']];
    //             $basket =& $baskets['Platform'];

    //             if (!isset($basket)) {
    //                 $package = Model::factoryInstance("package")->findByPk($cartItem['packageId']);
    //                 $basket = array('totalPrice' => 0,
    //                                 'package'     => $package ,'type' =>'TimePack');
    //             }
    //         }

    //         //When Voyants Questions and with time pack...

    //         // if(in_array('VoyantQuestion', $types) && in_array('TimePack', $types) && sizeof($voyantIds) >= 1) {
    //         if(sizeof($voyantIds) >= 1) {
    //             foreach($voyantIds as $voyantId) {
    //                 $voyant = Model::factoryInstance("voyant")->findByPk($voyantId);
    //                 // echo $voyant['name'];

    //                 if($cartItem['paymentExpertPlatform'] == 1) {
    //                     $basket =& $baskets['VoyantQuestion'];
    //                     if (!isset($basket)) {
    //                         $voyant = Model::factoryInstance("voyant")->findByPk($cartItem['voyantId']);
    //                         $package = $packageId == 0 ? array('packageId' => 0) : Model::factoryInstance("package")->findByPk($packageId);
    //                         $basket = array('totalPrice' => 0, 'voyant' => $voyant,'package' => $package, 'type' => $cartItem['type']);
    //                     }
    //                 } else {
    //                     // echo "platform: " . $voyant['name'] . " ";
    //                     $inOneOrder = 1;
    //                     $basket =& $baskets['Platform'];
    //                     if (!isset($basket)) {
    //                         // echo json_encode($voyant['voyantId']);
    //                         $voyant2 = Model::factoryInstance("voyant")->findByPk($voyant['voyantId']);
    //                         $package = $packageId == 0 ? array('packageId' => 0) : Model::factoryInstance("package")->findByPk($packageId);
    //                         $basket = array('totalPrice' => 0, 'voyant' => $voyant2, 'package' => $package, 'type' => 'Platform');
    //                     }
    //                 }
    //             }
    //         }

    //         //When different Voyants Questions with  No time packs added...
    //         // if(in_array('VoyantQuestion', $types) && !in_array('TimePack', $types) && sizeof($voyantIds)>1) {
    //         //     $cartItem['imageSrc'] = $voyantQuestions[$cartItem['itemId']];
    //         //     $basket =& $baskets[$cartItem['voyantId']];
    //         //     if (!isset($basket)) {
    //         //         $voyant = Model::factoryInstance("voyant")->findByPk($cartItem['voyantId']);
    //         //         $basket = array('totalPrice' => 0,
    //         //                         'voyant'     => $voyant,'type' =>'VoyantQuestion');
    //         //     }
    //         // }

    //         $basket['items'][] = $cartItem;
    //         $basket['totalPrice'] += $cartItem['totalPrice'];
    //         // $basket['type'] = $cartItem['type'];
    //     }
        $this->baskets = $baskets;
        $this->voyantIds = $voyantIds;
    }
}
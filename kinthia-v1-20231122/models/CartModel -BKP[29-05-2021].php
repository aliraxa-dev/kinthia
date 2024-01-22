<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class CartModel extends Model
{
    protected $primaryKey = "cartId";   
    function getCart()
    {
        $cartId = Request::getInstance()->getCookie("cartId");
        $cart = $this->findByPk($cartId);
        if (empty($cartId) || !$cart->cartId) {
            $cart = new CartRecord();
            $cart->cartId = md5(rand());
            $cart->itemsCount = 0;
            $cart->save();
            
           //Response::getInstance()->setCookie("cartId", $cart->cartId, time() + 60*60*24*7);//7 days
           setCookie("cartId", $cart->cartId, time() + 60*60*24*7); // 7 day
        }
        return $cart;
    }
}

class CartRecord extends ModelRecord
{
    /**
     * Modified this method for insert two more fields in the cartItems table $packageId and $type...
     */
    public function addItem($itemId, $name, $quantity, $totalPrice, $voyantId, $packageId, $type)
    {
            $cartItem = new CartItemRecord(array('cartId' => $this->cartId, 'name'=> $name,'itemId'=> $itemId, 'quantity'   => $quantity, 'totalPrice' => $totalPrice,'voyantId'   => $voyantId, 'packageId' => $packageId, 'type' => $type));
        
        $cartItem->save();
        $this->updateItemsCount();
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
    
    private function updateItemsCount()
    {
        $c = new Criteria();
        $c->add("cartId", $this->cartId);
        $this->itemsCount = Model::factoryInstance("cartItem")->getCount($c);
        $data = array("itemsCount" => $this->itemsCount);
        Model::factoryInstance("cart")->updateByPk($data, $this->cartId);
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
        $itemIds = array();
        foreach ($this->cartItems as $cartItem) { 
            $itemIds[] = $cartItem['itemId'];
            $type = $cartItem['type'];
        }  

        $c = new Criteria();
        if(!empty($type) && $type=='VoyantQuestion'){
            $c->add('questionId', $itemIds, 'IN');
            $voyantQuestions = Model::factoryInstance("voyantQuestion")->getArray($c, 'imageSrc');
        }else{
            $c->add('packageId', $itemIds, 'IN');
            $timePacks = Model::factoryInstance("package")->getArray($c, 'packageTime');
        }    
        
        foreach ($this->cartItems as $cartItem) {
           if($cartItem['type']=='VoyantQuestion'){
                $cartItem['imageSrc'] = $voyantQuestions[$cartItem['itemId']];
                $basket =& $baskets[$cartItem['voyantId']];
                
                if (!isset($basket)) {
                      $voyant = Model::factoryInstance("voyant")->findByPk($cartItem['voyantId']);
                      $basket = array('totalPrice' => 0,
                                      'voyant'     => $voyant);
                }
            }else{
                $cartItem['packageTime'] = $timePacks[$cartItem['itemId']];
                $basket =& $baskets[$cartItem['packageId']];            
                if (!isset($basket)) {
                      $package = Model::factoryInstance("package")->findByPk($cartItem['packageId']);
                      $basket = array('totalPrice' => 0,
                                      'package'     => $package);
                }
            }    
           
            $basket['items'][] = $cartItem;
            $basket['totalPrice'] += $cartItem['totalPrice'];
            $basket['type'] = $cartItem['type'];
        }
        $this->baskets = $baskets;
    }
}

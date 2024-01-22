<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantModel extends Model
{
    protected $primaryKey = "voyantId";

    protected $relations = array('voyantQuestions' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),

                                 'userQuestions'   => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),

                                 'voyantComments'  => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantSkills' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantLanguage' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId'),
                                 'voyantConsultation' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'voyantId')

                             );

    public function getFields()
    {
        return array('voyantId','name', 'imageSrc','displayNameOnInvoice', 'firstName', 'displayFirstNameOnInvoice',
                     'lastName', 'displayLastNameOnInvoice', 'address', 'zipCode', 'city',
                     'companyTaxNumber', 'email', 'voyantDescription', 'voyantQuote', 'hourlyDescription',
                     'contactDescription', 'supportDescription', 'payPalEnableDisable', 'payPalEmail', 'priority',
                     'stripePublishableKey', 'stripeSecretKey', 'stripeEnable', 'stripeStatementDescriptor', 'stripeCaptureCharge', 'stripePaymentRequestButtons', 'stripeSavedCards',
                     'title', 'metaDescription', 'headerDescription', 'navigationName',
                     'shortDescription', 'tva', 'displayTvaOnInvoice', 'available','gender','paymentExpertPlatform','bankIban','country','companyName','companyFormat','phoneNumber','mobileNumber','bankBic','paidBackQuestion','paidBackPhone','paidBackWebcam','urlName','displayPhone', 'displayChat','displayWebcam','displayEmail');
    }

    public function validate()
    {
        return '';
    }

    public function getVoyant($voyantIdArr){

        $d = new Criteria();
       if(isset($voyantIdArr) && !empty($voyantIdArr)){
           $d->add('voyantId', $voyantIdArr, 'IN');
           $voyants = Model::factoryInstance("Voyant")->findAll($d,  'voyantId, name', true);
       }else{
        $voyants = Model::factoryInstance("Voyant")->findAll($d);
       }
       return $voyants;

   }

    public function getVoyantUsers($voyantId)
    {
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->addWithRelation('user', array('fields' => 'email'));
        $c->addGroup("userquestions.userId");
        $c->setCalcFoundRows(true);

        return $this->userQuestion->findAll($c, 'users.userId, name, email, count(*) as boughtQuestionsCount');
    }
     public function getVoyantTotalUsers($voyantId)
    {
        $c = new Criteria();
        $c->add('voyantId', $voyantId);
        $c->addWithRelation('user', array('fields' => 'email'));
        $c->addGroup("userconsultations.userId");
        $c->setCalcFoundRows(true);
        $consUsers = $this->userConsultation->findAll($c,'users.userId, name, email');
        $questionUsers = $this->getVoyantUsers($voyantId);
        $totalUsers = array_merge($consUsers,$questionUsers);
        $totalUsers = array_values(array_column($totalUsers, null, 'userId'));
        foreach ($totalUsers as $user) {
            if(!isset($user['boughtQuestionsCount'])){
                $user['boughtQuestionsCount'] = 0;
            }
            $totaluser2[] = $user;
        }
        return $totaluser2;
        //return $this->userConsultation->findAll($c,'users.userId, name, email');
    }

    public function getPendingCheckOrders(Criteria $c)
    {
        //$c->add('paymentMethod', 'check');
        $c->add('status', 'pending');
        $c->addWithRelation('user', array('fields' => 'userId, name, email'));
        $c->addWithRelation('voyant', array('fields' => 'name, email'));
        // $c->addWithRelation('orderItems', array(
        //                         'fields' => 'orderId, itemId, packId',
        //                         'relations' => array(
        //                             'voyantQuestion' => array(
        //                                 'fields' => 'title'))));
        $c->addWithRelation('orderItems', array(
                                'fields' => 'orderId, itemId'));

        return $this->order->findAll($c);
    }

    public function getVoyantPendingCheckOrders(Criteria $c)
    {
        //$c->add('paymentMethod', 'check');
        $c->add('status', 'pending');
        $c->addWithRelation('user', array('fields' => 'userId, name, email'));
        $c->addWithRelation('voyant', array('fields' => 'name, email'));
        $c->addWithRelation('orderItems', array(
                                'fields' => 'orderId, itemId'));
        $c->addWithRelation('orderItems', array(
                                'fields' => 'orderId, itemId, packId',
                                'relations' => array(
                                    'voyantQuestion' => array(
                                        'fields' => 'title'))));
        return $this->order->findAll($c);
    }
    public function getVoyantOrdersList(Criteria $c)
    {
        //$c->add('paymentMethod', 'check');
        $c->addWithRelation('user', array('fields' => 'userId, name'));

        return $this->order->findAll($c);
    }
    public function getVoyantOrderDetails(Criteria $c)
    {
        return $this->order->find($c);
    }
    public function getVoyantCartDetails(Criteria $c)
    {
        return $this->cart->findAll($c);
    }
    public function getCartItemDetails(Criteria $c)
    {
        return $this->cartItem->findAll($c);
    }
    public function getVoyantConsultations(Criteria $c)
    {
        return $this->userConsultation->findAll($c);
    }
    public function getVoyantConsultationQ(Criteria $c)
    {
        return $this->userQuestion->findAll($c);
    }
    function update($data, Criteria $c)
    {
        parent::update($data, $c);
        if (!empty($data['urlName'])) {
            $condition = $c->getCondition('voyantId');
            $c2 = new Criteria();
            $c2->addCondition($condition);
            $voyantQuestions = $this->voyantQuestion->findAll($c2, 'questionId, urlName, title', true);
            foreach ($voyantQuestions as $voyantQuestion) {
                $voyantQuestion->updateUrlName($data);
                $voyantQuestion->save();
            }
        }
    }
}

class VoyantRecord extends ModelRecord
{
    function updatePhotos()
    {
        $c = new Criteria();
        $c->add("itemId", $this->voyantId);
        $c->addOrder("photoId");
        $c->setLimit(1);
        $imageSrc = Model::factoryInstance("photo")->get("src", $c);

        $data = array("imageSrc" => $imageSrc ? $imageSrc : "");
        //echo "<pre>";print_r($data);die;
        Model::factoryInstance("voyant")->updateByPk($data, $this->voyantId);
    }

    function save()
    {
        $this->urlName = NameTool::strToAscii($this->name);
        parent::save();
    }

    function del()
    {
        $c = new Criteria();
        $c->add('itemId', $this->voyantId);
        $photos = Model::factoryInstance('photo')->findAll($c, '*', true);

        foreach ($photos as $photo) {
            $photo->del(false);
        }

        $c = new Criteria();
        $c->add('voyantId', $this->voyantId);
        Model::factoryInstance('voyantQuestion')->del($c);
        Model::factoryInstance('voyantComment')->del($c);

        parent::del();
    }
}

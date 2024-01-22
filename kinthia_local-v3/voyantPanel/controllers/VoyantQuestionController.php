<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_VoyantQuestionController extends CrudController
{
    /**
    * set access privileges
    */
    public function init()
    {
        $this->acl->allow('voyant', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/voyantPanel/main/logIn'));
        }
        
        $this->crudConfig['modelName'] = 'voyantQuestion';
        $this->crudConfig['pageNavigation']['baseLink'] = '/voyantPanel/voyantQuestion/index/';
        
        //edit
        $c = new Criteria();
        $c->add('voyantId', $this->userId);
        $c->addWithRelation('voyantQuestionPrices', array('fields' => 'questionId, priceId, quantity, price'));
        
        $this->crudConfig['actions']['edit']['criteria'] = $c;
        
        //index
        $c = new Criteria();
        $c->add('voyantId', $this->userId);
        $c->addOrder('position');
        $this->crudConfig['actions']['index']['criteria'] = $c;

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
        
        $this->set("message",$this->session->get("message"));
    }
    
    public function createAction($voyantId = null)
    {

        $this->set('voyantOptionListSelectedId', $voyantId);
        parent::createAction();
    }
    
    protected function beforeSave($item)
    {
       $item['displayOnline'] = empty($item['displayOnline']) ? 0 :1;
        $item['adminValidation'] = empty($item['adminValidation']) ? 0 :1;

        //if we add new question
        if (empty($item['voyantId'])) {
            $item['voyantId'] = $this->userId;
        } else {
            //check we have access if save edit
            if ($item['voyantId'] != $this->userId) {
                $this->return404();
            }
        }
        
        $uploadedFile = new UploadedFile('ImageXXXX');
        $uploadedFile->addFilter('extension', array('jpg', 'jpeg', 'gif', 'png'));
        $uploadedFile->addFilter('maxSize', intval(Config::get('itemGalleryImageMaxWeight')) * 1024);
        
        if ($uploadedFile->wasUploaded()) {
            $uploadedFile->validate();
            $uploadedFile->setSavePath(CODE_ROOT_DIR.'uploads/photos/');
            $uploadedFile->setAutoCreateDirs(true);
            $uploadedFile->save();
            $item->imageSrc = $uploadedFile->getSavedFileName();
        }        
    }
    
    protected function afterSave($item)
    {

        foreach ($this->request->voyantQuestionPrices as $price) {
            if (!empty($price['priceId'])) {
                $voyantQuestionPrice = $this->voyantQuestionPrice->findByPk($price['priceId']);
                if (!$price['quantity']) {
                    $voyantQuestionPrice->del();
                }
            }
            
            if ($price['quantity']) {
                if (empty($price['priceId'])) {
                    $voyantQuestionPrice = new VoyantQuestionPriceRecord();
                }
                $voyantQuestionPrice->quantity = $price['quantity'];
                $voyantQuestionPrice->price = $price['price'];
                $voyantQuestionPrice->questionId = $item->questionId;
                $voyantQuestionPrice->save();
            }
        }
        
        $this->set('message', 'Voyant question was saved');
        $redirectUrl = $this->moduleLink();
        $this->set('redirectUrl', $redirectUrl);
        $this->redirect($redirectUrl);
    }
    
    public function savePositionsAction()
    {
        $this->viewClass = 'JsonView';
        
        foreach ($this->request->positions as $fieldId => $position) {
            $voyantQuestion = $this->voyantQuestion->findByPk($fieldId);
            if ($voyantQuestion->voyantId != $this->userId) {
                $this->return404();
            }
            $voyantQuestion->fromArray(array('position' => $position));
            $voyantQuestion->save();
        }
        
        $this->set('status', 'ok');
    }
    
    protected function beforeDelete($item)
    {
        if ($item->voyantId != $this->userId) {
            $this->return404();
        }
    }
    
    protected function afterDelete($item)
    {
        $this->redirect($this->moduleLink());  
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_VoyantQuestionController extends CrudController
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
        
        $this->crudConfig['modelName'] = 'voyantQuestion';
        
        //edit
        $c = new Criteria();
        $c->addWithRelation('voyantQuestionPrices', array('fields' => 'questionId, priceId, quantity, price'));
        
        $this->crudConfig['actions']['edit']['criteria'] = $c;

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }

    public function pendingAction($page = 1)
    {
        $c = new Criteria();
        $c->add("adminValidation",0);
        $c->addOrder("questionId DESC");

        //set pagination
        $perPage = 5;
        $totalCount = $this->statistic->getCountPendingVoyantQuestion();
        $totalPages = ceil($totalCount / $perPage);

        $this->set('pageNavigation', array('baseLink' => '/admin/voyantQuestion/pending/',
                                           'totalPages' => $totalPages,
                                           'currentPage' => $page));
        
        $c->setPagination($page, $perPage);
        $this->set('countQuestionPending', $totalCount);

        $c->addWithRelation('voyant', array('fields' => 'name'));
        $voyantquestions = $this->voyantQuestion->findAll($c,'voyants.name, questionId, voyantquestions.title, voyantquestions.updated_at',true);
        $this->set('voyantquestions', $voyantquestions); 

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $totalCount,
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }
    
    public function createAction($voyantId = null)
    {
        $this->set('voyantOptionListSelectedId', $voyantId);
        parent::createAction();

        /*
        * Set statistic
        */
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));
    }
    
    protected function beforeSave($item)
    {
        $item['displayOnline'] = empty($item['displayOnline']) ? 0 :1;
        $item['adminValidation'] = empty($item['adminValidation']) ? 0 :1;
        
        $uploadedFile = new UploadedFile('image');
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
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyant/edit/'.$item->voyantId);
        $this->set('redirectUrl', $redirectUrl);
        $this->redirect($redirectUrl);
    }
    
    protected function crudActionHandler($action, $voyant = null)
    {
        $this->set('voyantOptionsList', $this->voyant->getArray(null, 'name'));
        
        if ($action == 'edit') {
            $this->set('voyantOptionListSelectedId', $voyant->voyantId);
        }
    }
    
    public function savePositionsAction()
    {
        $this->viewClass = 'JsonView';
        
        foreach ($this->request->positions as $fieldId => $position) {
            $this->voyantQuestion->updateByPk(array('position' => $position), $fieldId);
        }
        
        $this->set('status', 'ok');
    }
    
    protected function afterDelete($item)
    {
        $this->redirect(AppRouter::getRewrittedUrl('/admin/voyant/edit/' . $item->voyantId));  
    }
}

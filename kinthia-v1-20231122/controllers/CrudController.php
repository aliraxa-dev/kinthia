<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


abstract class CrudController extends AppController
{
    protected $crudConfig;
        
    public function indexAction($page = 1)
    {

        $model = Model::factoryInstance($this->crudConfig['modelName']);
                
        if (!empty($this->crudConfig['actions']['index']['criteria'])) {
            $c = $this->crudConfig['actions']['index']['criteria'];
        } else {
            $c = new Criteria();
        }

        //set pagination
        $perPage = 50;
        $totalCount = $model->getCount($c);
        $totalPages = ceil($totalCount / $perPage);

        $this->set('pageNavigation', array('baseLink'    => $this->crudConfig['pageNavigation']['baseLink'],
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page));
        
        $c->setPagination($page, $perPage);
        $this->set($this->crudConfig['modelName'] . 'sCount', $totalCount);
        
        if (!empty($this->crudConfig['actions']['index']['selectFields'])) {
            $fields = $this->crudConfig['actions']['index']['selectFields'];
        } else {
            $fields = '*';
        }
        
        $items = $model->findAll($c, $fields);
        if($this->crudConfig['modelName'] == 'voyant'){
            $voyants = $model->findAll($c, $fields);
        foreach($voyants as $voyant){
            $voyantId = $voyant['voyantId'];
         $vdo_usedtime = $this->statistic->getConsultationtime($voyantId,'webcam');
          $phone_usedtime = $this->statistic->getConsultationtime($voyantId,'phone'); 
          $voyant['vdo_usedtime'] = $vdo_usedtime;
          $voyant['phone_usedtime'] = $phone_usedtime;
          $items2[] =$voyant;
        } 
        $items = $items2;
        }
      /* echo "<pre>";
       print_r($items);
       die();*/
        
        $this->set($this->crudConfig['modelName'] . 's', $items);

        //Unset session...
        if(isset($_SESSION['message']) && !empty($_SESSION['message'])){
            unset($_SESSION['message']);
        }
        
    }
       
      
            
    public function createAction()
    {
        $this->crudActionHandler('create');
        $this->set('edit', false);
    }
    
    public function saveAction()
    {
        $model = Model::factoryInstance($this->crudConfig['modelName']);
        $primaryKey = $model->getPrimaryKey();
        
        $this->viewClass = 'JsonView';
        $edit = !empty($this->request[$primaryKey]);
        
        if ($edit) {
            $item = $model->findByPk($this->request[$primaryKey]);
            $type = "updated";
        } else {
            $recordName = ucfirst($this->crudConfig['modelName']) . 'Record';
            $item = new $recordName();
            $type = "saved";
        }
        
        $errorMessage = $model->validate($this->request);

        if ($errorMessage) {
            $this->set('status', 'error');
            $this->set('message', _t($errorMessage));
            return;
        }

        $fields = $model->getFields();
        
        if (empty($fields)) {
            $fieldKeys = array_keys($this->request->toArray());
            echo ' $fields = array(\'' . implode('', '', $fieldKeys) . '\')<br>';
            foreach ($fieldKeys as $fieldKey) {
                echo 'ALTER TABLE `'.Config::get('DB_PREFIX') 
                     . $this->crudConfig['modelName']
                     . 's` ADD `' . $fieldKey . '` TEXT NOT NULL;<br>';
            }
            return;
        }
        $item->fromArray($this->request->getArray($fields));
         
        $this->beforeSave($item);
        $item->save();
        $this->set('status', 'ok');       
        $this->afterSave($item);
        $_SESSION['message'] = ucfirst($this->crudConfig['modelName'])." has successfully ".$type.".";   
    }
    
    public function editAction($itemId)
    {
        $model = Model::factoryInstance($this->crudConfig['modelName']);
        
        if (!empty($this->crudConfig['actions']['edit']['criteria'])) {
            $c = $this->crudConfig['actions']['edit']['criteria'];
        } else {
            $c = new Criteria();
        }
        
        $c->add($model->getPrimaryKey(), $itemId);
        $item = $model->find($c);

        $this->crudActionHandler('edit', $item);
        
        $this->set($this->crudConfig['modelName'], $item);
        if($this->crudConfig['modelName'] == 'voyant'){
            $item = $this->setVoyantItem($item);
            $this->set('voyantData', $item);
            /*echo "<pre>";
            print_r($item);
            die();*/
        }
        $this->set($this->crudConfig['modelName'] . 'Json', JsonView::php2js($item));
        
        $this->set('edit', true);

    }

    public function setVoyantItem($item)
    {
        $skill_ids = $languag_id = $consultation_ids= [];
        if(isset($item['voyantSkills']) && count($item['voyantSkills']) > 0){
            $skill_ids = array_column($item['voyantSkills'], 'skillId');
            unset($item['voyantSkills']);
        }
        if(isset($item['voyantLanguage']) && count($item['voyantLanguage']) > 0){
            $languag_id = array_column($item['voyantLanguage'], 'languageId');
            unset($item['voyantLanguage']);
        }
        if(isset($item['voyantConsultation']) && count($item['voyantConsultation']) > 0){
            $consultation_ids = array_column($item['voyantConsultation'], 'consultationId');
            unset($item['voyantConsultation']);
        }
         if(isset($item['userQuestions']) && count($item['userQuestions']) > 0){
           $item['userQuestionscount'] = count($item['userQuestions']);
        }else{
            $item['userQuestionscount'] = 0;
        }
        $voyantId = $item['voyantId'];
         if(isset($item['voyantId'])){
         $vdo_usedtime = $this->statistic->getConsultationtime($voyantId,'webcam');
          $phone_usedtime = $this->statistic->getConsultationtime($voyantId,'phone'); 
          $phone_usedcount = $this->statistic->getConsultationcount($voyantId,'phone'); 
          $vdo_usedcount = $this->statistic->getConsultationcount($voyantId,'webcam');
          $getVoyantUsersCount = $this->statistic->getVoyantUsersCount($voyantId);
          $item['vdo_usedtime'] = $vdo_usedtime;
          $item['phone_usedtime'] = $phone_usedtime;
          $item['vdo_usedcount'] = $vdo_usedcount;
          $item['phone_usedcount'] = $phone_usedcount;
          $item['getVoyantUsersCount'] = $getVoyantUsersCount;
        }
        $item['skill_ids'] = $skill_ids;
        $item['language_id'] = $languag_id;
        $item['consultation_ids'] = $consultation_ids;
       /* echo "<pre>";
        print_r($item);
        die();*/
        return $item;
    }
    
    public function deleteAction($itemId)
    {
        $model = Model::factoryInstance($this->crudConfig['modelName']);
        $item = $model->findByPk($itemId);
        $this->beforeDelete($item);
        $item->del();
        $this->afterDelete($item);
    }
    
    protected function afterDelete($item)
    {
        $this->redirect($this->request->getRefererUrl());  
    }
    
    protected function beforeDelete($item)
    {
        
    }
    
    protected function beforeSave($item)
    {
        
    }
    
    protected function afterSave($item)
    {

    }
    
    protected function crudActionHandler($action, $item = null)
    {
        
    }
}

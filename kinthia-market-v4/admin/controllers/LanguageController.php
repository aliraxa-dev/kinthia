<?php
/**
 * Arfooo
 * 
 * @package    Arfooo
 * @copyright  Copyright (c) Arfooo Annuaire (fr) and Arfooo Directory (en)
 *             by Guillaume Hocine (c) 2007 - 2010
 *             http://www.arfooo.com/ (fr) and http://www.arfooo.net/ (en)
 * @author     Guillaume Hocine & Adrian Galewski
 * @license    http://creativecommons.org/licenses/by/2.0/fr/ Creative Commons
 */


class Admin_LanguageController extends CrudController
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
        $this->crudConfig['modelName'] = 'language';
        $this->crudConfig['pageNavigation']['baseLink'] = '/admin/language/';
        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending')
        ));

        $this->set("message",$this->session->get("message"));
    }

    public function beforeSave($item)
    {
        $uploadedFile = new UploadedFile('languageFlag');
        $uploadedFile->addFilter('extension', array('jpg', 'jpeg', 'gif', 'png'));
        $uploadedFile->addFilter('maxSize', intval(Config::get('itemGalleryImageMaxWeight')) * 1024);
        
        if ($uploadedFile->wasUploaded()) {
            $uploadedFile->validate();
            $uploadedFile->setSavePath(CODE_ROOT_DIR.'uploads/photos/');
            $uploadedFile->setAutoCreateDirs(true);
            $uploadedFile->save();
            $item->languageFlag = $uploadedFile->getSavedFileName();
        }else{
            if(!empty($this->request->old_languageFlag)){
                 $item->languageFlag = $this->request->old_languageFlag;
            }           
        }
    }

    public function afterSave($item)
    {
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/language');
        $this->set('redirectUrl', $redirectUrl);       
        $this->redirect($redirectUrl);
    }
}

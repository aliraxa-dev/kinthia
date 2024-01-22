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


class Admin_PackageController extends CrudController
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
        $this->crudConfig['modelName'] = 'package';
        $this->crudConfig['pageNavigation']['baseLink'] = '/admin/package/';
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
         $item['packagePromo'] = $item['packagePromo']==0 ? 0 :1;
         $item['packageDisplay'] = $item['packageDisplay']==0 ? 0 :1;
    }

    public function afterSave($item)
    {
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/package');
        $this->set('redirectUrl', $redirectUrl);
        $this->redirect($redirectUrl);
    }
}

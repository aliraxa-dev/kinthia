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


class Admin_SkillController extends CrudController
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
        $this->crudConfig['modelName'] = 'skill';
        $this->crudConfig['pageNavigation']['baseLink'] = '/admin/skill/index';
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
        $item['createPage'] = $item['createPage']==0 ? 0 :1;
    }

    public function afterSave($item)
    {
        $redirectUrl = AppRouter::getRewrittedUrl('/admin/skill');
        $this->set('redirectUrl', $redirectUrl);
        $this->redirect($redirectUrl);
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class VoyantPanel_VoyantProfilController extends AppController
{
    /**
    * set access privileges
    */

    public function indexAction()
    {

        /**
        * set statistic
        */
        //get Voyant languages...
        $d = new Criteria();
        $d->add('voyantId', $this->userId);
        $voyantlanguages = Model::factoryInstance('voyantLanguage')->findAll($d, "languageId");
        $voLangId = []; $languageIds = [];
        if(isset($voyantlanguages) && !empty($voyantlanguages)){
           foreach($voyantlanguages as $voLang){
                $voLangId[] =  $voLang['languageId'];
           }
           $languageIds = array_values(array_unique($voLangId));
        }
        $g = new Criteria();
        $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
        $this->set('voyantlanguages', $voyantlanguages);
        $this->set('languageIds', $languageIds);


        //get voyant skills...
        $k = new Criteria();
        $k->add('voyantId', $this->userId);
        $voyantSkills = Model::factoryInstance('voyantSkill')->findAll($k, "skillId");
        $voSkillId = []; $skillIds = [];
        if(isset($voyantSkills) && !empty($voyantSkills)){
           foreach($voyantSkills as $voSkill){
                $voSkillId[] =  $voSkill['skillId'];
           }
           $skillIds = array_values(array_unique($voSkillId));
        }
        $l = new Criteria();
        $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
        $this->set('voyantSkills', $voyantSkills);
        $this->set('skillIds', $skillIds);

        $this->set('voyant', $this->voyant->findByPk($this->userId));
        $this->set('statistic', array(
            'voyantPendingMessageCount' => $this->statistic->getVoyantMessagesCountWithPending($this->userId),
            'voyantUsersCount'       => $this->statistic->getVoyantTotalUsersCount($this->userId),
            'answeredQuestionsCount' => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'answered'),
            'pendingQuestionsCount'  => $this->statistic->getVoyantQuestionsCountWithStatus($this->userId, 'pending'),
            'pendingCheckOrdersCount'  => $this->statistic->getVoyantPendingCheckOrdersCount($this->userId),
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1'),
            'getConsultationtimephone'  => $this->statistic->getConsultationtime($this->userId,'phone'),
            'getConsultationtimewebcam'  => $this->statistic->getConsultationtime($this->userId,'webcam'),
            'getConsultationtimechat'  => $this->statistic->getConsultationtime($this->userId,'chat'),
        ));
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Admin_VoyantController extends CrudController
{
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }

        $this->crudConfig['modelName'] = 'voyant';


        //index action
        $this->crudConfig['pageNavigation']['baseLink'] = '/admin/voyant/index/';
        $fields = 'voyantId, name, firstName, lastName, email, available, displayPhone, displayWebcam, displayEmail, displayChat';
        $this->crudConfig['actions']['index']['selectFields'] = $fields;


        $c = new Criteria();
        $userQuestionsCriteria = new Criteria();
        $userQuestionsCriteria->add('status', 'answered');
        $userQuestionsCriteria->addGroup('voyantId');
        $c->addWithRelation('userQuestions', array('fields' => 'voyantId, count(*) as answeredCount',
                                                   'criteria' => $userQuestionsCriteria));



        $this->crudConfig['actions']['index']['criteria'] = $c;

        //edit action
        $c = new Criteria();
        $voyantQuestionCriteria = new Criteria();
        $voyantQuestionCriteria->addOrder('position');


        $c->addWithRelation('voyantQuestions', array('fields'   => 'voyantId, questionId, title',
                                                     'criteria' => $voyantQuestionCriteria));
        $c->addWithRelation('userQuestions', array('fields' => 'userquestions.voyantId, userquestions.questionId, userquestions.status as status, userquestions.orderId as orderId,creationDate',
                                                   'relations' => array(
                                                       'voyantQuestion' => array(
                                                           'fields' => 'title'),
                                                       'user' => array(
                                                           'fields' => 'name, firstName, lastName'),

                                                           'order' => array(
                                                            'fields' => 'invoiceId ,purchaseDate,paymentMethod,amount')
                                                        )));


        $c->addWithRelation('voyantComments', array('fields' => 'voyantId, commentId, text, rating'
                                                                . ',date, remoteIp, validated',
                                                    'relations' => array(
                                                        'user' => array(
                                                            'fields' => 'name'
                                                            )
                                                        )
                                                    )
        );

        $c->addWithRelation('voyantSkills', array('fields'   => '*'));
        $c->addWithRelation('voyantLanguage', array('fields'   => '*'));
        $c->addWithRelation('voyantConsultation', array('fields'   => '*'));




        $this->crudConfig['actions']['edit']['criteria'] = $c;

        $this->set('languages',Model::factoryInstance('language')->findAll());
        $this->set('skills',Model::factoryInstance('skill')->findAll());
        $this->set('consultations',Model::factoryInstance('consultation')->findAll());




        /*
        * Set statistic
        */
        $findGetId=explode('/',$_SERVER['REQUEST_URI']);
        $current_voyant_id=end($findGetId);

        //get data  consultations by phone or current voyant
        $c1 = new Criteria();
        $c1->add('type', 'phone');
        $c1->add('userconsultations.voyantId', $current_voyant_id);
        $c1->addOrder("date DESC");
        $c1->addWithRelation('voyant', array(
                                'fields' => 'firstName'));
        $c1->addWithRelation('user', array(
                                    'fields' => 'name'));
         $userconsultation1 = $this->userConsultation->findAll($c1);
         $this->set('userconsultations',$userconsultation1);



           //get data  consultations by webcam or current voyant
        $c2 = new Criteria();
        $c2->add('type', 'webcam');
        $c2->add('userconsultations.voyantId', $current_voyant_id);
        $c2->addOrder("date DESC");
        $c2->addWithRelation('voyant', array(
                                'fields' => 'firstName'));
        $c2->addWithRelation('user', array(
                                    'fields' => 'name'));
         $userconsultation2 = $this->userConsultation->findAll($c2);
         $this->set('userconsultationsbywebcam',$userconsultation2);

         $c4 = new Criteria();
            $c4->add('type', 'chat');
            $c4->add('userconsultations.voyantId', $current_voyant_id);
            $c4->addOrder("date DESC");
            $c4->addWithRelation('voyant', array(
                                    'fields' => 'firstName'));
            $c4->addWithRelation('user', array(
                                        'fields' => 'name'));
                $userconsultation4 = $this->userConsultation->findAll($c4);
                $this->set('userconsultationsbychat',$userconsultation4);


                 //get data  order invoice list or current voyant
        $c3 = new Criteria();

        $c3->add('orders.voyantId', $current_voyant_id);

        // $c3->addWithRelation('userQuestions', array(
        //                         'fields' =>  'orderId'));


         $invoiceList1 = $this->order->findAll($c3);
         $this->set('invoiceList',$invoiceList1);









        $this->set('statistic', array(
            'unpublishReviewCount' => $this->statistic->getCountPendingReview(),
            'pendingvoyantQuestionCount'=> $this->statistic->getCountPendingVoyantQuestion(),
            'pendingMessagesCount' => $this->statistic->getVoyantMessagesCountWithPending(),
            'pendingQuestionsCount'  => $this->statistic->getCountOfQuestionsWithStatus('pending'),
            'answeredQuestionsEarning' => $this->statistic->getVoyantQuestionsTotalEarning($current_voyant_id),
            'totalEarningPhone' => $this->statistic->getTotalEarning('phone',$current_voyant_id),
            'totalEarningChat' => $this->statistic->getTotalEarning('chat',$current_voyant_id),
            'totalEarningWebcam' => $this->statistic->getTotalEarning('webcam',$current_voyant_id),
        ));

        $this->set("message",$this->session->get("message"));
    }

    protected function beforeSave($item)
    {
        define('MB', 1048576);

        if (empty($item->voyantId)) {
            $user = new UserRecord();
            $user->email = $this->request->email;
            $user->password = md5($this->request->password);
            $user->role = 'voyant';
        } else {
            $user = $this->user->findByPk($item->voyantId);
            if (!empty($this->request->password)) {
                $user->password = md5($this->request->password);
            }
        }

        $uploadedFile = new UploadedFile('audioFile');
        $uploadedFile->addFilter('extension', array('mp3'));
        $uploadedFile->addFilter('maxSize', intval(Config::get('VOYANT_AUDIO_PRESENTATION_LIMIT')) * MB);

        if ($uploadedFile->wasUploaded()) {
            $uploadedFile->validate();
            $uploadedFile->setSavePath(CODE_ROOT_DIR.'uploads/audio/');
            $uploadedFile->save();
            $item->audioSrc = $uploadedFile->getSavedFileName();
        }
        else{
            // Remove the audio file
            if(isset($this->request->audioSrcDel) && !$uploadedFile->wasUploaded() && $this->request->audioSrcDel == "del"){
                $item->audioSrc = null;
            }
        }

        $user->email = $this->request->email;
        $user->save();
        $item->voyantId = $user->userId;

        // $this->set('message', 'Voyant was saved');
        // $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyant/index/');
        // $this->set('redirectUrl', $redirectUrl);
        // $this->redirect($redirectUrl);
    }

    protected function afterSave($item)
    {
        if (!empty($this->request->tempId)) {
            $c = new Criteria();
            $c->add('tempId', $this->request->tempId);

            $this->photo->update(array('itemId' => $item->voyantId, '_tempId' => 'NULL'), $c);
            $item->updatePhotos();
        }
        if(isset($this->request->skills) && !empty($this->request->skills)){
            $d = new Criteria();
            $d->add('voyantId', $item->voyantId);
            $skills = Model::factoryInstance('voyantSkill')->findAll($d, 'skillId');
            $skillIds = [];
            if(isset($skills) && !empty($skills)){
                foreach($skills as $skill){
                  $skillIds[] = $skill['skillId'];
                }
            }

            if (array_diff($skillIds,$this->request->skills) != array_diff($this->request->skills,$skillIds)) {
                //delete before save or edit languages...
                $c = new Criteria();
                $c->add('voyantId', $item->voyantId);
                Model::factoryInstance('voyantSkill')->del($c);

                foreach($this->request->skills as $key => $value){
                    $voyant_skill = new VoyantSkillRecord();
                    $voyant_skill->skillId = $value;
                    $voyant_skill->voyantId = $item->voyantId;
                    $voyant_skill->save();
                }
            }

            //$this->asdf($this->request->consultations);
        }

        if(isset($this->request->languages) && !empty($this->request->languages)){

            $d = new Criteria();
            $d->add('voyantId', $item->voyantId);
            $languages = Model::factoryInstance('voyantLanguage')->findAll($d, 'languageId');
            $languageIds = [];
            if(isset($languages) && !empty($languages)){
                foreach($languages as $language){
                  $languageIds[] = $language['languageId'];
                }
            }

            if (array_diff($languageIds,$this->request->languages) != array_diff($this->request->languages,$languageIds)) {
                //delete before save or edit languages...
                $c = new Criteria();
                $c->add('voyantId', $item->voyantId);
                Model::factoryInstance('voyantLanguage')->del($c);

                foreach($this->request->languages as $key => $value){
                    $voyant_lang = new VoyantLanguageRecord();
                    $voyant_lang->languageId = $value;
                    $voyant_lang->voyantId = $item->voyantId;
                    $voyant_lang->save();
                }
            }

           // $this->asdf($this->request->consultations);
        }
         if(isset($this->request->consultations) && !empty($this->request->consultations)){
                $d = new Criteria();
                $d->add('voyantId', $item->voyantId);
                $consultations = Model::factoryInstance('voyantConsultation')->findAll($d, 'consultationId');
                $consultationIds = [];
                if(isset($consultations) && !empty($consultations)){
                    foreach($consultations as $consultation){
                      $consultationIds[] = $consultation['consultationId'];
                    }
                }


                if (array_diff($consultationIds,$this->request->consultations) != array_diff($this->request->consultations,$consultationIds)) {
                        //delete before save or edit consultation...
                        $c = new Criteria();
                        $c->add('voyantId', $item->voyantId);
                        Model::factoryInstance('voyantConsultation')->del($c);

                        foreach($this->request->consultations as $key => $value){
                            $voyant_consult = new VoyantConsultationRecord();
                            $voyant_consult->consultationId = $value;
                            $voyant_consult->voyantId = $item->voyantId;
                            $voyant_consult->save();
                        }

                        if(in_array(1, $this->request->consultations)){
                             $data = array("displayPhone" => 1);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }else{
                             $data = array("displayPhone" => 0);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }

                        if(in_array(2, $this->request->consultations)){
                             $data = array("displayWebcam" => 1);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }else{
                             $data = array("displayWebcam" => 0);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }

                        if(in_array(3, $this->request->consultations)){
                             $data = array("displayEmail" => 1);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }else{
                             $data = array("displayEmail" => 0);
                             $this->voyant->updateByPk($data, $item->voyantId);
                        }

                        if(in_array(4, $this->request->consultations)){
                            $data = array("displayChat" => 1);
                            $this->voyant->updateByPk($data, $item->voyantId);
                        }else{
                            $data = array("displayChat" => 0);
                            $this->voyant->updateByPk($data, $item->voyantId);
                        }

                }
         }

        $this->set('message', 'Voyant was saved');
        //$this->set('redirectUrl', $this->moduleLink());

        $redirectUrl = AppRouter::getRewrittedUrl('/admin/voyant/index');
        $this->set('redirectUrl', $redirectUrl);
        $this->redirect($redirectUrl);
    }

    // public function asdf($voyantconsultations,$voyantId){

    //     if(isset($voyantconsultations) && !empty($voyantconsultations)){
    //             $d = new Criteria();
    //             $d->add('voyantId', $voyantId);
    //             $consultations = Model::factoryInstance('voyantConsultation')->findAll($d, 'consultationId');
    //             $consultationIds = [];
    //             if(isset($consultations) && !empty($consultations)){
    //                 foreach($consultations as $consultation){
    //                   $consultationIds[] = $consultation['consultationId'];
    //                 }
    //             }


    //             if (array_diff($consultationIds,$voyantconsultations) != array_diff($voyantconsultations,$consultationIds)) {


    //                     foreach($voyantconsultations as $key => $value){
    //                         $voyant_consult = new VoyantConsultationRecord();
    //                         $voyant_consult->consultationId = $value;
    //                         $voyant_consult->voyantId = $voyantId;
    //                         $voyant_consult->save();
    //                     }

    //                     if(in_array(1, $voyantconsultations)){
    //                          $data = array("displayPhone" => 1);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }else{
    //                          $data = array("displayPhone" => 0);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }

    //                     if(in_array(2, $voyantconsultations)){
    //                          $data = array("displayWebcam" => 1);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }else{
    //                          $data = array("displayWebcam" => 0);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }

    //                     if(in_array(3, $voyantconsultations)){
    //                          $data = array("displayEmail" => 1);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }else{
    //                          $data = array("displayEmail" => 0);
    //                          $this->voyant->updateByPk($data, $voyantId);
    //                     }

    //             }
    //      }

    // }

    protected function crudActionHandler($action, $item = null)
    {
        switch($action)
        {
            case 'edit':
                $item->itemId = $item->voyantId;
                $this->user->attachPhotos($item);
                break;

            case 'create':
                $this->set('tempId', md5(rand()));
                break;
        }
    }

    protected function afterDelete($item)
    {
        $this->redirect($this->moduleLink());
    }
}

<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class SkillController extends AppController
{
    /**
    * skill index page
    *@return $voyants Array
    */
    public function indexAction($page = 1)
    {
       $this->getSkillData([], $page);
        //get userfav
        $userid=$this->session->get('userId');

        $userFavObj = new Criteria();
        $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
        $userFav = [];
        foreach ($voyantIdsFromUserFav as $item) {
            $userFav[]= $item['voyantId'];
        }
        $voyantIdsFromUserFav['userFavIds'] = $userFav;
        $this->set('userid',$userid);
        $this->set('userFav',$userFav);

           //Search expert
           if (isset($this->request->expert) && !empty($this->request->expert)) {

            // $this->redirect(AppRouter::getRewrittedUrl('/'.$this->request->expert));

            $voayntNameObj = new Criteria();
               $voayntNameObj->add('name', '%' . $this->request->expert . '%', 'LIKE');
               $voayntName = Model::factoryInstance('voyant')->findAll($voayntNameObj,'name');
               if($voayntName){

               $nameVoyant= str_replace(' ', '-', $voayntName[0]['name']);

                   $this->redirect(AppRouter::getRewrittedUrl('/'.$nameVoyant));

               }

               else
               {
                echo "<script>alert('Not Found this Expert')</script>";
               }
            }





    }

    /**
    * skill detail page
    *@param $slug
    */

    public function detailAction($slug)
    {
        $g = new Criteria();
        $g->add('slug', $slug);
        $skill = Model::factoryInstance("Skill")->find($g);
        $this->set('skill', $skill);

        $c = new Criteria();
        $c->add('skillId', $skill->skillId);
        $filteredSkills = Model::factoryInstance("voyantSkill")->findAll($c);
        $this->set('filteredSkills', $filteredSkills);

        $voyantIds = [];
        foreach($filteredSkills as $key=> $voynt){
            $voyantIds[] = $voynt['voyantId'];
        }

        $k = new Criteria();
        $voyantSkil = [];
        if(isset($voyantIds) && !empty($voyantIds)){
            $k->add('voyantId', $voyantIds, 'IN');
            $voyantSkil = Model::factoryInstance("voyantSkill")->getArray($k, 'skillId');
            $voyantSkil = array_values(array_unique($voyantSkil));
            $this->set('voyantSkil', $voyantSkil);
        }

        $this->getSkillData($skill->skillId, $page = 1);

        $d = new Criteria();
        $voyantSkills = Model::factoryInstance("Skill")->findAll($d);
        $this->set('voyantSkills', $voyantSkills);

        $title = $skill->title;
        $skill->setTitle($title);
         //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('userid',$userid);
            $this->set('userFav',$userFav);


    }

    /**
    * skill ajax page
    */
    public function ajaxpageAction(){
        if(!empty($this->request->filterSkillIds)){
        	$skillIdArr = [];
        	$skillIdArr = explode(",", $this->request->filterSkillIds);
        	$filteredSkills = $this->skill->getVoyantSkills($skillIdArr);
        	$this->set('filteredSkills', $filteredSkills);
        	$this->getSkillData($this->request->filterSkillIds, $page = 1);
        	$g = new Criteria();
	    	$voyantSkills = Model::factoryInstance("Skill")->findAll($g);
	    	$this->set('voyantSkills', $voyantSkills);

             //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('userid',$userid);
            $this->set('userFav',$userFav);
        }
    }

    public function ajaxpage1Action(){

        if(!empty($this->request->filterLanguageIds)){
            $langIdArr = [];
        	$langIdArr = explode(",", $this->request->filterLanguageIds);

        	$filteredLangs = $this->language->getVoyantLanguages($langIdArr);
        	$this->set('filteredLangs', $filteredLangs);
        	$this->getSkillData($this->request->filterLanguageIds, $page = 1);
        	$g = new Criteria();
	    	$voyantLanguages = Model::factoryInstance("Language")->findAll($g);
	    	$this->set('voyantLanguages', $voyantLanguages);

             //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('userid',$userid);
            $this->set('userFav',$userFav);

        }
    }



    public function ajaxpage2Action(){

        if(!empty($this->request->filterConsultationIds)){
            $consIdArr = [];
        	$consIdArr = explode(",", $this->request->filterConsultationIds);

        	$filteredCons = $this->consultation->getVoyantConsultations($consIdArr);
        	$this->set('filteredCons', $filteredCons);
        	$this->getSkillData($this->request->filterConsultationIds, $page = 1);
        	$g = new Criteria();
	    	$voyantConsultations = Model::factoryInstance("Consultation")->findAll($g);
	    	$this->set('voyantConsultations', $voyantConsultations);

            //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('userid',$userid);
            $this->set('userFav',$userFav);


        }
    }


    public function ajaxpage3Action(){

        if(!empty($this->request->filterExpertValues))
        {


            $c = new Criteria();
            $genderArr = [];
        	$genderArr = explode(",", $this->request->filterExpertValues);

            $c->add('gender', $genderArr,'IN');
            $voyantDetails = Model::factoryInstance("Voyant")->findAll($c);
            $userFav2= [];
            foreach($voyantDetails as $userFav){
                $voyantId = $userFav['voyantId'];
                $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                      $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);


                $userFav2[] = $userFav;


            }
            $voyantDetails = $userFav2;


            $this->set('voyantDetails', $voyantDetails);
            $this->set('statistic', array(
                'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
            ));


        //get userfav
        $userid=$this->session->get('userId');
        $userFavObj = new Criteria();
         $userFavObj->add('userId',$userid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
            foreach ($voyantIdsFromUserFav as $item) {
                $userFav[]= $item['voyantId'];
            }
            $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('userid',$userid);
            $this->set('userFav',$userFav);
        }
    }

         public function ajaxpage4Action(){
            if(!empty($this->request->filterFav))
            {
                  $filterId= $this->request->filterFav;



                 $filtersFromUserFav= $this->UserFav->findAllFav("SELECT kinthiavoyance_voyants.voyantId as voyantId, kinthiavoyance_userfavs.voyantId as userfavvoyantid, imageSrc, ratingAverage,shortDescription, contactDescription,name,displayWebcam,urlName,consultationStatus,displayPhone,displayChat,displayEmail,headerDescription FROM kinthiavoyance_voyants INNER JOIN kinthiavoyance_userfavs ON kinthiavoyance_voyants.voyantId = kinthiavoyance_userfavs.voyantId WHERE userId = '$filterId' AND status = '1' ");

                 //pass voyantId
            $userFav2= [];
            foreach($filtersFromUserFav as $userFav){
                $voyantId = $userFav['voyantId'];
                $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);

                $userFav2[] = $userFav;
            }

            $filtersFromUserFav = $userFav2;

                 $this->set('filtersFromUserFav',$filtersFromUserFav);
                 $curentUserid=$this->request->filterFav;
       $userFavObj = new Criteria();
         $userFavObj->add('userId',$curentUserid);
        $userFavObj->add('status','1');
        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
         $userFav = [];
             foreach ($voyantIdsFromUserFav as $item) {
                 $userFav[]= $item['voyantId'];
                }
                $voyantIdsFromUserFav['userFavIds'] = $userFav;
            $this->set('curentUserid',$curentUserid);
            $this->set('userFav',$userFav);
            }

            $this->set('statistic', array(
                'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
            ));


            //get VoyantSkills
            $l = new Criteria();

            $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
            $this->set('voyantSkills', $voyantSkills);
        }

        public function sortByAction(){

                 //sort by Available
            if(!empty($this->request->sortValues==1))
            {
                $sortObj = new Criteria();

               $sortObj->add('available','1');
               $sortObjFromVoyant = Model::factoryInstance("voyant")->findAll($sortObj);

            $userFav2= [];

            foreach($sortObjFromVoyant as $userFav) {
                $voyantId = $userFav['voyantId'];
                $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);

                $userFav2[] = $userFav;
                $sortObjFromVoyant = $userFav2;
            }


            $userFavObj = new Criteria();
            $userFavObj->add('userId',$this->session->get('userId'));
            $userFavObj->add('status','1');
            $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
            $userFav = [];
                            foreach ($voyantIdsFromUserFav as $item) {
                                $userFav[]= $item['voyantId'];
                                }
                                $voyantIdsFromUserFav['userFavIds'] = $userFav;
                            $this->set('userid',$this->session->get('userId'));
                            $this->set('userFav',$userFav);



                            $this->set('sortObjFromVoyant', $sortObjFromVoyant);
                            $this->set('statistic', array(
                                'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
                            ));



            //get VoyantSkills
            $l = new Criteria();

            $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
            $this->set('voyantSkills', $voyantSkills);

            $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);


        }

             //sort by best rated
        if(!empty($this->request->sortValues=='bestRated'))
        {
            $sortBestObj = new Criteria();

           $sortObjFromVoyantBest = Model::factoryInstance("voyant")->findAll($sortBestObj,"max(voyants.ratingAverage) as ratingAverage,displayWebcam ,consultationStatus,displayEmail,name,headerDescription,voyantId,urlName,imageSrc, shortDescription ,displayPhone, displayChat ");

           $userFav2= [];
           foreach($sortObjFromVoyantBest as $userFav)
           {
               $voyantId = $userFav['voyantId'];
               $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                     $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                     $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                     $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
                     $userFav2[] = $userFav;
                     $sortObjFromVoyantBest = $userFav2;

              }

                                $this->set('sortObjFromVoyantBest', $sortObjFromVoyantBest);
                                $this->set('statistic', array(
                                    'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
                                ));



                        $userFavObj = new Criteria();
                            $userFavObj->add('userId',$this->session->get('userId'));
                            $userFavObj->add('status','1');
                            $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
                            $userFav = [];
                                            foreach ($voyantIdsFromUserFav as $item) {
                                                $userFav[]= $item['voyantId'];
                                                }
                                                $voyantIdsFromUserFav['userFavIds'] = $userFav;
                                            $this->set('userid',$this->session->get('userId'));
                                            $this->set('userFav',$userFav);



                                    //get VoyantSkills
                                    $l = new Criteria();

                                    $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
                                    $this->set('voyantSkills', $voyantSkills);

                                    $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);



        }

          //sort by best rated Webmail
        if(!empty($this->request->sortValues=='W'))
        {

            $bestWebcamVoyantObj = new Criteria();

            $bestWebcamVoyantObj->add('type',$this->request->sortValues);
            $bestWebcamVoyant = Model::factoryInstance("voyantComment")->find($bestWebcamVoyantObj,"max(voyantcomments.rating) as rating,voyantId");

            $voyantDetailsObj = new Criteria();
            $voyantDetailsObj->add('voyantId',$bestWebcamVoyant['voyantId']);
            $voyantDetails = Model::factoryInstance("voyant")->findAll($voyantDetailsObj,"displayWebcam ,ratingAverage ,consultationStatus,displayEmail,name,headerDescription,voyantId,urlName,imageSrc, shortDescription ,displayPhone, displayChat  ");
            $userFav2= [];
            foreach($voyantDetails as $userFav)
            {
                $voyantId = $userFav['voyantId'];
                $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                      $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                      $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                      $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
                      $userFav2[] = $userFav;
                      $voyantDetails = $userFav2;

               }

            $this->set('voyantDetails', $voyantDetails);
            $this->set('statistic', array(
                'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
            ));



                    $userFavObj = new Criteria();
                        $userFavObj->add('userId',$this->session->get('userId'));
                        $userFavObj->add('status','1');
                        $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
                        $userFav = [];
                                        foreach ($voyantIdsFromUserFav as $item) {
                                            $userFav[]= $item['voyantId'];
                                            }
                                            $voyantIdsFromUserFav['userFavIds'] = $userFav;
                                        $this->set('userid',$this->session->get('userId'));
                                        $this->set('userFav',$userFav);



                                //get VoyantSkills
                                $l = new Criteria();

                                $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
                                $this->set('voyantSkills', $voyantSkills);

                                $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);

        }


          //sort by best rated  Phone
          if(!empty($this->request->sortValues=='P'))
          {

              $bestPhoneVoyantObj = new Criteria();

              $bestPhoneVoyantObj->add('type',$this->request->sortValues);
              $bestPhoneVoyant = Model::factoryInstance("voyantComment")->find($bestPhoneVoyantObj,"max(voyantcomments.rating) as rating,voyantId");

              $voyantDetailsPhoneObj = new Criteria();
              $voyantDetailsPhoneObj->add('voyantId',$bestPhoneVoyant['voyantId']);
              $voyantDetailsPhone = Model::factoryInstance("voyant")->findAll($voyantDetailsPhoneObj,"displayWebcam ,ratingAverage ,consultationStatus,displayEmail,name,headerDescription,voyantId,urlName,imageSrc, shortDescription ,displayPhone, displayChat  ");
              $userFav2= [];
              foreach($voyantDetailsPhone as $userFav)
              {
                  $voyantId = $userFav['voyantId'];
                  $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                        $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                        $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                        $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
                        $userFav2[] = $userFav;
                        $voyantDetailsPhone = $userFav2;

                 }

              $this->set('voyantDetailsPhone', $voyantDetailsPhone);
              $this->set('statistic', array(
                  'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
              ));



                      $userFavObj = new Criteria();
                          $userFavObj->add('userId',$this->session->get('userId'));
                          $userFavObj->add('status','1');
                          $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
                          $userFav = [];
                                          foreach ($voyantIdsFromUserFav as $item) {
                                              $userFav[]= $item['voyantId'];
                                              }
                                              $voyantIdsFromUserFav['userFavIds'] = $userFav;
                                          $this->set('userid',$this->session->get('userId'));
                                          $this->set('userFav',$userFav);



                                  //get VoyantSkills
                                  $l = new Criteria();

                                  $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
                                  $this->set('voyantSkills', $voyantSkills);
                                  $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);

          }








            //sort by best rated  Email
            if(!empty($this->request->sortValues=='E'))
            {

                $bestEmailVoyantObj = new Criteria();

                $bestEmailVoyantObj->add('type',$this->request->sortValues);
                $bestEmailVoyant = Model::factoryInstance("voyantComment")->find($bestEmailVoyantObj,"max(voyantcomments.rating) as rating,voyantId");

                $voyantDetailsEmailObj = new Criteria();
                $voyantDetailsEmailObj->add('voyantId',$bestEmailVoyant['voyantId']);
                $voyantDetailsEmail = Model::factoryInstance("voyant")->findAll($voyantDetailsEmailObj,"displayWebcam ,ratingAverage ,consultationStatus,displayEmail,name,headerDescription,voyantId,urlName,imageSrc, shortDescription ,displayPhone, displayChat  ");
                $userFav2= [];
                foreach($voyantDetailsEmail as $userFav)
                {
                    $voyantId = $userFav['voyantId'];
                    $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                          $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                          $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                          $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
                          $userFav2[] = $userFav;
                          $voyantDetailsEmail = $userFav2;

                   }

                $this->set('voyantDetailsEmail', $voyantDetailsEmail);
                $this->set('statistic', array(
                    'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
                ));



                        $userFavObj = new Criteria();
                            $userFavObj->add('userId',$this->session->get('userId'));
                            $userFavObj->add('status','1');
                            $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
                            $userFav = [];
                                            foreach ($voyantIdsFromUserFav as $item) {
                                                $userFav[]= $item['voyantId'];
                                                }
                                                $voyantIdsFromUserFav['userFavIds'] = $userFav;
                                            $this->set('userid',$this->session->get('userId'));
                                            $this->set('userFav',$userFav);



                                    //get VoyantSkills
                                    $l = new Criteria();

                                    $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
                                    $this->set('voyantSkills', $voyantSkills);

                                    $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);

            }






            //default
            if(!empty($this->request->sortValues=='default'))
            {

                $voyantDetailsObj = new Criteria();

                $voyantDetails= Model::factoryInstance("voyant")->findAll($voyantDetailsObj,"displayWebcam ,ratingAverage ,consultationStatus,displayEmail,name,headerDescription,voyantId,urlName,imageSrc, shortDescription ,displayPhone, displayChat  ");
                $userFav2= [];
                foreach($voyantDetails as $userFav)
                {
                    $voyantId = $userFav['voyantId'];
                    $userFav['countAnswer'] = $this->getCountAnswer($voyantId);
                          $userFav['nextTimeSlot']  = $this->getVoyantNextTimeSlot($voyantId);
                          $userFav['skillIds'] = $this->statistic->voyantSkills($voyantId);
                          $userFav['languageIds'] = $this->statistic->voyantLanguages($voyantId);
                          $userFav2[] = $userFav;
                          $voyantDetails = $userFav2;

                   }

                $this->set('voyantDetails', $voyantDetails);
                $this->set('statistic', array(
                    'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
                ));



                        $userFavObj = new Criteria();
                            $userFavObj->add('userId',$this->session->get('userId'));
                            $userFavObj->add('status','1');
                            $voyantIdsFromUserFav = Model::factoryInstance("UserFav")->findAll($userFavObj,'voyantId');
                            $userFav = [];
                                            foreach ($voyantIdsFromUserFav as $item) {
                                                $userFav[]= $item['voyantId'];
                                                }
                                                $voyantIdsFromUserFav['userFavIds'] = $userFav;
                                            $this->set('userid',$this->session->get('userId'));
                                            $this->set('userFav',$userFav);



                                    //get VoyantSkills
                                    $l = new Criteria();

                                    $voyantSkills = Model::factoryInstance('Skill')->findAll($l);
                                    $this->set('voyantSkills', $voyantSkills);


                                    $g = new Criteria();
                                    $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
                                    $this->set('voyantlanguages', $voyantlanguages);

            }

















        }


    //count QuestionAnswer
    public function getCountAnswer($voyantId1) {
        $voyantIdsObj = new Criteria();
        $voyantIdsObj->add('voyantId', $voyantId1);
        $voyantIdsFromUserQuestion = Model::factoryInstance("UserQuestion")->findAll($voyantIdsObj,'voyantId');
        $voyantIdsFromUserQuestion =count($voyantIdsFromUserQuestion);

        return $voyantIdsFromUserQuestion;
    }

    /**
    * Getting Skill Data
    *@param $filteredArr
    *@param $page
    */
    public function getSkillData($filteredArr, $page){
        //$itemsPerPage = 1;
    	$itemsPerPage = Config::get('voyantsPerPage');
        $c = new Criteria();
        $c->setCalcFoundRows(true);
        $c->setPagination($page, $itemsPerPage);

        $this->set('voyants', array_map(function($voyant){

            $c = new Criteria();
            $voyantQuestionCriteria = new Criteria();
            $voyantQuestionCriteria->addOrder('position');
            $voyantQuestionCriteria->setCalcFoundRows(true);
            $c->setCalcFoundRows(true);
            $c->addWithRelation('voyantQuestions', array(
                'fields'    => 'voyantId, questionId, shortDescription, title, price, urlName, imageSrc',
                'criteria'  => $voyantQuestionCriteria,
                'relations' => array(
                    'voyantQuestionPrices' => array(
                        'fields' => 'questionId, price, quantity, priceId'))));
            $c->addWithRelation('userQuestions', array(
                'fields' => 'userquestions.voyantId, userquestions.questionId, count(*) as answeredCount',
                'relations' => array(
                    'voyantQuestion' => array(
                        'fields' => 'title'))));

            $c->add('voyantId', $voyant['voyantId']);
            $voyant2 = $this->voyant->find($c, 'voyants.*');
            $voyant['answeredCount'] = $voyant2['userQuestions'][0]['answeredCount'] ?? 0;

               //get Voyant languages...
               $voyant['languageIds'] = $this->statistic->voyantLanguages($voyant['voyantId']);

               //get voyant skills...
               $voyant['skillIds'] = $this->statistic->voyantSkills($voyant['voyantId']);


                //get voyant ..
                $voyant['voyantIds'] = $this->statistic->voyants($voyant['voyantId']);

               //get voyant cons...
               $voyant['consultationIds'] = $this->statistic->voyantConsultations($voyant['voyantId']);
             //get voyant next time for consultation...
             $nextTimeSlot = $this->getVoyantNextTimeSlot($voyant['voyantId']);
             $voyant['nextTimeSlot'] = $nextTimeSlot;

            return $voyant;
        },$this->voyant->findAll($c, 'voyants.*')));

        $voyantIdArr = [];
        $k = new Criteria();
        $k->add('consultationStatus', "B");
        $voyantids = Model::factoryInstance('Voyant')->findAll($k, 'voyantId');
        foreach ($voyantids as $key1 => $values) {
            foreach ($values as $key2 => $value) {
                $voyantIdArr[] = $value;
            }
        }
        $this->set('voyantIdArr', json_encode($voyantIdArr));

        $g = new Criteria();
        $voyantlanguages = Model::factoryInstance('Language')->findAll($g);
        $this->set('voyantlanguages', $voyantlanguages);

        $cons = new Criteria();
        $allconsultations = Model::factoryInstance('Consultation')->findAll($cons);
        $this->set('allconsultations', $allconsultations);
        // die(print_r($allconsultations));



        $e = new Criteria();
        $expert = Model::factoryInstance('Voyant')->findAll($e);

        $expertGender = [];
         foreach ($expert as $item) {
             $expertGender[]= $item['gender'];
            }
           $expert=array_values(array_unique($expertGender));



    $this->set('expert', $expert);

         $d = new Criteria();
         if(empty($filteredArr)){
         	 $voyantSkills = Model::factoryInstance("Skill")->findAll($d);
        	 $this->set('voyantSkills', $voyantSkills);
         }

        $totalPages = ceil($this->voyant->getFoundRowsCount() / $itemsPerPage);

        $this->set('pageNavigation', array('baseLink'    => '/main/index/',
                                           'totalPages'  => $totalPages,
                                           'currentPage' => $page,
                                           'title'       => 'Your arrow text'));

        $this->set('statistic', array(
            'voyantCommentValidatedCount'  => $this->statistic->getVoyantCommentsCountWithStatus($this->userId, '1')
        ));

        $this->set("action",$this->action);
         //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);
    }




    public function getVoyantNextTimeSlot($voyantId){

        if(!empty($voyantId)){
         $c = new Criteria();
         //$c->add('consultationtypeId',$consultationType['id']);
         $c->add('voyantId', $voyantId);
         $VoyantDateSchedules = Model::factoryInstance("VoyantDateSchedule")->findAll($c);

         $dateArr = []; $record = [];
         foreach($VoyantDateSchedules as $key=> $dateSchedule){
            $record[$key]['id'] = $dateSchedule['id'];
            $record[$key]['schedule_date'] = $dateSchedule['schedule_date'];
            $c = new Criteria();
            $c->add('voyantdatescheduleId', $record[$key]['id'], 'IN');
            $voyantTimeslots = Model::factoryInstance("voyantTimeslot")->getArray($c, 'timeslots');
            $record[$key]['timeslots'] = array_values($voyantTimeslots);
         }

         $result = [];
         //Here We merge both consultation types(Audio, Webcam) for display on frontend expert section...
        foreach ($record as $current_key => $current_array) {
            foreach ($record as $search_key => $search_array) {
                if ($search_array['schedule_date'] == $current_array['schedule_date']) {
                  if ($search_key != $current_key) {
                    $result['schedule_date'][$search_array['schedule_date']] = array_merge($search_array['timeslots'],$current_array['timeslots']);
                  }
                }
            }
        }

        //echo "<pre>";print_r($result['schedule_date']);die;
        $currentDate = date('Y-m-d');
        //date_default_timezone_set('Europe/Paris');
        $time = date("H:i"); // time in India
        $nextTimeSlot='';
        if(isset($result['schedule_date']) && !empty($result['schedule_date'])){
            foreach($result['schedule_date'] as $date => $rest){
                if($date==$currentDate){
                     foreach($rest as $k => $res){
                        if(strtotime($res) > strtotime($time)){
                            $nextTimeSlot = $res;
                        }
                     }
                }
            }
        }
         return $nextTimeSlot;
        }
    }


}

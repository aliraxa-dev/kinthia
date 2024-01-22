<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserModel extends Model
{   
    protected $primaryKey = "userId";
    protected $relations = array('userQuestions'  => array('type'       => 'oneToMany',
                                                           'foreignKey' => 'userId'),

                                'userPackages'  => array('type'       => 'oneToMany',
                                                           'foreignKey' => 'userId'),

                                'userConsultations' => array('type'       => 'oneToMany',
                                                            'foreignKey' => 'userId'),
                                                           
                                 'voyantComments' => array('type'       => 'oneToMany',
                                                           'foreignKey' => 'userId'));
    
    function getUsersWithRole($role)
    {
        $c = new Criteria();
        $c->add("role", $role);
        return $this->findAll($c, "*", true);
    }
    
    function del(Criteria $c)
    {
        parent::del($c);
        Cacher::getInstance()->clean("tag", array("user"));
    }
    
    function insert($data)
    {
        parent::insert($data);
        Cacher::getInstance()->clean("tag", array("user")); 
    }
    
    function update($data, Criteria $c)
    {
        parent::update($data, $c);
        Cacher::getInstance()->clean("tag", array("user"));        
    }
    
    function attachPhotos(&$item, $options = array())
    {
        $photos = array();

        foreach ($this->photo->getItemPhotos($item->itemId) as $photo) {
            $path = "/uploads/photos/" . UploadedFile::fileNameToPath($photo['src']);
            $photoData = array("thumbSrc" => AppRouter::getResourceUrl($path . "s" . $photo['src']),
                               "photoId"  => $photo['photoId'],
                               "name"     => "");
             
             if (!empty($options['attachOriginalPhotos'])) {
                 $photoData['src'] = AppRouter::getResourceUrl($path . $photo['src']); 
             }              
                           
            $photos[] = $photoData;
        }
        
        $item->photos = $photos;
    }
    
    function getUserDetails($userId)
    {
        $c = new Criteria();
        $c->add("userId", $userId);
        $c->addWithRelation('userQuestions', array(
                                'fields'    => 'userQuestions.userId, userQuestions.questionId'
                                               . ',creationDate, userQuestions.status, userQuestions.orderId, userQuestions.voyantId',
                                'relations' => array(
                                        'voyantQuestion' => array(
                                            'fields' => 'title, price'
                                        ),
                                        'voyant' => array(
                                            'fields' => 'name'
                                        ),
                                        'order' => array(
                                            'fields' => 'payPalId, stripeData'
                                        )
                                    )
                                )
                           );
                                        
        $c->addWithRelation('voyantComments', array(
            'fields' => 'userId,voyantId, text, rating, remoteIp, date, validated, commentId, replyText'));

        $c->addWithRelation('userPackages', array(
                'fields' =>'userPackages.userId, userPackages.packageId, userPackages.creationDate, userPackages.status, userPackages.orderId',

                'relations' => array(
                    'package' => array(
                        'fields' => 'packageName, packageTime, packagePrice'
                        ),                   
                    'order' => array(
                        'fields' => 'payPalId, stripeData,orderId'
                        )
                    )
            
            ));

            $c->addWithRelation('userConsultations', array(
                'fields' => 'userConsultations.userconsultationId, userConsultations.userId, userConsultations.voyantId, userConsultations.type, userConsultations.status, userConsultations.duration, userConsultations.date, userConsultations.start_time, userConsultations.end_time, userConsultations.reason, userConsultations.payment_status, userConsultations.created_at',
            'relations' => array(
                                        'voyant' => array(
                                            'fields' => 'name'
                                        )
                                    )));

            return $this->find($c);
    }  
}

class UserRecord extends ModelRecord
{
    function save()
    {
        if (!empty($this->birthdayDate)) {
            $this->birthdayDate = date('Y-m-d', strtotime($this->birthdayDate));
        } else {
            $this->birthdayDate = null;
        }

        // var_dump($this->birthdayDate); die;
        parent::save();
    }

    function changePassword($new)
    {
        if (!$new) {
            return false;
        }
        $this->password = md5($new);
        $this->save();

        return true;
    }

    function generateNewPassword()
    {       
        $newPassword = substr(md5(rand()), 0, 10);
        $this->password = md5($newPassword);
        $this->save();
        return $newPassword;
    }
    
    function updatePhotos()
    {
        $c = new Criteria();
        $c->add("itemId", $this->userId);

        $imageSrc = "";
        $photosCount = Model::factoryInstance("photo")->getCount($c);

        if ($photosCount) {
            $c->addOrder("photoId");
            $c->setLimit(1);
            $imageSrc = Model::factoryInstance("photo")->get("src", $c);
        }

        $data = array("firstGalleryImageSrc" => $imageSrc,
                      "photosCount"          => $photosCount);

        Model::factoryInstance("user")->updateByPk($data, $this->userId);
        
        if ($this->role == "voyant") {
            $data = array('imageSrc' => $imageSrc);
            Model::factoryInstance("voyant")->updateByPk($data, $this->userId);        
        }
    }    
}

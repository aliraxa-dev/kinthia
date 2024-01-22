<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class UserQuestionModel extends Model
{   
    protected $primaryKey = 'questionId';
    
    protected $relations = array('user'           => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'userId'),
                                                           
                                 'voyant'         => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'voyantId'),
                                                           
                                 'voyantQuestion' => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'questionId',
                                                           'localKey'   => 'voyantQuestionId'),
                                                           
                                 'order'          => array('type'       => 'oneToOne',
                                                           'foreignKey' => 'orderId'));


    function getPending($c)
    {
        $items = array();
        
        if (empty($c)) {
            $c = new Criteria();
        }
        
        $c->add('status', 'pending');
        $c->addOrder('userQuestions.creationDate');
        $c->setCalcFoundRows(true);
        $c->addWithRelations(array('voyant'         => array('fields' => 'name'),
                                   'user'           => array('fields' => 'userId, email, name, phone'),
                                   'voyantQuestion' => array('fields' => 'title')));
        
        $items = $this->findAll($c, "userQuestions.questionId, creationDate");

        return $items;
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

   

    function getSummaryDetails($questionId)
    {
        $c = new Criteria();
        $c->add("userQuestions.questionId", $questionId);
        $c->addWithRelations(array('user' => array('fields' => 'userId, name, firstName, lastName, birthdayDate'),
                                   'voyantQuestion' => array('fields' => 'title')));
        
        return $this->find($c);
    }
    function getEarning($c)
    {
        $items = array();
        
        if (empty($c)) {
            $c = new Criteria();
        }
        
        $c->add('status', 'answered');
        $c->addOrder('userQuestions.creationDate');
        $c->setCalcFoundRows(true);
        $c->addWithRelations(array('voyant'         => array('fields' => 'name'),
                                   'user'           => array('fields' => 'userId, email, name, phone'),
                                   'voyantQuestion' => array('fields' => 'price')));
       
        $items = $this->findAll($c, "voyantquestions.price");
        // echo "<pre>";
        // print_r($items);
        // exit;

        if(is_array( $items)){
            foreach ($items as $key => $value) {
                $price[$key] = $value['price'];
            }
        }else{
            $price = [];
        }
        if(!isset($price)){
            $price = [];
        }
        return $price;
    }
}

class UserQuestionRecord extends ModelRecord
{
    public function save()
    {
        if($this->voyantQuestionId!=0){
         $voyantQuestion = Model::factoryInstance("voyantQuestion")->findByPk($this->voyantQuestionId);    
         $this->voyantId = $voyantQuestion->voyantId;
        } else 
        {
          $this->voyantId = 0;
        }
//        file_put_contents('/var/www/preprod/public_html/custom-log.log', json_encode($this->data) . PHP_EOL , FILE_APPEND);
//        file_put_contents('/var/www/preprod/public_html/custom-log.log', json_encode(debug_backtrace() ) . PHP_EOL , FILE_APPEND);
        //$this->voyantId = $voyantQuestion->voyantId; 
        parent::save();
    }

    public function update($fields, $c)
    {
        parent::update($fields, $c); // TODO: Change the autogenerated stub
    }
}

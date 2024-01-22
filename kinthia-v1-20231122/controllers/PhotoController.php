<?php

class PhotoController extends AppController
{
    public function deleteAction()
    {
        $this->viewClass = 'JsonView';
        $c = new Criteria();
        $c->add('photoId', $this->request->photoId);
        
        $photo = $this->photo->find($c);
        
        if (!empty($photo)) {
            $allow = ($this->session->get('role') == 'administrator');
            
            if (!$allow) {
                if($photo->itemId) {
                    $item = $this->user->findByPk($photo->itemId);
                    $allow = (!empty($item) && $item->userId == $this->userId);
                } else {
                    $allow = (!empty($this->request->tempId) && $this->request->tempId == $photo->tempId); 
                }
            }
            
            if ($allow) {
                $photo->del();
            }
        }
    }
    
    public function saveAction()
    {
        $savePath = CODE_ROOT_DIR.'/uploads/photos/';  
        
        $this->viewClass = 'JsonView';
        
        $photoType = 'gallery';        
        $galleryPhotosMaxCount = 10;
        $itemId = !empty($this->request->itemId) ? $this->request->itemId : 0;
        $tempId = !empty($this->request->tempId) ? $this->request->tempId : 0;
        
        if ($itemId) {
            $item = $this->user->findByPk($itemId);
            
            if (empty($item)
                || ($this->session->get('role') != 'administrator'
                    && $item->userId != $this->userId)
            ) {
                $this->return404();
            }
        }
        
        try {
            $uploadedFile = new UploadedFile('photo');
            $uploadedFile->addFilter('extension', array('jpg', 'jpeg', 'gif', 'png'));
            $uploadedFile->addFilter('maxSize', intval(Config::get('itemGalleryImageMaxWeight')) * 1024);
            
            $errorMessage = '';
            $wasUploaded = false;
            
            if (!$uploadedFile->wasUploaded()) {
                throw new Exception('Photo wasn\'t uploaded');
            }
            
            $uploadedFile->validate();
            $uploadedFile->setSavePath($savePath);
            $uploadedFile->setAutoCreateDirs(true);
            $uploadedFile->save();
            $savePath = $uploadedFile->getSavePath();

            $fileName = $uploadedFile->getSavedFileName();
            
            $imageResizer = new ImageResizer();
            
            if($photoType == 'gallery') {
                if ($this->photo->getSitePhotosCount($itemId, $tempId) >= $galleryPhotosMaxCount) {
                    throw new Exception('Maximum photo count ' . $galleryPhotosMaxCount . ' was reached');
                }
                
                $photo = new PhotoRecord();
                $photo->itemId = $itemId;
                
                if ($tempId) {
                    $photo->tempId = $tempId;
                }
                
                $imageResizer->resize($savePath.$fileName, $savePath.'m'.$fileName, Config::get('mediumThumbWidth'), Config::get('mediumThumbHeight'), true);
                $imageResizer->resize($savePath.$fileName, $savePath.'s'.$fileName, Config::get('smallThumbWidth'), Config::get('smallThumbHeight'), true);
                
                if (Config::get('imageWatermarkEnabled')) {
                    $imageResizer->addTag($savePath.$fileName, $savePath.$fileName);
                }
                
                $photo->src = $fileName;
                $photo->save();
            }
            
            $this->set('status', 'ok');
            $this->set('photo', array('thumbSrc' => Config::get('siteRootUrl')
                                                    . str_replace(CODE_ROOT_DIR, '', $savePath)
                                                    . 's' . $fileName,
                                      'photoId'  => $photo->photoId,
                                      'name'     => $uploadedFile->getOriginalName()));
        } catch(Exception $e) {
            $this->set('status', 'error');
            $this->set('errorMessage', $e->getMessage());
        }
    }
}

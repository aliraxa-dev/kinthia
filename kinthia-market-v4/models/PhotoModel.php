<?php

class PhotoModel extends Model
{   
    protected $primaryKey = "photoId";
    
    function getFields()
    {
        return $this->fields;
    }
    
    function getItemPhotos($itemId)
    {
        $c = new Criteria();
        $c->add("itemId", $itemId);
        $c->addOrder("photoId");
        
        return $this->photo->findAll($c, "photoId, src");
    }
    
    function getSitePhotosCount($itemId, $tempId = null)
    {
        $c = new Criteria();
                
        if ($tempId) {
            $c->add("tempId", $tempId);
        } else {
            $c->add("itemId", $itemId);
        }
        
        return $this->photo->getCount($c);
    }
    
    function deleteFileIfExists($filePath)
    {
        if (file_exists($filePath)) {
            unlink($filePath);
        } 
    }
    
    function deleteSitePhotoFiles($src)
    {
        if(empty($src))return;
        
        $dirPath = CODE_ROOT_DIR."uploads/photos/".UploadedFile::fileNameToPath($src);
        
        $this->deleteFileIfExists($dirPath."s".$src);
        $this->deleteFileIfExists($dirPath."m".$src);
        $this->deleteFileIfExists($dirPath.$src); 
    }
}

class PhotoRecord extends ModelRecord
{
    function deletePhotoFiles()
    {
        Model::factoryInstance("photo")->deleteSitePhotoFiles($this->src);   
    }
    
    function del($updateItemPhotos = true)
    {
        $this->deletePhotoFiles();
        parent::del();
                
        if ($updateItemPhotos && $this->itemId) {
            Model::factoryInstance("user")->findByPk($this->itemId)->updatePhotos();
        }
    }
    
    function save()
    {
        parent::save();
        
        if ($this->itemId) {
            Model::factoryInstance("user")->findByPk($this->itemId)->updatePhotos();
        } 
    }  
}

?>
<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class AdModel extends Model
{   
    protected $primaryKey = "adId";
            
    function setAdOnPage($data)
    {
        $c = new Criteria();
        $c->add("page", $data['page']);
        $c->add("place", $data['place']);
        
        if($data['adCriterionId'] == 0 && !in_array($data['place'], array("general", "predefine")))
        {
            $this->del($c);
        }
        else
        {
            $ad = $this->ad->find($c);
            
            if($ad)
            {
                $ad->adCriterionId = $data['adCriterionId'];
                $ad->save(); 
            }
            else
            {
                $ad = new AdRecord();
                $ad->fromArray($data);
                $ad->save();
            }
        }
        
        //if globall switch was set delete category specified settings
        if($data['place'] == "general"
        && preg_match("#^predefine(Category|Item)#", $data['page'], $match))
        {
            $pagePrefix = strtolower($match[1]); 
            $c = new Criteria();
            $c->add("page LIKE '$pagePrefix%'");
            
            $c2 = new Criteria(); 
            $c2->add("place", "general");
            $c2->addOr("place", "predefine");
            
            $c->add($c2);
            
            $this->del($c);
        }
    }
    
    function getAdsOnPage($page)
    {
        $c = new Criteria();
        $c->add("page", $page);
        $ads = array();
        
        foreach($this->findAll($c, "adCriterionId, place") as $ad)
        {            
            $ads[$ad['place']] = $ad['adCriterionId'];
        }
        
        $globalSwitchOn = false;
        
        //checking global switches
        if(preg_match("#^(item|category)#", $page, $match) && strpos($page, "Custom") === false)
        {
            $pagePrefix = $match[1];
            $c = new Criteria();
            $c->add("page", "predefine".ucfirst($pagePrefix));
            $c->add("place", "general");
            $c->add("adCriterionId", 1);
            
            if($this->getCount($c))
            {
                $globalSwitchOn = true;
            }
        }
        
        //checking predefine in item category
        if(substr_compare("item", $page, 0, 4) == 0 && strpos($page, "Custom") === false)
        {
            //only check ads on in category if item haven't on
            if(empty($ads['general']))
            {  
                $itemId = substr($page, 4);
                
                $item = Model::factoryInstance("item")->findByPk($itemId, "categoryId");
                
                $categoryPredefine = $this->isSiteAdsPredefinedInCategory($item->categoryId);
                
                if($categoryPredefine !== null)
                {
                    $globalSwitchOn = $categoryPredefine;
                }
            
                $customCategoryItemAds = $this->getCustomCategorySiteAds($item->categoryId);
                
                if(!empty($customCategoryItemAds['general']))
                {
                    foreach($customCategoryItemAds as $key => $value)
                    {
                        if(!isset($ads[$key]))$ads[$key] = $customCategoryItemAds[$key];
                    }
                }
            }
        }
        
        if(!isset($ads['general']))$ads['general'] = $globalSwitchOn ? 1 : 0;
        if(!isset($ads['predefine']))$ads['predefine'] = $globalSwitchOn ? 1 : 0;
        
        return $ads;
    }
    
    function getAllPredefinitions()
    {
        $c = new Criteria();
        $c->add("page", array("predefineCategory", "predefineItem"), "IN");
        
        $predefinitions = array();
        
        foreach($this->findAll($c) as $ad)
        {
            $key = strtolower(substr($ad['page'], 9));
            $predefinitions[$key][$ad['place']] = $ad['adCriterionId']; 
        }
        
        return $predefinitions;
        
    }
    
    function isSiteAdsPredefinedInCategory($categoryId)
    {
        $c = new Criteria();
        $c->add("page", "category".$categoryId);
        $c->add("place", "predefine");
        $ad = $this->find($c);
        
        if(empty($ad))return null;
        
        return ($ad->adCriterionId == "1");
    }
    
    function getCustomCategorySiteAds($categoryId)
    {
        $c = new Criteria();
        $c->add("page", "itemCustomCategory".$categoryId);
        $ads = array();
        
        foreach($this->findAll($c, "adCriterionId, place") as $ad)
        {
            $ads[$ad['place']] = $ad['adCriterionId'];
        }
        
        return $ads;
    }
}

class AdRecord extends ModelRecord
{
    
}

?>
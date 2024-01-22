(function($){

    $.fn.photoEditor = function(params){
    
            var options = {
            savePhotoUrl: AppRouter.getRewrittedUrl('/photo/save'),
            deletePhotoUrl: AppRouter.getRewrittedUrl('/photo/delete'),
            filesMaxCount: setting.itemGalleryImagesMaxCount
        };
        
        if (params.item) {
            if (params.item) {
                options['data'] = {
                    itemId: params.item.itemId
                };
            }
            
            if (params.item.photos) {
                options['photos'] = params.item.photos;
            }
            
            $("#itemForm").autoFill(params.item);
        }
        else {
            if (params.tempId) {
                options['data'] = {
                    tempId: params.tempId
                };
            }
        }
                                          
        $("#fileUploadPanel").fileUploader(options);
    }
    
})(jQuery);
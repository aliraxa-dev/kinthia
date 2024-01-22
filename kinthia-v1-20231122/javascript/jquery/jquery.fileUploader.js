(function($){

    $.fn.fileUploader = function(options){
        var that = {};
        that.options = {
            filesMaxCount: 10,
            savePhotoUrl: null,
            deletePhotoUrl: null
        };
        that.options = $.extend(that.options, options);
                                         
        var $this = $(this);
        
        that.init = function(){
            var added = false;
            
            $iframe = $('<iframe id="upFrame" name="upFrame" src="about:blank" height="30" frameborder="0" width="100%" scrolling="no" allowtransparency="true"></iframe>').on("load",function(){
            
                var $form = $('<form target="myFrame" enctype="multipart/form-data" action="' + that.options.savePhotoUrl + '" method="post" name="myUploadForm" id="myUploadForm" style="margin:0px; padding:0px;"></form>');
                
                if (that.options.data) {
                    for (var name in that.options.data) {
                        var value = that.options.data[name];
                        $form.append('<input type="hidden" name="' + name + '" value="' + value + '"/>');
                    }
                }
                
                var $vv = $('<div></div>').append($form.append($('<input id="myUploadFile" style="width:247px;border:1px solid #000000;font-family:Tahoma;line-height:1.8;margin:0;padding:0;color:#000000" type="file" value="" name="photo"/>'), $('<iframe id="myFrame" name="myFrame" src="about:blank" style="display:none"></iframe>')));
                
                $("#upFrame").contents().find("body").css("margin", 0).css("padding", 0).html($vv.html());
                
                var $upc = $("#upFrame").contents();
                
                $upc.find("#myUploadFile").on("change",function(){
                    $("#upFrame").contents().find("#myUploadForm").submit();
                    $("#upFrame").contents().find("#myUploadForm").each(function(){
                        this.reset()
                    });
                });
                  $upc.find("#myUploadForm").submit(function(){
                       var _ready = false;
                        $("#responseMessage").text("Uploading...").addClass("waiting").show();
                          $upc.find("#myFrame").on("load",function(){
                                if (_ready) { return; }
                                _ready = true;
                               var content = that.getFrameContent(this), data = content.body.innerHTML;
                                response = eval("(" + data + ")");
                                
                                $('#responseMessage').hide().removeClass('waiting');
                                
                                if (typeof response === 'undefined' || response.status == "error") {
                                    if (response === 'undefined') {
                                        var errorMessage = "Can't connect to server";
                                    }
                                    else {
                                        var errorMessage = response.errorMessage;
                                    }
                                    
                                    $('#responseMessage').fadeOut(1000, function(){
                                        $(this).html($("<span>" + errorMessage + "</span>").css("color", "#f00")).fadeIn(1000)
                                    });
                                }
                                else {
                                    that.addPhoto(response.photo);
                                }
                          });
                    });  
                
                
                
            });
            
            $this.append($('<div id="uploadedFilesStats" class="uploadedFilesStats"></div>'), $iframe, $('<div id="responseMessage"></div>'), $('<ul id="uploadedFiles"></ul>'));
            
            $('#myUploadFile').change(function(){
                $('#myUploadForm').submit();
                $('#myUploadForm').each(function(){
                    this.reset()
                });
                
            });
            
            $(".delete").livequery('click', function(){
                $(this).unbind('click');
                that.deletePhoto($(this));
            });
            
            that.updateCounter();
            if (options.photos) {
                for (var i in options.photos) {
                    that.addPhoto(options.photos[i]);
                }
            }                                  
        }
        
        that.addPhoto = function(photo){
            var photoImage = new Image();
                          
            $(photoImage).attr({
                src: photo.thumbSrc,
                width: 120,
                height: 90
            }).addClass('uploaded');
            
            $new = $('<div class="fileInfo"></div>');
            $delete = $('<div id="' + photo.photoId + '" class="delete" title="delete file"></div>');
            $name = $('<div class="fileName">' + photo.name + '</div>');
            
            $new.append($(photoImage), $name);
            $delete.data("photoId", photo.photoId);
            
            $("#uploadedFiles").append($('<li></li>').append($delete, $new).hide().fadeIn(1000));
            
            var responseMessage = _t("File") + " <span>" + photo.name + "</span> " + _t("was uploaded sucessfully");
            $('#responseMessage').fadeOut(100, function(){
                $(this).html(responseMessage).fadeIn(1000)
            });
            
            that.updateCounter();
        }
        
        that.onIframeLoad = function(){

            var content = that.getFrameContent(this), data = content.body.innerHTML;
            response = eval("(" + data + ")");
            
            $('#responseMessage').hide().removeClass('waiting');
            
            if (typeof response === 'undefined' || response.status == "error") {
                if (response === 'undefined') {
                    var errorMessage = "Can't connect to server";
                }
                else {
                    var errorMessage = response.errorMessage;
                }
                
                $('#responseMessage').fadeOut(1000, function(){
                    $(this).html($("<span>" + errorMessage + "</span>").css("color", "#f00")).fadeIn(1000)
                });
            }
            else {
                that.addPhoto(response.photo);
            }
        }
        
        that.deletePhoto = function(toDelete){
            var data = {
                photoId: toDelete.data("photoId")
            };
            
            if (that.options.data && that.options.data.tempId) {
                data.tempId = that.options.data.tempId;
            }
            
            $.post(that.options.deletePhotoUrl, data, function(response){
                toDelete.parents('li').fadeOut(500, function(){
                    $(this).remove();
                    that.updateCounter()
                });
            });
        }
        
        that.updateCounter = function(){
            var uploadedPhotosCount = $("#uploadedFiles").children('li').length;
            $("#uploadedFilesStats").text(uploadedPhotosCount + " " + _t("of") + " " + that.options.filesMaxCount + " " + _t("available photos uploaded"));
            $('#upFrame').css({
                opacity: (uploadedPhotosCount == that.options.filesMaxCount) ? 0 : 1
            });
        }
        
        that.getFrameContent = function(frameId){
            return (frameId.contentDocument) ? frameId.contentDocument : (frameId.contentWindow) ? frameId.contentWindow.document : window.frames[frameId].document;
        }
        
        return this.each(function(){
            that.init();
        });
    }
})(jQuery);

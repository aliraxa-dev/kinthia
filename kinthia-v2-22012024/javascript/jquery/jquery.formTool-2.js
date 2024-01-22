$(document).ready(function(){

    jQuery.alertDialog = function(message, callback){
        $("<div title='Validation message'><p style='text-align:center;font-size:1.2em'><br/><b>" + message + "</b></p></div>").dialog({
            autoOpen: true,
            modal: true,
            close: function(){
                $(this).remove();
            },
            buttons: {
                "Ok": function(){
                
                    $(this).dialog("close");
                    if (callback) 
                        callback();
                }
            }
        });
    }
    
    var parentSelector = "div[class^=grid-2-small-1 man mbs pan form]";
    
    jQuery.validator.setDefaults({
        errorElement: "i",
        errorClass: "text_error",
        
        highlight: function(element, errorClass){
            var $row = $(element).closest(parentSelector);
            
            if (!$row.hasClass("error")) {
                $row.addClass("error");
            }
        },
        unhighlight: function(element, errorClass){
            var $row = $(element).closest(parentSelector);
            if ($row.hasClass("error")) {
                $row.removeClass("error");
            }
        },
        errorPlacement: function(error, element){
            error.prependTo(element.closest(parentSelector));
        }
    });
    
    jQuery.extend(jQuery.validator.messages, {
        required: _t("This field is required")
    });
    
    var ajaxInProgress = 0;
    var progressDialog = $("<div title='" + _t("Loading") + "'>" +
        "<p style='text-align:center;font-size:1.6em'><br/>" +
        "<b>" + _t("Loading...") + "</b><br>" +
        "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
        "</div>")
        .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
    
    $().ajaxSend(function(r,s){  
       
       ajaxInProgress++;
       
       if(ajaxInProgress == 1)
       {
           progressDialog.dialog("open");
       }
         
    });  

    $().ajaxStop(function(r,s){
        ajaxInProgress = 0;
        progressDialog.dialog("close");
    });
    
});
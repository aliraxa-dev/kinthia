$(document).ready(function(){
    
    $.alertDialog = function(message, callback){
        $("<div title='Validation message'><p style='text-align:center;font-size:1.2em'><br/><b>" + message + "</b></p></div>").dialog({
            autoOpen: true,
            modal: true,
            
            buttons: {
                "Ok": function(){
                
                    $(this).dialog("close");
                    if (callback) 
                        callback();
                }
            }
        });
    }
    
    $.confirmDialog = function(message, callback){
        $("<div title='Validation message'><p style='text-align:center;font-size:1.2em'><br/><b>" + message + "</b></p></div>").dialog({
            autoOpen: true,
            modal: true,
            resizable: false,
            draggable: false,
            close: function(){
                $(this).remove();
            },
            buttons: {
            "Yes": function(){
                
                    $(this).dialog("close");
                    if (callback) 
                        callback();
                },
            "Cancel": function(){
                
                    $(this).dialog("close");
                }
            }
        });
    }
    
    $.confirmLinkClick = function(msg, url)
    {        
        $.confirmDialog(msg, function()
        {
            location.href = url;
        });
        
        return false;    
    };
    
    if (jQuery.validator) {
    
        var parentSelector = "tr";
        
        jQuery.validator.setDefaults({
            debug: true,
            errorElement: "label",
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
                error.prependTo(element.closest("td"));
            }
        });
        
    }
    
    $.fn.ajaxFormSubmitter = function(params){
        console.warn({params})
        var defaults = {
            submitHandler: function(form){
                alert('sumitted')
            
                if (tinyMCE) {
                    tinyMCE.triggerSave(true,true);
                }
                
                $(form).ajaxSubmit({
                    dataType: 'json',
                    success: function(response){
                        if (response.status == "error") {
                            $.alertDialog(response.message);
                        }
                        
                        if (response.status == "ok") {
                            $.alertDialog(response.message, function(){
                                if(response.redirectUrl)
                                {
                                    location.href = response.redirectUrl; 
                                }
                            });
                        }
                        
                    }
                })
            }
        };
        
        return $(this).each(function(){
        
            $(this).validate($.extend(defaults, params));
        });
    };
    
});

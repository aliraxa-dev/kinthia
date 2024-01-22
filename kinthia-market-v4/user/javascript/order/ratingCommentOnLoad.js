$(document).data("popupStart", function(popupWindow){
    $(".star", popupWindow).rating();
    
    $("#commentPopupForm", popupWindow).validate({
        rules: {
            text: "required",
            rating: "required",
            privateCode: "required"
        },
        messages: {
            privateCode: _t("Please enter captcha code"),
            pseudo: {
                required: _t("Please enter your name")
            }
        },
        errorPlacement: function(){
        
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                    if (response.status == "error") {
                        $.alertDialog(response.message);
                        $("a.linkGenerateNewCaptchaImg", $(form)).click();
                    }
                    
                    if (response.status == "ok") {
                        $.alertDialog(_t("Your comment was saved"), function(){
                            popupWindow.dialog("close");
                        });
                    }
                    
                }
            });
            return false;
        }
    });
    
    $("input.close", popupWindow).click(function(){
        popupWindow.dialog("close");
    });
});

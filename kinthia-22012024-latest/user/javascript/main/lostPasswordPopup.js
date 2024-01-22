$(document).data("popupStart", function(popupWindow){
    $("#lostPasswordPopupForm", popupWindow).validate({
        rules: {
            email: {
                required: true,
                email: true
            },
        },
        messages: {
            email: {
                required: _t("Please enter your email"),
                email: _t("Your email must be in format - name@domain.com")
            }
        },
        submitHandler: function(form){
            $.ajax({
                url: form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.status == "error") {
                        $.alertDialog(response.message);
                        $("a.linkGenerateNewCaptchaImg", form).click();
                    }

                    if (response.status == "ok") {
                        $.alertDialog(_t("New password was sent to your email"), function(){
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

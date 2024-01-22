$(document).data("popupStart", function(popupWindow){
    $("#changePasswordPopupForm", popupWindow).validate({
        rules: {
            currentPassword: {
                required: true
            },
            password: {
                required: true,
            },
            passwordRepeat: {
                required: true,
                equalTo : "#password"
            },
        },
        messages: {
			passwordRepeat: {
                required: _t("Please confirm your password"),
                equalTo: _t("Passwords aren't equal")
            },
			
            email: {
                required: _t("Input must be not empty"),
                email: _t("Your email must be in format - name@domain.com")
            }
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                    if (response.status == "ok") {
                        $.alertDialog(_t("New password changed"), function(){
                            popupWindow.dialog("close");
                        });
                    } else {
                        $.alertDialog(_t("Wrong password"));
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

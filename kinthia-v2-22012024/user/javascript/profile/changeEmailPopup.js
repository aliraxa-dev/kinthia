$(document).data("popupStart", function(popupWindow){
    $("#changeEmailPopupForm", popupWindow).validate({
        rules: {
            email: {
                required: true,
                email: true
            },
            currentPassword: {
                required: true
            },
            emailRepeat: {
				required: true,
                equalTo: "#email"
            }
        },
        messages: {
			currentPassword: _t("Please enter password"),
            email: {
                required: _t("Please enter your email"),
                email: _t("Your email must be in format - name@domain.com")
            },
			emailRepeat: {
                required: _t("Please confirm your email"),
                equalTo: _t("Emails aren't equal")
            }
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                    if (response.status == "ok") {
                        $.alertDialog(_t("New email changed"), function(){
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

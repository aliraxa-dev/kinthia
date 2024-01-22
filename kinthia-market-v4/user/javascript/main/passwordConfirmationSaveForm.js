$(function() {
    $("#passwordConfirmationSaveForm").validate({
        rules: {
            password: {
                required: true,
            },
            passwordRepeat: {
                required: true,
                equalTo: "#password"
            }
        },
        messages: {
            password: _t("Please enter password"),
			 passwordRepeat: {
                required: _t("Please confirm your password"),
                equalTo: _t("Passwords aren't equal")
            }
        },
        submitHandler: function(form){
            $.ajax({
                url: form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.status === "ok") {
                        $.alertDialog(_t("Your password changed", function(){
                            location.href = setting.returnUrl;
                        }));
                        setTimeout ( function(){
                            location.href = setting.returnUrl;
                        }, 4000 );
                    } else {
                        $.alertDialog(response.message, function(){
                            location.href = setting.returnUrl;
                        });
                    }
                }
            });
            return false;
        }
    });
    $(".dialog-titlebar-close", '.ui-button').click(function(){
        location.href = setting.returnUrl;
    });
});

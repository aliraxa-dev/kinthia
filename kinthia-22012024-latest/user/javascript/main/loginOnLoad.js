
$(document).ready(function(){
    $("#registerForm").validate({
        rules: {
            name: "required",
            privateCode: "required",
            password: "required",
            email: {
                required: true,
                email: true,
                remote: {
                    url: AppRouter.getRewrittedUrl("/user/register/isEmailAcceptable"),
                    type: "POST",
                    global: false
                }
            },
            emailConfirmation: {
                required: true,
                equalTo: "#registerForm input[name=email]"
            },
            passwordConfirmation: {
                required: true,
                equalTo: "#registerForm input[name=password]"
            }
        },
        messages: {
            name: _t("Please enter your pseudo"),
            privateCode: _t("Please enter captcha code"),
            password: _t("Please enter password"),
            email: {
                required: _t("Please enter your email"),
                email: _t("Your email must be in format - name@domain.com"),
                remote: _t("Email was used earlier")
            },
            emailConfirmation: {
                required: _t("Please confirm your email"),
                equalTo: _t("Emails aren't equal")
            },
            passwordConfirmation: {
                required: _t("Please confirm your password"),
                equalTo: _t("Passwords aren't equal")
            }
        },
        errorElement: 'span',
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            element.closest('.input-group').append(error);
        },
        highlight: function (element, errorClass, validClass) {
          $(element).addClass('is-invalid');
        },
        unhighlight: function (element, errorClass, validClass) {
          $(element).removeClass('is-invalid');
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
                        $.alertDialog(response.message, function(){
                            $("#registerLayer").slideUp("slow");
                            $("#loginForm input[name=email]").focus();
                        });
                    }
                    
                }
            });
            return false;
        }
    });
    
    $("#loginForm").validate({
        rules: {
             email: {
                required: true,
                email: true
			},
            password: "required"
        },
        messages: {
            email: {
                required: _t("Please enter your email"),
                email: _t("Your email must be in format - name@domain.com")
			},
            password: _t("Please enter password")
        },
        errorElement: 'span',
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            element.closest('.input-group').append(error);
        },
        highlight: function (element, errorClass, validClass) {
          $(element).addClass('is-invalid');
        },
        unhighlight: function (element, errorClass, validClass) {
          $(element).removeClass('is-invalid');
        }
    });
    
    $(".captchaCode").livequery(function()
    {
        $(this).captchaCode();
    });

    $("#lostPasswordLink").click(function()
    {

        var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
        progress.dialog("open");

        $.popup.open(
            this.href,
            this.title,
        );
        setTimeout ( function(){
            progress.dialog("close");
        }, 800 );

        return false;
    });
    
});

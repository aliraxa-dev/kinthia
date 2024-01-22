$(document).ready(function(){
    $("#lostPasswordPopupForm").validate({
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
                        $.alertDialog(_t("Un email vient de vous être envoyé.<br>Il contient un lien pour réinitialiser votre mot de passe."));
                    }
                }
            });
            return false;
        }
    });
});
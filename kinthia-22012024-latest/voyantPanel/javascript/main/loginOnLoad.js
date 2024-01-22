$(document).ready(function(){
    $("#loginForm").validate({
        rules: {
            email: {
                required: true,
                email: true
			},
            password: {
                required: true,
                //minlength: 5
            },
        },
        messages: {
            email: {
                required: _t("Please enter your email"),
                email: _t("Your email must be in format - name@domain.com")
			},
            password: { 
                required: _t("Please enter password"),
                //minlength: _t("Votre mot de passe doit comporter au moins 5 caractères")
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
    }
    });
});
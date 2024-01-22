$(document).ready(function(){

    $.validator.addMethod(
        "dateITA",
        function(value, element) {
            var check = false;
            var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/
            if( re.test(value)){
                var adata = value.split('/');
                var gg = parseInt(adata[0],10);
                var mm = parseInt(adata[1],10);
                var aaaa = parseInt(adata[2],10);
                var xdata = new Date(aaaa,mm-1,gg);
                if ( ( xdata.getFullYear() == aaaa ) && ( xdata.getMonth () == mm - 1 ) && ( xdata.getDate() == gg ) )
                    check = true;
                else
                    check = false;
            } else
                check = false;
            return this.optional(element) || check;
        },
        "Please enter a correct date"
    );

    $("#personalInformationsForm").autoFill(setting.user);
    $.validator.setDefaults({
        errorElement: "i",
        errorClass: "text_error"
    });
    $("#personalInformationsForm").validate({
        rules: {
            birthdayDate: {
                dateITA: true
            }
        },
        messages: {
            birthdayDate: {
                dateITA: _t("Please enter a correct date, needed format is dd/mm/YYYY")
            }
        },
        errorPlacement: function(error, element) {
            error.appendTo('#errordiv');
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                    switch (response.status) {
                        case "error":
                            $.alertDialog(response.message);
                            break;
                            
                        case "ok":
                            $.alertDialog(_t("Your changes were saved"), function(){
                                location.href = setting.returnUrl;
                            });
                    }
                }
            });
            return false;
        }
    });

    $(".change-password-link").click(function(){
        $.popup.open(
            this.href,
            _t("Change password"),
            {width: 800}
            );
        return false;
    });

    $(".change-email-link").click(function(){
        $.popup.open(
            this.href,
            _t("Change email"),
            {width: 800}
            );
        return false;
    });
    
});

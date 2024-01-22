$(document).ready(function(){
    $("#refundForm").validate({
        rules: {
            text: {
                required: true,
            },
            orderId: {
                required: true
            }
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                    if (response.status == "ok") {
                        $.alertDialog(_t("Refund request sended"), function(){
                                location.href = AppRouter.getRewrittedUrl('/user/management');
                            });
                    } else {
                        $.alertDialog(_t("Wrong password"));
                    }
                }
            });
            return false;
        }
    });
});

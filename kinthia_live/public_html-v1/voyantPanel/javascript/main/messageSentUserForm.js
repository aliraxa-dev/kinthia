$(document).ready(function(){
    $("#sendMessageToUser").validate({
        rules: {
            send_message: "required"
        },
        messages: {
            send_message: _t("Please enter your Taper un message")
        },
        submitHandler: function(form){
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function(response){
                   alert(response);      
                }
            });
            return false;
        }
    });    
});

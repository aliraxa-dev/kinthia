$(document).ready(function() {
    document.getElementById('ok').onclick = function() {
        var voyantQuestionInvoice = [];
        var markedCheckbox = document.querySelectorAll('input[type="checkbox"]:checked');
        for (var checkbox of markedCheckbox) {
            voyantQuestionInvoice.push(checkbox.value);
        }
        $("#orderIds").val(voyantQuestionInvoice.join(", "));

        if (voyantQuestionInvoice.length === 0) {
            alert("Please Check atleast one value");
        }else{
            //$("#orderInvoiceFrm").submit();
            var form = document.getElementById('orderInvoiceFrm');
            $.ajax({
                url: form.action,
                type: form.method,
                data: $(form).serialize(),
                //dataType: 'json',
                success: function(response) {
                    console.warn(">>>>Hello", response.status);
                    // thankYouPopup.dialog("close");
                    // // console.log(response);
                    // if (response.status == "error") {
                    //     var stripeErrorPopup = $("<div title='" + _t("Loading") + "'>" +
                    //         "<p style='text-align:center;font-size:1.6em'><br/>" +
                    //         "<b>" + _t(response.message) + "</b>" +
                    //         "</div>")
                    //         .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                    //     stripeErrorPopup.dialog("open");
                    // }
                    if (response.status == "success") {
                        alert('hello');
                        //window.location.replace(response.redirectUrl);
                    }
                }
            });
        }
    }
});

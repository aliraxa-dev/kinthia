$(document).ready(function(){
	var username = $("input[name$='sessUserName']").val();
    if(username != ""){
    	var form = document.getElementById('getCreditTimeForm');
    	 $.ajax({
            url: form.action,
            type: form.method,
            data: $(form).serialize(),
            dataType: 'json',
            success: function(response) {                 
            	$("#myTime").html(response.time);
            }
        });
    }

    if (typeof $(document).photoEditor !== "undefined") { 
        $(document).photoEditor({item:setting.item});
    }
});

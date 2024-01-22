$(document).ready(function(){
    
    var $form = $("#editPackageForm");
    if (setting.package) {
        $form.autoFill(setting.package);
    }; 
    	
    $("#packageDisplay").change(function(){
	    if($(this).prop("checked") == true){
	      $("#packageDisplay").val(1);
	    }else{		    	
	      $("#packageDisplay").val(0);
	    }
	});

	$("#packagePromo").change(function(){
	    if($(this).prop("checked") == true){
	      $("#packagePromo").val(1);
	    }else{		    	
	      $("#packagePromo").val(0);
	    }
	});
 
});


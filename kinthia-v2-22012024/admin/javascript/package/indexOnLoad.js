$(document).ready(function(){
    
    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    });

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
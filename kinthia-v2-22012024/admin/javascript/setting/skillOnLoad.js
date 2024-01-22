$(document).ready(function(){
	
    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    });

    $("#createPage").change(function(){
      if($(this).prop("checked") == true){
        $("#createPage").val(1);
      }else{          
        $("#createPage").val(0);
      }
  });

});
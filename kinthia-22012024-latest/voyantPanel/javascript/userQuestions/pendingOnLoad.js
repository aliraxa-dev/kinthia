$(document).ready(function(){

	$("#checkAll").change(function () {
	    $("input[name^=questionIds]").prop('checked', $(this).prop("checked"));
	});
});
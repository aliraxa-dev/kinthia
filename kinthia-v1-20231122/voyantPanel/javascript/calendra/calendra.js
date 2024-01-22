$(document).ready(function(){

	$("#checkAll").change(function () {
	    $("input[name^=consultaion_ids]").prop('checked', $(this).prop("checked"));
	});
});


$(document).ready(function(){

	$("#checkAll1").change(function () {
	    $("input[name^=consultaion_type]").prop('checked', $(this).prop("checked"));
	});
});
$(document).ready(function(){

	$("#checkAll").change(function () {
	    $("input[name^=consultaion_ids]").prop('checked', $(this).prop("checked"));
	});
});
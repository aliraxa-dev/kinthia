$(document).ready(function(){
    
    $("#selectAllButton").click(function(){
        $("input[name^=orderIds]").attr("checked", true);
    });
});

$(document).ready(function(){
    
    $("#selectAllButton").click(function(){
        $("input[name^=questionIds]").attr("checked", true);
    });
});

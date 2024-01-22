$(document).ready(function(){
    var $form = $("#editVoyantFormnew");
    if (setting.voyant) {
        $form.autoFill(setting.voyant);
    }
    // $form.ajaxFormSubmitter();
    
    var params = {};
    
    if (setting.voyant) {
        var item = setting.voyant;
        item.itemId = item.voyantId;
        params.item = item;
    } else {
        params.tempId = setting.tempId;
    }

    $("#voyantQuestionsTable").tableDnD({
        onDragClass: "rowDrag",
        onChange: function(table){
            $("tbody tr", table).each(function(index){
                $(this).addClass("line" + ((index % 2) ? "2" : "1"));
                $(this).removeClass("line" + ((index % 2) ? "1" : "2"));
            });
        },
        onDrop: function(table, row){
        
            var data = js2php({
                positions: $.tableDnD.getRowsPositions()
            });
            
            $.post(AppRouter.getRewrittedUrl("/admin/voyantQuestion/savePositions"), data, function(){
            
            });
        }
    });

    $('[data-toggle="tooltip"]').tooltip();
    
    $(document).photoEditor(params);
    
    var commentEditor = new CommentEditor();
     
});

function removeAudio(){
    $("#edit-audio").hide();
    $("#removeAudioButton").hide();
    $("#audioFileExist").show();
    $("#edit-audio").append("<input type='hidden' name='audioSrcDel' value='del' />");
}
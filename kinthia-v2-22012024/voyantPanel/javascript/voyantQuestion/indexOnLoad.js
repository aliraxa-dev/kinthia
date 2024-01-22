$(document).ready(function(){

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
            
            $.post(AppRouter.getRewrittedUrl("/voyantPanel/voyantQuestion/savePositions"), data, function(){
            
            });
        }
    });

    $('[data-toggle="tooltip"]').tooltip();
     
});
(function($){
	
    $.popup = {};
    $.popup.open = function(url, title){
        $.ajaxSetup({
            cache: true
        });
        
        var $content = $("<div style='block'></div>").load(url, function(){
            $.ajaxSetup({
                cache: null
            });
            
            $content.dialog({
                modal: true,
                height: "auto",
                width: "600",
                resizable: false,
                draggable: false,
                title: title,
                bgiframe: true,
                close: function(event, ui){
                    $(this).remove();
                    window.location.reload();
                }
            });
            
            var popupStart = $(document).data("popupStart");
            if (popupStart) {
                $(document).data("popupStart", null);
                popupStart($content);
            }
            
        });
        
    }
    
})(jQuery);

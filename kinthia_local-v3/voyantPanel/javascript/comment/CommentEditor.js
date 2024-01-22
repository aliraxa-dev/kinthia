
CommentEditor = function(){

    $("tr[id^=commentForm]").each(function(){
        var $tr = $(this);
        
        $("a[rel]", $tr).each(function(){
        
            var $link = $(this);
            var execute = $link.attr("rel");
            switch (execute) {
                case "save":
                    
                    func = function(event){
                       
                        $.post(AppRouter.getRewrittedUrl("/voyantPanel/comment/save"), {
                            "commentId": $("[name=commentId]", $tr).val(),
                            "text": $("[name=text]", $tr).val(),
                            "replyText": $("[name=replyText]", $tr).val(),
                        }, function(){
                            $.alertDialog(_t("The comment was saved."));
                        });
                        return false;
                    }
                    
                    break;
                    
                case "delete":
                    
                    func = function(event){
                    
                        $.confirmDialog(_t("Do you really want to delete it?"), function(){
                            $tr.hide();
                            $.post(AppRouter.getRewrittedUrl("/voyantPanel/comment/delete"), {
                                "commentId": $("[name=commentId]", $tr).val()
                            }, function(){
                                $.alertDialog(_t("The comment was deleted."));
                            });
                        });
                        
                        return false;
                        
                    }
                    
                    break;
                    
                case "reply":
                    
                    func = function(event){
                        $tr.find("div").show().focus();
                        return false;
                    }
                    
                    break;                     
                    
                default:
                    
                    func = null;
            }
            
            if (func) {
                $link.click(func);
            }
            
        });
        
    });
};

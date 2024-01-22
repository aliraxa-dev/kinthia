CommentEditor = function(){
    $("tr[id^=commentForm]").each(function(){
        var $tr = $(this);
        
        $("a[rel]", $tr).each(function(){
        
            var $link = $(this);
            var execute = $link.attr("rel");

            switch (execute) {
                case "save":        
                    func = function(event){
                    
                        $.post(AppRouter.getRewrittedUrl("/admin/comment/save"), {
                            "commentId": $("[name=commentId]", $tr).val(),
                            "rating": $("[name=rating]", $tr).val(),
                            "date": $("[name=date]", $tr).val(),
                            "text": $("[name=text]", $tr).val(),
                        }, function(){
                            $.alertDialog(_t("The comment was saved."));
                        });
                        return false;
                    }
                    break;
                case "update":        
                    func = function(event){
                        $.post(AppRouter.getRewrittedUrl("/admin/comment/update"), {
                            "commentId": $("[name=commentId]", $tr).val(),
                            "rating": $("[name=rating]", $tr).val(),
                            "text": $("[name=text]", $tr).val(),
                        }, function(){
                            $.alertDialog(_t("The comment was update."));
                        });
                        return false;
                    }
                    break;
                case "publish":        
                    func = function(event){
                            $tr.hide();
                            $.post(AppRouter.getRewrittedUrl("/admin/comment/publish"), {
                                "commentId": $("[name=commentId]", $tr).val()
                            }, function(){
                                $.alertDialog(_t("The comment was published."));
                            });
                        return false;
                    }  
                    break;
                case "edit-publish":        
                    func = function(event){
                           console.log("edti publish>>",event.target.getAttribute("rel"));

                           $.post(AppRouter.getRewrittedUrl("/admin/comment/publish"), {
                                "commentId": $("[name=commentId]", $tr).val()
                            }, function(){
                                $.alertDialog(_t("The comment was published."));
                                $tr[0].children[5].innerHTML='<span class="color-28a745">Oui</span>';
                                event.target.innerHTML = 'Unpublish';
                                event.target.setAttribute("rel","unpublish");
                                event.target.setAttribute("class","color-dc3545");
                                event.target.setAttribute("title","Unpublish");
                           });
                        return false;
                    }  
                    break; 
                case "unpublish":        
                    func = function(event){
                            console.log("unpublish>>",event.target.getAttribute("rel"));
                            $.post(AppRouter.getRewrittedUrl("/admin/comment/unpublish"), {
                                "commentId": $("[name=commentId]", $tr).val()
                            }, function(){
                                $.alertDialog(_t("The comment was unpublished."));
                                $tr[0].children[5].innerHTML='<span class="color-dc3545">Non</span>';
                                event.target.innerHTML = 'Publish';
                                event.target.setAttribute("rel","edit-publish");
                                event.target.setAttribute("class","color-28a745");
                                event.target.setAttribute("title","Publish");
                            });
                        return false;
                    }  
                    break;       
                case "delete":
                    
                    func = function(event){
                    
                        $.confirmDialog(_t("Do you really want to delete it?"), function(){
                            $tr.hide();
                            $.post(AppRouter.getRewrittedUrl("/admin/comment/delete"), {
                                "commentId": $("[name=commentId]", $tr).val()
                            }, function(){
                                $.alertDialog(_t("The comment was deleted."));
                            });
                        });
                        
                        return false;
                        
                    }
                    
                    break;
                    
                case "banIp":
                    
                    func = function(event){
                        $.post(AppRouter.getRewrittedUrl("/admin/comment/banIp"), {
                            "remoteIp": $("[name=remoteIp]", $tr).val()
                        }, function(){
                            $.alertDialog(_t("The IP was banned."));
                        });
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
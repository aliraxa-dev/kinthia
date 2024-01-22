$(document).ready(function(){

    $("#userEditForm").autoFill(setting.user);
    
    var commentEditor = new CommentEditor();
    $(document).photoEditor({item: setting.user}); 

});

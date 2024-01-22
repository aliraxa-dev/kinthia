$(document).ready(function(){
    
    $("textarea.tinyMce").each(function() {
        tinyMCE.execCommand('mceAddControl', false, this);
    });
});
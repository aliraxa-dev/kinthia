$(document).ready(function(){
    
    var $form = $("#editLanguageForm");
    if (setting.language) {
        $form.autoFill(setting.language);
    };
     
});
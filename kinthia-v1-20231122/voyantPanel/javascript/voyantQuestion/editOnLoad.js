$(document).ready(function(){
    
    var $form = $("#editVoyantQuestionForm");
    if (setting.voyantQuestion) {
        $form.autoFill(setting.voyantQuestion);
    };

    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    });
});
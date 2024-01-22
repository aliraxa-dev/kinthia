$(document).ready(function(){
 
    var $form = $("#editSkillForm");
    console.warn({'setting':setting.skill})
    if (setting.skill) {
        $form.autoFill(setting.skill);
    };
     
});
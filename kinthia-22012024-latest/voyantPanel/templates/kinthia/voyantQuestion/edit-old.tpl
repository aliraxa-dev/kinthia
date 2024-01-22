{capture assign="headData"}
<link href="{'/javascript/jquery/theme/ui.all.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tiny_mce.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/basic_config.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/voyantQuestion/editOnLoad.js'|resurl}"></script>
<script type="text/javascript">
setting.voyantQuestion = {$voyantQuestionJson|htmlspecialchars_decode};
</script>
{/capture}

{include file='includes/header.tpl' page="user" title="{'Edit_Edit_question'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle">
<div class="column">

{include file='voyantQuestion/crudForm.tpl'}

{include file='includes/footer.tpl'}
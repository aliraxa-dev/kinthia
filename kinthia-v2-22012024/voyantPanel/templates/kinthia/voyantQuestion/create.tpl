{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/voyantQuestion/editOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="user" title="{'Créer question / service - Panel expert - Kinthia'|lang}"}

{include file='voyantQuestion/crudForm.tpl'}

{include file="includes/footer.tpl"}
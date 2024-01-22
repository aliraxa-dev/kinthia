{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/setting/skillOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Skill list - {'Admin - Kinthia'|lang}"}

{include file='skill/crudForm.tpl'}
<!-- Content Wrapper. Contains page content -->

<!-- /.content-wrapper -->

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}
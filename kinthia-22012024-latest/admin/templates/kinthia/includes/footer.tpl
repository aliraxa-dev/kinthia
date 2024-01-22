  <!-- Main Footer -->
  <footer class="main-footer">
    Copyright &copy; 2006 - <?php echo date('Y');?> Kinthia.com - Tous droits réservés.
    <div class="float-right d-none d-sm-inline-block">
    {display_time}
    </div>
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<!-- jQuery -->

<script
  src="{'/voyantPanel/templates/kinthia/plugins/jquery/jquery.min.js'|resurl}"></script>
<!-- Bootstrap 4 -->
<script src="{'/voyantPanel/templates/kinthia/plugins/bootstrap/js/bootstrap.bundle.min.js'|resurl}"></script>
<!-- AdminLTE App -->
<script src="{'/voyantPanel/templates/kinthia/dist/js/adminlte.min.js'|resurl}"></script>
<!-- AdminLTE for demo purposes -->
<script src="{'/voyantPanel/templates/kinthia/dist/js/demo.js'|resurl}"></script>
{if isset($footerData)}
{$footerData}{/if}
</body>
</html>
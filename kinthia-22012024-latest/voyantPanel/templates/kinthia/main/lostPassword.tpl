<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reinitialisation du mot de passe - Espace experts - Kinthia</title>
  <meta name="robots" content="noindex, nofollow" />
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/fontawesome-free/css/all.min.css'|resurl}">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/icheck-bootstrap/icheck-bootstrap.min.css'|resurl}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/dist/css/adminlte.min.css'|resurl}">
  <link rel="stylesheet" href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}">
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/css/custom.css'|resurl}">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <p class="h1"><b>Kinthia</b></p>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Vous avez oublié votre mot de passe? Ici vous pouvez faire la demande pour réinitialiser votre mot de passe.</p>
      <form action="{'/voyantPanel/main/lostPassword'|url}" method="post" id="lostPasswordPopupForm">
        <div class="input-group mb-3">
          <input type="email" class="form-control" name="email" value="" placeholder="Email">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        {if $setting.captchaInContactFormEnabled}
        <div class="input-group mb-3">
          <div class="input-group-append">
            <div class="infos captchaCode"></div>
          </div>
        </div>
        {/if}
        <div class="row">
          <div class="col-12">
            <button type="submit" class="btn btn-primary btn-block">Envoyer</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      <p class="mt-3 mb-1">
        <a href="{'/voyantPanel/main'|url}">Connexion</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="{'/voyantPanel/templates/kinthia/plugins/jquery/jquery.min.js'|resurl}"></script>
<!-- Bootstrap 4 -->
<script src="{'/voyantPanel/templates/kinthia/plugins/bootstrap/js/bootstrap.bundle.min.js'|resurl}"></script>
<!-- AdminLTE App -->
<script src="{'/voyantPanel/templates/kinthia/dist/js/adminlte.min.js'|resurl}"></script>
{* Kinthia js *}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.captchaCode.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/main/lostPasswordPopup.js'|resurl}"></script>
</body>
</html>

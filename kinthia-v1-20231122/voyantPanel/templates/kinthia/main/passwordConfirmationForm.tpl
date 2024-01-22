<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Changement de mot de passe- Panel Experts - Kinthia</title>
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
      <p class="login-box-msg">Vous allez procéder au changement de votre mot de passe.
      Si vous ne parvenez pas à changer votre mot de passe, vous pouvez nous contacter par <a href="https://www.kinthia.com/navigation/contact.php">email</a>.</p>
      <form action="{'/voyantPanel/main/passwordConfirmationSave'|url}" method="post" id="passwordConfirmationSaveForm">
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" value="" id="password" placeholder="Mot de passe">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="passwordRepeat" id="passwordRepeat" value="" placeholder="Répéter votre mot de passe">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <input type="hidden" name="hash" value="{$hash}">
            <button type="submit" class="btn btn-primary btn-block">Changer le mot de passe</button>
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
<script type="text/javascript" src="{'/voyantPanel/javascript/main/passwordConfirmationSaveForm.js'|resurl}"></script>
</body>
</html>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Espace experts - Kinthia</title>
  <meta name="robots" content="noindex, nofollow" />
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/fontawesome-free/css/all.min.css'|resurl}">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/icheck-bootstrap/icheck-bootstrap.min.css'|resurl}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/dist/css/adminlte.min.css'|resurl}">
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/css/custom.css'|resurl}">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <p class="h1"><b>Kinthia</b></p>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Panel des experts</p>
      {if !empty($loginError)}
      <p class="alert alert-danger alert-dismissible"> email / mot de passe invalide</p>
      {/if}
      <form id="loginForm" method="post" action="{'/voyantPanel/main/logIn'|url}">
        <div class="input-group mb-3">
          <input type="email" class="form-control" placeholder="Email" name="email" id="login">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" placeholder="Mot de passe" name="password">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-6">
            {* Pas de remember
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Remember Me
              </label>
            </div>
            Pas de remember *}
          </div>
          <!-- /.col -->
          <div class="col-6">
            <button type="submit" class="btn btn-primary btn-block">Connexion</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
       {* Start - Connexion facebook & google - pas utile 
      <div class="social-auth-links text-center mt-2 mb-3">
        <a href="#" class="btn btn-block btn-primary">
          <i class="fab fa-facebook mr-2"></i> Sign in using Facebook
        </a>
        <a href="#" class="btn btn-block btn-danger">
          <i class="fab fa-google-plus mr-2"></i> Sign in using Google+
        </a>
      </div>
      <!-- /.social-auth-links -->
        END - Connexion facebook & google - pas utile *} 
      <p class="mb-1 mt-3">
        <a href="{'/voyantPanel/main/lostPassword'|url}" id="lostPasswordLink">Demander la réinitialisation du mot de passe</a>
      </p>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
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
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/main/loginOnLoad.js'|resurl}"></script>
</body>
</html>

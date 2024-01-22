<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
<!-- Left navbar links -->
<ul class="navbar-nav">
  <li class="nav-item">
    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
  </li>
</ul>

<!-- Right navbar links -->
<ul class="navbar-nav ml-auto">
  <!-- Navbar Dropdown Menu online -->
  <li class="nav-item dropdown">
    <div id="request_notification" class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
      {* <a href="{'/voyantPanel/userMessage'|url}" class="dropdown-item">
       A user Request For Webcam consultaion
      </a> *}
    </div>
  </li>
  <!-- Messages Dropdown Menu -->
  <li class="nav-item dropdown">
    <a class="nav-link" data-toggle="dropdown" href="#">
      <span class="navbar-badge-icon"><i class="far fa-comments"></i></span>
      <span class="badge badge-danger navbar-badge">{$statistic.pendingQuestionsCount}</span>
    </a>
   	<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
      <span class="dropdown-item dropdown-header">Questions en attente</span>
      <div class="dropdown-divider"></div>
      <a href="{'/voyantPanel/userQuestion/pending'|url}" class="dropdown-item">
        <i class="fas fa-envelope mr-2"></i> {$statistic.pendingQuestionsCount} questions à traiter
      </a>
    </div>
  </li>
  <!-- Notifications Dropdown Menu -->
  <li class="nav-item dropdown">
    <a class="nav-link" data-toggle="dropdown" href="#">
      <span class="navbar-badge-icon"><i class="far fa-bell"></i></span>
      <span class="badge badge-warning navbar-badge">{$statistic.voyantPendingMessageCount}</span>
    </a>
    {if $statistic.voyantPendingMessageCount>0}
    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
      <span class="dropdown-item dropdown-header">Notifications</span>
      <div class="dropdown-divider"></div>
      <a href="{'/voyantPanel/userMessage'|url}" class="dropdown-item">
        <i class="fas fa-envelope mr-2"></i> {$statistic.voyantPendingMessageCount} nouveaux messages
      </a>
    </div>
    {/if}
  </li>
  <li class="nav-item">
    <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
      <i class="fas fa-th-large"></i>
    </a>
  </li>
</ul>
</nav>
<!-- /.navbar -->
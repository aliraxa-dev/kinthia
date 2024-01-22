  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="{'/voyantPanel/main'|url}" class="brand-link">
      <img src="{'/voyantPanel/templates/kinthia/images/kinthia-logo-small-white-2.png'|resurl}" alt="Panel Expert - Kinthia" class="brand-image-kin" style="opacity: .8">
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" class="elevation-2" alt="User Image">
        </div>
        <div class="info color-c2c7d0">
          {$voyant.name}<br>
          <strong class="text-white">Status</strong> - 
          {if $voyant.available == 1 && $voyant.consultationStatus == 'ON' && $voyant.available != ''}
          <strong class="text-success">available</strong>
          {elseif $voyant.consultationStatus == 'B' || $voyant.consultationStatus == 'P'} 
          <strong class="text-warning">in consultation</strong>
          {else if $voyant.available == null || $voyant.available == 0} 
          <strong style="text-danger">on vacation</strong>
          {/if}
          <br>
          <a href="{'/voyantPanel/main/logOut'|url}"><i class="fas fa-sign-out-alt"></i> Se déconnecter</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-header">PANEL EXPERT - TABLEAU DE BORD</li>
          <li class="nav-item">
            <a href="{'/voyantPanel/main'|url}" class="nav-link">
              <i class="nav-icon fas fa-book"></i>
              <p>
                Accueil
              </p>
            </a>
          </li>

          <li class="nav-header">Consultation</li>
          <li class="nav-item">
            <a href="{'/voyantPanel/consultation/consultation'|url}" class="nav-link text-danger">
              <i class="nav-icon fas fa-book"></i>
              <p>
                Consultation
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/consultation/consultationQ'|url}" class="nav-link text-danger">
              <i class="nav-icon fas fa-book"></i>
              <p>
                Consultation question
              </p>
            </a>
          </li>
          <li class="nav-header">QUESTIONS & MESSAGES</li>
          <li class="nav-item">
            <a href="{'/voyantPanel/userQuestion/pending'|url}" class="nav-link">
              <i class="nav-icon far fa-envelope"></i>
              <p>
                Questions à traiter
                <span class="badge badge-danger right">{$statistic.pendingQuestionsCount}</span>
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/userMessage/'|url}" class="nav-link">
              <i class="nav-icon far fa-envelope"></i>
              <p>
                Messages privés
                <span class="badge badge-warning right">{$statistic.voyantPendingMessageCount}</span>
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantQuestion'|url}" class="nav-link">
              <i class="nav-icon fas fa-list"></i>
              <p>
                Liste des questions
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantQuestion/create'|url}" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>
                Créer une question
              </p>
            </a>
          </li>
          <li class="nav-header">Utilisateurs</li>
          <li class="nav-item">
            <a href="{'/voyantPanel/user/'|url}" class="nav-link">
              <i class="nav-icon fas fa-list"></i>
              <p>
                Liste des utilisateurs
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/userReview/'|url}" class="nav-link">
              <i class="nav-icon fas fa-star"></i>
              <p>
                Avis & notes
              </p>
            </a>
          </li>
          <li class="nav-header">EXPERT</li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantProfil/'|url}" class="nav-link">
              <i class="nav-icon fas fa-id-card"></i>
              <p>
                Profil
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantCalendar/'|url}" class="nav-link text-danger">
              <i class="nav-icon fas fa-calendar-alt"></i>
              <p>
                Calendar
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantInvoice/'|url}" class="nav-link">
              <i class="nav-icon fas fa-file"></i>
              <p>
                Factures
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/voyantInvoice/list'|url}" class="nav-link text-danger">
              <i class="nav-icon fas fa-book"></i>
              <p>
                Invoices
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/earnings/'|url}" class="nav-link">
              <i class="nav-icon far fa-credit-card"></i>
              <p>
                Gains
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{'/voyantPanel/order/pending'|url}" class="nav-link">
              <i class="nav-icon far fa-image"></i>
              <p>
                {'MenuleftIndex_Pending_check'|lang}
              </p>
            </a>
          </li>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
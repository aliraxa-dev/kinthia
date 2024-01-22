<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
<!-- Brand Logo -->
<a href="{'/admin/main'|url}" class="brand-link">
  <img src="{'/admin/templates/kinthia/images/kinthia-logo-small-white-2.png'|resurl}" alt="Admin - Kinthia" class="brand-image-kin" style="opacity: .8">
</a>
<!-- Sidebar -->
<div class="sidebar">
  <!-- Sidebar user panel (optional) -->
  <div class="user-panel mt-3 pb-3 mb-3 d-flex">
    <div class="info color-c2c7d0">
      {$session.login}<br>
      <a href="{'/admin/main/logOut'|url}">Se déconnecter</a>
      <a href="#" class="d-block"></a>
    </div>
  </div>

  <!-- Sidebar Menu -->
  <nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
      <!-- Add icons to the links using the .nav-icon class
           with font-awesome or any other icon font library -->
      <li class="nav-header">ADMIN - TABLEAU DE BORD</li>
      <li class="nav-item">
        <a href="{'/admin/main/index'|url}" class="nav-link">
          <i class="nav-icon fas fa-book"></i>
          <p>
            Accueil
          </p>
        </a>
      </li>
      <li class="nav-header">Order & Consultation</li>
      <li class="nav-item">
        <a href="{'/admin/order/list'|url}" class="nav-link text-danger">
          <i class="nav-icon fas fa-book"></i>
          <p>
            Order Lists
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/order/cart'|url}" class="nav-link text-danger">
          <i class="nav-icon fas fa-book"></i>
          <p>
            Cart
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/order/consultation'|url}" class="nav-link text-danger">
          <i class="nav-icon fas fa-book"></i>
          <p>
            Consultation
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/order/consultationQ'|url}" class="nav-link text-danger">
          <i class="nav-icon fas fa-book"></i>
          <p>
            Consultation question
          </p>
        </a>
      </li>

      <li class="nav-header">PENDING</li>
      <li class="nav-item">
        <a href="{'/admin/userQuestion/pending'|url}" class="nav-link">
          <i class="nav-icon far fa-envelope"></i>
          <p>
            Questions à traiter
            <span class="badge badge-danger right">{$statistic.pendingQuestionsCount}</span>
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/userMessage/pending'|url}" class="nav-link">
          <i class="nav-icon far fa-envelope"></i>
          <p>
            Messages à traiter
            <span class="badge badge-warning right">{$statistic.pendingMessagesCount}</span>
          </p>
        </a>
      </li>
      <li class="nav-header">EXPERTS</li>
      <li class="nav-item">
        <a href="{'/admin/voyantQuestion/pending'|url}" class="nav-link">
          <i class="nav-icon far fa-envelope"></i>
          <p>
            Question en attente
            <span class="badge badge-warning right">{$statistic.pendingvoyantQuestionCount}</span>
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/voyantQuestion/create'|url}" class="nav-link">
          <i class="nav-icon fas fa-edit"></i>
          <p>
            Créer une question
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/voyant/'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Liste des voyants
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/voyant/create/'|url}" class="nav-link">
          <i class="nav-icon fas fa-edit"></i>
          <p>
            Créer un voyant
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/user/userReview/'|url}" class="nav-link">
          <i class="nav-icon fas fa-star"></i>
          <p>
            Avis & notes
            <span class="badge badge-warning right">{$statistic.unpublishReviewCount}</span>
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/order/pending'|url}" class="nav-link">
          <i class="nav-icon far fa-image"></i>
          <p>
            {'MenuleftIndex_Pending_check'|lang}
          </p>
        </a>
      </li>
      <li class="nav-header">USERS</li>
      <li class="nav-item">
        <a href="{'/admin/user/user/'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Liste des utilisateurs
          </p>
        </a>
      </li>
      <li class="nav-header">INVOCIES TO BE PAID TO EXPERTS</li>
      <li class="nav-item">
        <a href="{'/admin/voyantInvoice/list'|url}" class="nav-link text-danger">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Invoices list
          </p>
        </a>
      </li>
      	<li class="nav-item">
        <a href="{'/admin/voyantInvoice/pending'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Pending Invoices
            {* <span class="badge badge-warning right">2</span> *}
          </p>
        </a>
      </li>
      <li class="nav-header">PACKAGES</li>
        <li class="nav-item">
        <a href="{'/admin/package/'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Manage
          </p>
        </a>
      </li>
      <li class="nav-header">CONFIG</li>
      <li class="nav-item">
        <a href="{'/admin/setting/'|url}" class="nav-link">
          <i class="nav-icon fas fa-sliders-h"></i>
          <p>
            Main
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/language'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Languages
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/skill'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Skills
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/setting/email'|url}" class="nav-link">
          <i class="nav-icon far fa-envelope"></i>
          <p>
            Emails
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/setting/paymentProcessor'|url}" class="nav-link">
          <i class="nav-icon fas fa-id-card"></i>
          <p>
            Payment
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/sitemap'|url}" class="nav-link">
          <i class="nav-icon far fa-image"></i>
          <p>
            SiteMap
          </p>
        </a>
      </li>
      <li class="nav-item nav-header">
      	<a href="#" class="nav-link">SECURITE
      		<i class="fas fa-angle-left right"></i>
      	</a>
      <ul class="nav nav-treeview" style="display: none;">
      <li class="nav-item">
        <a href="{'/admin/user/reportExpert'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Report expert
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/user/banIp'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Bannir IP
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/user/banEmail'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Bannir email
          </p>
        </a>
      </li>
  		</ul>
      </li>

      <li class="nav-item nav-header">
      	<a href="#" class="nav-link">EMAIL - NEWSLETTER
      		<i class="fas fa-angle-left right"></i>
      	</a>
      <ul class="nav nav-treeview" style="display: none;">
      <li class="nav-item">
        <a href="{'/admin/user/newsletter'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Envoie
          </p>
        </a>
      </li>
      <li class="nav-item">
        <a href="{'/admin/user/newsletterEmail'|url}" class="nav-link">
          <i class="nav-icon fas fa-list"></i>
          <p>
            Export
          </p>
        </a>
      </li>
      </ul>
      </li>
  </nav>
  <!-- /.sidebar-menu -->
</div>
<!-- /.sidebar -->
</aside>

{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Profil expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Profil {$voyant.name}</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v3</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

<!-- Main content -->
<div class="content">
<div class="container-fluid">
<div class="row">
  <div class="col-md-12">
    <!-- Widget: user widget style 1 -->
    <div class="card card-widget widget-user">
      <!-- Add the bg color to the header using any of the bg-* classes -->
      <div class="widget-user-header bg-kinthia">
        <h3 class="widget-user-username"><b>{$voyant.name}</b></h3>
        <p class="widget-user-desc">{$session.login}</p>
      </div>
      <div class="widget-user-image">
        <img class="elevation-2" src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="Photo">
      </div>
      <div class="card-footer">
        <div class="row">
          <div class="col-sm-2 border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.answeredQuestionsCount}</h5>
              <span class="description-text">Questions traités</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col-sm-3 border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.getConsultationtimephone}</h5>
              <span class="description-text">Temps passés au téléphone</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col-sm-3 border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.getConsultationtimewebcam}</h5>
              <span class="description-text">Temps passés par webcam</span>
            </div>
            <!-- /.description-block -->
          </div>
          <div class="col-sm-3 border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.getConsultationtimechat}</h5>
              <span class="description-text">Temps passés par chat</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col-sm-2 border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.voyantUsersCount}</h5>
              <span class="description-text">Consultants différents</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col-sm-2">
            <div class="description-block">
              <h5 class="description-header">{$voyant.ratingAverage}/5 - {$statistic.voyantCommentValidatedCount} avis</h5>
              <span class="description-text">Avis & notes</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
    </div>
    <!-- /.widget-user -->
  </div>
</div>
<div class="row">
  <div class="col-md-6">
    <div class="card card-primary">
      <div class="card-header">
      <h3 class="card-title">Informations publics - Affiché sur le site</h3>
      </div>
      <div class="card-body box-profile">
      <ul class="list-group list-group-unbordered mb-3">
      <li class="list-group-item">
      <b>Pseudo</b> <a class="float-right">{$voyant.name}</a>
      </li>
      <li class="list-group-item">
      <b>Sexe</b> <a class="float-right">
          {if $voyant.gender=='M'}
            {"Male"}
          {else}
            {"Female"}
          {/if}
      </a>
      </li>
      <li class="list-group-item">
      <b>Langues</b> <a class="float-right">
      {if $voyantlanguages && $languageIds}
      {foreach from=$voyantlanguages item=lang key=mkey}
          {if in_array($lang.languageId, $languageIds)}
                     {$lang.language},
          {/if}
      {/foreach}
    {/if}

    </a>
      </li>
      <li class="list-group-item">
      <b>Compétences</b> <a class="float-right">
        {if $voyantSkills && $skillIds}
          {foreach from=$voyantSkills item=skill}
              {if in_array($skill.skillId, $skillIds)}
                          {$skill.name},
              {/if}
          {/foreach}
        {/if}
      </a>
      </li>
      <li class="list-group-item">
      <b>Type de consultation</b> <a class="float-right"></a><a class="float-right">

        {if $voyant.displayPhone==1} {"Phone"}, {/if} {if $voyant.displayWebcam==1} {"Webcam"}, {/if} {if $voyant.displayEmail==1} {"Email"}, {/if} {if $voyant.displayChat==1} {"Chat"} {/if}
      </a>
      </li>
      <li class="list-group-item">
      <b>Description courte</b> <span class="float-right">{$voyant.shortDescription|htmlspecialchars_decode}</span>
      </li>
      <li class="list-group-item">
      <b>Description longue</b> <span class="float-right">{$voyant.voyantDescription|htmlspecialchars_decode}</span>
      </li>
      <li class="list-group-item">
      <b>Quote</b> <span class="float-right">{$voyant.voyantQuote|htmlspecialchars_decode}</span>
      </li>
      </ul>
      </div>
      <!-- /.card-body -->
    </div>
  </div>
  <div class="col-md-6">
    <div class="card card-primary">
      <div class="card-header">
      <h3 class="card-title">Informations personnelles - Non affiché sur le site</h3>
      </div>
      <div class="card-body box-profile">
      <ul class="list-group list-group-unbordered mb-3">
      <li class="list-group-item">
      <b>Prénom</b> <a class="float-right">{$voyant.firstName}</a>
      </li>
      <li class="list-group-item">
      <b>Nom</b> <a class="float-right">{$voyant.lastName}</a>
      </li>
      <li class="list-group-item">
      <b>Email</b> <a class="float-right">{$voyant.email}</a>
      </li>
      <li class="list-group-item">
      <b>Tel Mobile</b> <a class="float-right">{$voyant.mobileNumber}</a>
      </li>
      <li class="list-group-item">
      <b>Tel fixe</b> <a class="float-right">{$voyant.phoneNumber}</a>
      </li>
      <li class="list-group-item">
      <b>Adresse</b> <a class="float-right">{$voyant.address}</a>
      </li>
      <li class="list-group-item">
      <b>Code postal</b> <a class="float-right">{$voyant.zipCode}</a>
      </li>
      <li class="list-group-item">
      <b>Ville</b> <a class="float-right">{$voyant.city}</a>
      </li>
      <li class="list-group-item">
      <b>Pays</b> <a class="float-right">{$voyant.country}</a>
      </li>
      <li class="list-group-item">
      <b>Nom société</b> <a class="float-right">{$voyant.companyName}</a>
      </li>
      <li class="list-group-item">
      <b>Forme société</b> <a class="float-right">{$voyant.companyFormat}</a>
      </li>
      <li class="list-group-item">
      <b>TVA Number</b> <a class="float-right">{if !empty($voyant.companyTvaNumber)}{$voyant.companyTvaNumber}{else}Non{/if}</a>
      </li>
      <li class="list-group-item">
      <b>TVA</b> <a class="float-right">{if !empty($voyant.tva)}{$voyant.tva}{else}Non{/if}</a>
      </li>
      <li class="list-group-item">
      <b>Numéro société</b> <a class="float-right">{$voyant.companyTaxNumber}</a>
      </li>
      <li class="list-group-item">
      <b>Reversion question (%) TTC</b> <a class="float-right">{$voyant.paidBackQuestion}</a>
      </li>
      <li class="list-group-item">
      <b>Reversion téléphone / min (€) TTC</b> <a class="float-right">{$voyant.paidBackPhone}</a>
      </li>
      <li class="list-group-item">
      <b>Reversion webcam / min (€) TTC</b> <a class="float-right">{$voyant.paidBackWebcam}</a>
      </li>
      </ul>
      </div>
      <!-- /.card-body -->
    </div>
    <div class="card card-primary">
      <div class="card-header">
      <h3 class="card-title">Informations bancaires - Non affiché sur le site</h3>
      </div>
      <div class="card-body box-profile">
      <ul class="list-group list-group-unbordered mb-3">
      <li class="list-group-item">
      <b>IBAN</b> <a class="float-right">{$voyant.bankIban}</a>
      </li>
      <li class="list-group-item">
      <b>BIC</b> <a class="float-right">{$voyant.bankBic}</a>
      </li>
      </ul>
      </div>
      <!-- /.card-body -->
    </div>
  </div>
</div>

  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}

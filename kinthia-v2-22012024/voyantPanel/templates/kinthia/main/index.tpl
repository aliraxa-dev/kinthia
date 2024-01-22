{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<!-- OPTIONAL SCRIPTS -->
<script src="{'/voyantPanel/templates/kinthia/dist/js/pages/dashboard3.js'|resurl}"></script>
<script src="{'/voyantPanel/javascript/main/indexOnLoad.js'|resurl}"></script>
<script src="{'/voyantPanel/templates/kinthia/plugins/chart.js/Chart.min.js'|resurl}"></script>
<script src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>

<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

{/capture}
{include file='includes/header.tpl' page="index" title="{'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Tableau de bord</h1>
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
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.answeredQuestionsCount}</h5>
              <span class="description-text">Questions traités</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$voyant.phone_usedtime}</h5>
              <span class="description-text">Temps passés au téléphone</span>
            </div>
            <!-- /.description-block -->
            </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$voyant.vdo_usedtime}</h5>
              <span class="description-text">Temps passés par webcam</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.voyantUsersCount}</h5>
              <span class="description-text">Consultants différents</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col">
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
  <!--<div class="col">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">En ligne</h3>
        <div class="card-tools">
          <input type="checkbox" name="my-checkbox" disabled checked data-bootstrap-switch data-off-color="danger" data-on-color="success">
        </div>
      </div>
      <!-- /.card-header --><!--
      <div class="card-body-kin">
        <span class="info-box-icon-kin bg-info"><i class="fas fa-signal"></i></span>
        <div class="info-box-content-kin">
          <span class="info-box-text">Vous êtes actuellement en ligne.</span>
          <span class="info-box-text">La mention en ligne s'affiche sur le site.</span>
        </div>
      </div>
      <!-- /.card-body --><!--
    </div>
    <!-- /.card --><!--
  </div>-->

{if $consultationIds && in_array(1, $consultationIds)}
  <div class="col-md-3">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Téléphone</h3>
        <div class="card-tools">
         {*  <input type="checkbox" name="my-checkbox" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}
        
          {*  <input type="checkbox" name="displayPhone" value="1" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

            {* <input class="form-check-input" type="checkbox" id="displayPhone" name="displayPhone"  /> *}

          <form action="{'/voyantPanel/main/saveConsultation'|url}" method="post" id="frmPhone">
           <label class="switch">
             <input type="checkbox" id="displayPhone" name="displayPhone" {if $voyant.displayPhone}value="1"{else}value="0"{/if} {if $voyant.displayPhone} checked {else} {/if} {if $voyant.available}{else}disabled{/if} data-toggle="toggle" class="switchBtn">
             <span class="slider round"></span>
            </label>
          </form>
        </div>



      </div>
      <!-- /.card-header -->
      <div class="card-body-kin">
        <span class="info-box-icon-kin bg-info"><i class="fas fa-phone-alt"></i></span>
        <div class="info-box-content-kin">
          <span class="info-box-text">Consultation par téléphone actif.</span>
          <span class="info-box-text">Vous pouvez avoir des consultations par téléphone.</span>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
{/if}

{if $consultationIds && in_array(2, $consultationIds)}
  <div class="col-md-3">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Webcam</h3>
        <div class="card-tools">
         {*  <input type="checkbox" name="my-checkbox" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

         {* <input type="checkbox" name="displayWebcam" value="1" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

        <form action="{'/voyantPanel/main/saveConsultation'|url}" method="post" id="frmWebcam">
         <label class="switch">
           <input type="checkbox" id="displayWebcam" name="displayWebcam" {if $voyant.displayWebcam}value="1"{else}value="0"{/if} {if $voyant.displayWebcam} checked {else} {/if} {if $voyant.available}{else}disabled{/if} data-toggle="toggle" class="switchBtn">

           <span class="slider round"></span>
          </label>
        </form>
        </div>
      </div>
      <!-- /.card-header -->
      <div class="card-body-kin">
        <span class="info-box-icon-kin bg-info"><i class="fas fa-video"></i></span>
        <div class="info-box-content-kin">
          <span class="info-box-text">Consultation par webcam actif.</span>
          <span class="info-box-text">Vous pouvez avoir des consultations par webcam.</span>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  {/if}

  {if $consultationIds && in_array(3, $consultationIds)}
  <div class="col-md-3">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Email</h3>
        <div class="card-tools">
          {* <input type="checkbox" name="my-checkbox" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}
          {* <input type="checkbox" name="displayEmail" value="1" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

           <form action="{'/voyantPanel/main/saveConsultation'|url}" method="post" id="frmEmail">
           <label class="switch">
             <input type="checkbox" id="displayEmail" name="displayEmail" {if $voyant.displayEmail}value="1"{else}value="0"{/if} {if $voyant.displayEmail} checked {else} {/if} {if $voyant.available}{else}disabled{/if} data-toggle="toggle" class="switchBtn>
             <span class="slider round"></span>
            </label>
          </form>
        </div>
      </div>
      <!-- /.card-header -->
      <div class="card-body-kin">
        <span class="info-box-icon-kin bg-info"><i class="far fa-envelope"></i></span>
        <div class="info-box-content-kin">
          <span class="info-box-text">Consultation par email actif.</span>
          <span class="info-box-text">Vous pouvez avoir des consultations par email.</span>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  {/if}
  <div class="col-md-3">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Vacances</h3>
        <div class="card-tools">
          <form action="{'/voyantPanel/main/saveAvailable'|url}" method="post" id="frmVacances">
          <input type="checkbox" id="vacances" name="available"  data-toggle="toggle" class="switchBtn" {if $voyant.available}value="1"{else}value="0"{/if} {if $voyant.available} {else}checked{/if}   >
          </form>
        </div>
      </div>
      <!-- /.card-header -->
      <div class="card-body-kin">
        <span class="info-box-icon-kin bg-info"><i class="fas fa-plane"></i></span>
        <div class="info-box-content-kin">
          <span class="info-box-text">Vous êtes actuellement en vacances.</span>
          <span class="info-box-text">Vous n'acceptez aucun type de consultation.</span>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
</div>
<div class="row">
  <div class="col-md-6">
    <div class="card">
      <div class="card-header bg-kinthia">
        <h3 class="card-title">Gains sur l'ensemble de la période</h3>
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Type</th>
              <th>Valeur</th>
              <th>Gains</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Questions traitées</td>
              <td>{$statistic.answeredQuestionsCount}</td>
              <td>{$statistic.answeredQuestionsEarning}€</td>
            </tr>
            <tr>
              <td>Temps passé au téléphone</td>
              <td>{$voyant.phone_usedtime}</td>
              <td>{math equation="($statistic.totalEarningPhone/60)*1" format="%.2f"}€</td>
            </tr>
            <tr>
              <td>Temps passé par webcam</td>
              <td>{$voyant.vdo_usedtime}</td>
              <td>{math equation="($statistic.totalEarningWebcam/60)*1" format="%.2f"}€</td>
            </tr>
            <tr class="bg-kinthia">
              <td><strong>Gain total</strong></td>
              <td></td>
              <td><strong>{math equation="($statistic.answeredQuestionsEarning) + ($statistic.totalEarningPhone/60)*1 +($statistic.totalEarningWebcam/60)*1" format="%.2f"}€</strong></td>
            </tr>
            <!--<tr>
              <td>Consultants différents</td>
              <td>{$statistic.voyantUsersCount}</td>
            </tr>
            <tr>
              <td>Questions en attente</td>
              <td>{$statistic.pendingQuestionsCount}</td>
            </tr>
            <tr>
              <td>Chèque en attente de validation</td>
              <td>{$statistic.pendingCheckOrdersCount}</td>
            </tr>
            <tr>
              <td>Voyant en vacances</td>
              <td><form action="{'/voyantPanel/main/saveAvailable'|url}" method="post">
              <input type="radio" name="available" value="1" {if $voyant.available}checked="checked"{/if}> Oui  
              <input type="radio" name="available" value="0" {if !$voyant.available}checked="checked"{/if}> Non
              <input type="submit" value="Save">
              </form></td>
            </tr>-->
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  <div class="col-md-6">
    <!-- DONUT CHART -->
    <div class="card">
      <div class="card-header bg-kinthia">
        <h3 class="card-title">Répartition des gains</h3>

        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
          <button type="button" class="btn btn-tool" data-card-widget="remove">
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
      <div class="card-body">
        <canvas id="donutChart"  data-id2={$statistic.answeredQuestionsEarning} data-id1={math equation="($statistic.totalEarningPhone/60)*1" format="%.2f"} data-id={math equation="($statistic.totalEarningWebcam/60)*1" format="%.2f"} style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
</div>

    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}

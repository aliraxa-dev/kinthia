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
            <h1 class="m-0">Gains</h1>
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
  <div class="col-md-6">
    <div class="card">
      <div class="card-header bg-kinthia">
        <h3 class="card-title">Gains - {$statistic.currentMonth}</h3>
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
              <td>{$statistic.answeredQuestionsCountCurrentMonth}</td>
              <td>{$statistic.getVoyantQuestionsTotalEarningCurrentmonth}€</td>
            </tr>
            <tr>
              <td>Temps passé au téléphone</td>
              <td>{$earning.phonetimeCurrentmonth}</td>
              <td>{math equation="($earning.totalEarningphoneCurrentmonth/60)*1" format="%.2f"}€</td>
            </tr>
            <tr>
              <td>Temps passé par webcam</td>
              <td>{$earning.webcamtimeCurrentmonth}</td>
              <td>{math equation="($earning.totalEarningWebcamCurrentmonth/60)*1" format="%.2f"}€</td>
            </tr>
            <tr class="bg-kinthia">
              <td><strong>Gain total</strong></td>
              <td></td>
              <td><strong>{math equation="($statistic.getVoyantQuestionsTotalEarningCurrentmonth)+($earning.totalEarningWebcamCurrentmonth/60)*1 +($earning.totalEarningphoneCurrentmonth/60)*1" format="%.2f"}€</strong></td>
            </tr>
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
        <h3 class="card-title">Répartition des gains - {$statistic.currentMonth}</h3>
      </div>
      <div class="card-body">
        <canvas id="donutChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
</div>
<div class="row">
  <div class="col-md-12">
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
              <td>{$statistic.phone_usedtime}</td>
              <td>{math equation="($earning.totalEarningPhone/60)*1" format="%.2f"}€</td>
            </tr>
            <tr>
              <td>Temps passé par webcam</td>
              <td>{$statistic.video_usedtime}</td>
              <td>{math equation="($earning.totalEarningWebcam/60)*1" format="%.2f"}€</td>
            </tr>
            <tr class="bg-kinthia">
              <td><strong>Gain total</strong></td>
              <td></td>
              <td><strong>{math equation="($statistic.answeredQuestionsEarning) + ($earning.totalEarningPhone/60)*1 +($earning.totalEarningWebcam/60)*1" format="%.2f"}€</strong></td>
            </tr>
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
</div>

  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}
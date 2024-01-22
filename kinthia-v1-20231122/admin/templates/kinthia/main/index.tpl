{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title="{'Admin - Kinthia'|lang}"}
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
        <h3 class="widget-user-username"><b></b></h3>
        <p class="widget-user-desc">{$session.login}</p>
      </div>
      <div class="widget-user-image">
        
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
              <h5 class="description-header">{$statistic.totaltimeonPhone}</h5>
              <span class="description-text">Temps passés au téléphone</span>
            </div>
            <!-- /.description-block -->
            </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.totaltimeonWebcam}</h5>
              <span class="description-text">Temps passés par webcam</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$statistic.usersCount}</h5>
              <span class="description-text">Utilisateurs différents</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col">
            <div class="description-block">
              <h5 class="description-header">{$statistic.databaseSize}</h5>
              <span class="description-text">Base de données</span>
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
              <th>Gains voyants</th>
              <th>Gains company</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Questions traitées</td>
              <td>{$statistic.answeredQuestionsCount}</td>
            <td>{$statistic.getVoyantQuestionsTotalEarningAllVoyant}€</td>
           
              <td> {$statistic.getVoyantQuestionsTotalEarningCompany}€</td>
            </tr>
            <tr>
              <td>Temps passé au téléphone</td>
              <td>{$statistic.totaltimeonPhone}</td>
              <td>{math equation="($statistic.getTotalEarningAllOnPhone/60)*1" format="%.2f"}€</td>
           
         
                 <td>{math equation="($statistic.getTotalEarningCompanyOnPhone/60)*1" format="%.2f"}€</td>
            </tr>
            <tr>
              <td>Temps passé par webcam</td>
              <td>{$statistic.totaltimeonWebcam}</td>
                    
                     <td>{math equation="($statistic.getTotalEarningAllOnWebcam/60)*1" format="%.2f"}€</td>
           
                <td>{math equation="($statistic.getTotalEarningCompanyOnWebcam/60)*1" format="%.2f"}€</td>
            </tr>
            <tr class="bg-kinthia">
              <td><strong>Gain total</strong></td>
              <td></td>
             
           <td><strong>{math equation="($statistic.getVoyantQuestionsTotalEarningAllVoyant) + ($statistic.getTotalEarningAllOnPhone/60)*1 +($statistic.getTotalEarningAllOnWebcam/60)*1" format="%.2f"}€</strong></td>
           
              <td><strong>{math equation="($statistic.getVoyantQuestionsTotalEarningCompany) + ($statistic.getTotalEarningCompanyOnPhone/60)*1 +($statistic.getTotalEarningCompanyOnWebcam/60)*1" format="%.2f"}€</strong></td>
          
            </tr>

          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  <div class="col-md-6">
    <div class="card">
      <div class="card-header bg-kinthia">
        <h3 class="card-title">Gains {$statistic.currentMonth}</h3>
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Type</th>
              <th>Valeur</th>
              <th>Gains voyants</th>
              <th>Gains company</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Questions traitées</td>
              <td>{$statistic.getCurrentCountOfQuestionsWithStatus}</td>
              <td>{$statistic.getAllVoyantQuestionsTotalEarningCurrentmonth}€</td>
                <td>{$statistic.getCompanyQuestionsTotalEarningCurrentmonth}€</td>
              
            </tr> 
            <tr>
              <td>Temps passé au téléphone</td>
                <td>{$statistic.getAllConsultationtimeCurrentmonthOnPhone}</td>
               
                <td>{math equation="($statistic.totalAllEarningCurrentmonthOnPhone/60)*1" format="%.2f"}€</td>
                 
                <td>{math equation="($statistic.totalCompanyEarningCurrentmonthOnPhone/60)*1" format="%.2f"}€</td>
            </tr>
            <tr>
              <td>Temps passé par webcam</td>
              <td>{$statistic.getAllConsultationtimeCurrentmonthOnWebcam}</td>
                
                  <td>{math equation="($statistic.totalAllEarningCurrentmonthOnWebcam/60)*1" format="%.2f"}€</td>
             <td>{math equation="($statistic.totalCompanyEarningCurrentmonthOnWebcam/60)*1" format="%.2f"}€</td>
            </tr>
            <tr class="bg-kinthia">
              <td><strong>Gain total</strong></td>
              <td></td>
              
                  <td><strong>{math equation="($statistic.getAllVoyantQuestionsTotalEarningCurrentmonth) + ($statistic.totalAllEarningCurrentmonthOnPhone/60)*1 +($statistic.totalAllEarningCurrentmonthOnWebcam/60)*1" format="%.2f"}€</strong></td>
            <td><strong>{math equation="($statistic.getCompanyQuestionsTotalEarningCurrentmonth) + ($statistic.totalCompanyEarningCurrentmonthOnPhone/60)*1 +($statistic.totalCompanyEarningCurrentmonthOnWebcam/60)*1" format="%.2f"}€</strong></td>
           
            </tr>

          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
</div>

    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
</div>
{include file="includes/footer.tpl"}
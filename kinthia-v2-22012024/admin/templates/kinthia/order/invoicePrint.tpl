<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Impression facture - Panel expert - Kinthia</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/fontawesome-free/css/all.min.css'|resurl}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/dist/css/adminlte.min.css'|resurl}">
</head>
<body>
<div class="wrapper">
  <!-- Main content -->
  <section class="invoice">
    <!-- info row -->
    <div class="row invoice-info">
        <div class="col-sm-4 invoice-col">
          DE
          <address>
            <strong>$plateformName</strong><br>
            $plateformAdresse<br>
            $plateformPostalCode $plateformCity<br>
            $plateformCountry<br>
            SIRET : $plateformSiret<br>
            TVA non applicable, art. 293 B du Code général des impôts
          <br>OR<br>
          <strong>$expertName</strong><br>
            $expertAdresse<br>
            $expertPostalCode $expertCity<br>
            $expertCountry<br>
            SIRET : $expertSiret<br>
            (if TVA OFF)TVA non applicable, art. 293 B du Code général des impôts(/if TVA OFF)
          </address>
        </div>
        <!-- /.col -->
        <div class="col-sm-4 invoice-col">
          A
          <address>
            <strong>$userFirstName $userLastName</strong><br>
            $userAdress<br>
            $userPostalCode $userCity<br>
            $userCountry
          </address>
        </div>
        <!-- /.col -->
        <div class="col-sm-4 invoice-col">
          <b>Facture n°kin-$orderId</b> du 01/02/2021
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

    <!-- Table row -->
    <div class="row">
      <div class="col-12 table-responsive">
        <table class="table table-striped">
          <thead>
          <tr>
            <th>Quantité</th>
            <th>Description</th>
            <th>Montant unitaire HT</th>
            <th>Montant HT</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>2</td>
            <td>Question sentimental</td>
            <td>15.00</td>
            <td>30.00</td>
          </tr>
          <tr>
            <td>5</td>
            <td>Roue astrologique</td>
            <td>65.00</td>
            <td>325.00</td>
          </tr>
          <tr>
            <td>1</td>
            <td>Pack time (15min)</td>
            <td>15</td>
            <td>15.00</td>
          </tr>
          <tr>
            <td>1</td>
            <td>Pack time (60min)</td>
            <td>60</td>
            <td>60.00</td>
          </tr>
          </tbody>
        </table>
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->

    <div class="row">
      <div class="col-6">
      </div>
      <div class="col-6">
        <div class="table-responsive">
          <table class="table">
            <tr>
              <th style="width:50%">Total HT:</th>
              <td>430.00</td>
            </tr>
            <tr>
              <th>(if tva ON)TVA (20.00%)(/if tva ON)</th>
              <td>86.00</td>
            </tr>
            <tr>
              <th>Total TTC:</th>
              <td>516.00 €</td>
            </tr>
          </table>
        </div>
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </section>
  <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- Page specific script -->
<script>
  window.addEventListener("load", window.print());
</script>
</body>
</html>
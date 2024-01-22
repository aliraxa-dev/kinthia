{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title="{'Invoice - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Facture $invoiceDate - $invoiceOrderId</h1>
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
<section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">

            <!-- Main content -->
            <div class="invoice p-3 mb-3">
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
                <!-- accepted payments column -->
                <div class="col-6">
                </div>
                <!-- /.col -->
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

              <!-- this row will not appear when printing -->
              <div class="row no-print">
                <div class="col-12">
                  <a href="{'/admin/order/invoicePrint'|url}" rel="noopener" target="_blank" class="btn btn-default"><i class="fas fa-print"></i> Imprimer</a>
                </div>
              </div>
            </div>
            <!-- /.invoice -->
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}
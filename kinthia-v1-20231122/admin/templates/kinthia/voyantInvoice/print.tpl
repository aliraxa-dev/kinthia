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

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Facture {$purchaseDate|date_format:"%B, %Y"} - {$invoiceDate}</h1>
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
                       <strong>{$settings.companyName}</strong><br>
                        {$settings.platformAddress}<br>
                        {$settings.platformZipcode} {$settings.platformCity}<br>
                        {$settings.platformCountry}<br>
                        SIRET : {$settings.companyNumber}<br>
                        TVA non applicable, art. 293 B du Code général des impôts
                      {* <br>OR<br> *}
                     </address>
                    </div>
                    <!-- /.col -->
                    <div class="col-sm-4 invoice-col">
                      A
                      <address>
                          <strong>{$voyant.name}</strong><br>
                            {$voyant.address}<br>
                            {$voyant.zipCode} {$voyant.city}<br>
                            {$voyant.country}<br>
                            SIRET : {$voyant.companyTaxNumber}<br>
                           {if $voyant.displayTvaOnInvoice < 1}TVA non applicable, art. 293 B du Code général des impôts{/if}
                      </address>
                    
                    </div>
                    <!-- /.col -->
                    <div class="col-sm-4 invoice-col">
                      <b>Facture n°{$invoiceDate}</b> du {$invoiceDate}<br>
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
                      <th>Montant HT <br>
                      ( 50% off on Question)</th>
                    </tr>
                    </thead>
                    <tbody>
                    {if $jointArr}
                       {foreach from=$jointArr item=orderArrs key=mkey}
                          {foreach from=$orderArrs item=orderArr key=qty}
                          {if !empty($orderArr.title) || !empty($orderArr.type)}
                          <tr>
                            <td>
                              {$qty}
                            </td>

                            <td>
                              {if !empty($orderArr.title)}
                                  {$orderArr.title}
                              {elseif !empty($orderArr.type)}
                                  {$orderArr.type} {"Service (minutes)"}
                              {/if}
                            </td>

                            <td>
                              {if !empty($orderArr.price)}
                                  {$orderArr.price}
                              {elseif !empty($orderArr.consultation_total_time)}
                                  {$orderArr.consultation_total_time}
                              {/if}
                            </td>

                            <td>
                              {if !empty($orderArr.price) && !empty($qty)}
                                   {math equation="($orderArr.price * $qty)" format="%.2f"}
                              {elseif !empty($orderArr.consultation_total_cost) && !empty($qty)}                        
                                   {* {math equation="($orderArr.consultation_total_cost * $qty)" format="%.2f"} *}

                                   {math equation="($orderArr.consultation_total_cost)" format="%.2f"}
                              {/if}
                            </td>

                            <td>
                              {if !empty($orderArr.price) && !empty($qty)}
                                   {math equation="($orderArr.price * $qty/2)" format="%.2f"}
                              {elseif !empty($orderArr.consultation_total_cost) && !empty($qty)}                        
                                   {* {math equation="($orderArr.consultation_total_cost * $qty)" format="%.2f"} *}

                                   {math equation="($orderArr.consultation_total_cost)" format="%.2f"}
                              {/if}
                            </td>

                          </tr>
                          {/if}
                       {/foreach}
                      {/foreach}
                    {/if}
                    
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
                        <td>{math equation="($getTotal)" format="%.2f"}</td>
                      </tr>
                      {* {if $voyant.displayTvaOnInvoice && !empty($voyant.tva) && $voyant.paymentExpertPlatform == 1}
                        <tr>
                          <th>TVA ({$voyant.tva}%)</th>
                          <td>{math equation="($getTotal * $voyant.tva/100)" format="%.2f"}</td>
                        </tr>
                      {/if}

                      {if !empty($settings.vatPercent) && isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform < 1}
                        <tr>
                          <th>TVA ({$settings.vatPercent}%)</th>
                          <td>{math equation="($getTotal * $settings.vatPercent/100)" format="%.2f"}</td>
                        </tr>
                      {/if} *}

                       {if !empty($settings.vatPercent)}
                        <tr>
                          <th>TVA ({$settings.vatPercent}%)</th>
                          <td>
                            {math equation="($getTotal * $settings.vatPercent/100)" format="%.2f"}
                          </td>
                        </tr>
                      {/if}  
                      
                      <tr>
                        <th>Total TTC:</th>
                        <td>
                          {* {if $voyant.displayTvaOnInvoice && !empty($voyant.tva)} 
                            {math equation="($getTotal + $getTotal * $voyant.tva/100)" format="%.2f"} €
                          {else}
                            {math equation="($getTotal)" format="%.2f"} €
                          {/if} *}

                          {if $tvaCalculatedTotalAmt}
                            {math equation="($tvaCalculatedTotalAmt)" format="%.2f"} €
                          {/if}
                          </td>
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
                     <a href='{"/admin/voyantInvoice/print/$voyant.voyantId/$purchaseDate/$invoiceDate"|url}' rel="noopener" target="_blank" class="btn btn-default"><i class="fas fa-print"></i> Imprimer</a>
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

<script>
  window.addEventListener("load", window.print());
</script>
</body>
</html>

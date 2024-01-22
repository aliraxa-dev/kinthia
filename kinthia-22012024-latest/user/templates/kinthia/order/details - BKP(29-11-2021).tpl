{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<div class="padding-wrapper aftermenutop">
<div id="breadcrumb">
<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
<a href="{'/user/order'|url}">{'orderIndex_arbo'|lang}</a>
</div>

<!--
{include file="includes/profileBox.tpl"}
-->

{include file="includes/profileMenu.tpl"}

<div class="column_in_user2">
  <div class="my-5">
    <a href="{'/user/order/mail'|url}" class="btn btn-primary">Consultation par email ({$session.user.ordersCount})</a>
    <a href="{'/user/order/phone'|url}" class="btn btn-primary">Consultation par téléphone (0)</a>
    <a href="{'/user/order/webcam'|url}" class="btn btn-primary">Consultation par webcam (0)</a>
  </div>
</div>
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
                  
                   {* {if isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform < 1}
                       <address>
                         <strong>{$platformDetail.name} </strong><br>
                        {$platformDetail.address}<br>
                        {$platformDetail.zipCode} {$platformDetail.city} <br>
                        {$platformDetail.country}<br>
                        SIRET : {$setting.companyNumber}<br>
                        {if $voyant.displayTvaOnInvoice < 1}TVA non applicable, art. 293 B du Code général des impôts{/if}
                      </address>  
                  {else}
                        {if isset($platformDetail) && !empty($platformDetail) && empty($voyant)}
                            <address>
                              <strong>{$platformDetail.name} </strong><br>
                              {$platformDetail.address}<br>
                              {$platformDetail.zipCode} {$platformDetail.city} <br>
                              {$platformDetail.country}<br>
                              SIRET : {$setting.companyNumber}<br>
                              TVA non applicable, art. 293 B du Code général des impôts
                            </address> 
                        {/if}
                  {/if} *}

                   {if isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform < 1}
                       <address>
                         <strong>{$settings.companyName} </strong><br>
                        {$settings.platformAddress}<br>
                        {$settings.platformZipcode} {$settings.platformCity} <br>
                        {$settings.platformCountry}<br>
                        SIRET : {$settings.companyNumber}<br>
                        {if $voyant.displayTvaOnInvoice < 1}TVA non applicable, art. 293 B du Code général des impôts{/if}
                      </address>  
                  {else}
                        {if isset($settings) && !empty($settings) && empty($voyant)}
                            <address>
                              <strong>{$settings.companyName} </strong><br>
                              {$settings.platformAddress}<br>
                              {$settings.platformZipcode} {$settings.platformCity} <br>
                              {$settings.platformCountry}<br>
                              SIRET : {$settings.companyNumber}<br>
                              TVA non applicable, art. 293 B du Code général des impôts
                            </address> 
                        {/if}
                  {/if}

                  {if isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform == 1}
                      <address>
                        <strong>{$voyant.name} {*OR {$voyant.companyName} *}</strong><br>
                        {$voyant.address}<br>
                        {$voyant.zipCode} {$voyant.city} <br>
                        {$voyant.country}<br>
                        SIRET : {$voyant.companyTaxNumber}<br>
                        {if $voyant.displayTvaOnInvoice < 1}TVA non applicable, art. 293 B du Code général des impôts{/if}
                      </address>
                
                   {/if}
                </div>
                
                <!-- /.col -->
                <div class="col-sm-4 invoice-col">
                  A
                 {if isset($userDetail) && !empty($userDetail)}
                      <address>
                        <strong>
                        {if $userDetail.name}
                           {$userDetail.name}
                        {else}
                          {$userDetail.firstName} {$userDetail.lastName}
                        {/if}
                        </strong><br>
                          {$userDetail.address}<br>
                          {$userDetail.zipCode} {$userDetail.city}<br>
                          {$userDetail.country}
                      </address>
                  {/if}
                </div>
                <!-- /.col -->
                <div class="col-sm-4 invoice-col">
                  <b>Facture n°kin-{$order.orderId}</b> du {$order.purchaseDate}<br>
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
                    {if $jointArr}
                       {foreach from=$jointArr item=orderArrs key=mkey}
                          {foreach from=$orderArrs item=orderArr key=qty}
                          <tr>
                            <td>
                              {$qty}
                            </td>

                            <td>
                              {if !empty($orderArr.title)}
                                  {$orderArr.title}
                              {elseif !empty($orderArr.packageName)}
                                  {$orderArr.packageName}
                              {/if}
                            </td>

                            <td>
                              {if !empty($orderArr.price)}
                                  {$orderArr.price}
                              {elseif !empty($orderArr.packagePrice)}
                                  {$orderArr.packagePrice}
                              {/if}
                            </td>

                            <td>
                              {if !empty($orderArr.price) && !empty($qty)}
                                   {math equation="($orderArr.price * $qty)" format="%.2f"}
                              {elseif !empty($orderArr.packagePrice) && !empty($qty)}                        
                                   {math equation="($orderArr.packagePrice * $qty)" format="%.2f"}
                              {/if}
                            </td>
                          </tr>
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
                      
                      <!--- Only For Voyant -->
                      {if !empty($voyant.displayTvaOnInvoice) && !empty($voyant.tva) && $voyant.paymentExpertPlatform == 1}
                        <tr>
                          <th>TVA ({$voyant.tva}%)</th>
                          <td>{math equation="($getTotal * $voyant.tva/100)" format="%.2f"}</td>
                        </tr>
                      {/if}

                    <!-- Only For Platform -->
                      {if isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform < 1}
                        {if !empty($settings.vatPercent)}
                            <tr>
                                <th>TVA ({$settings.vatPercent}%)</th>
                                <td>
                                  {math equation="($getTotal * $settings.vatPercent/100)" format="%.2f"}
                                </td>
                            </tr>
                        {/if}
                      {else}
                          {if isset($settings) && !empty($settings) && empty($voyant)}
                              {if !empty($settings.vatPercent)}
                                 <tr>
                                    <th>TVA ({$settings.vatPercent}%)</th>
                                    <td>{math equation="($getTotal * $settings.vatPercent/100)" format="%.2f"}</td>
                                  </tr>
                              {/if}
                          {/if}
                      {/if}

                      <tr>
                        <th>Total TTC:</th>
                        <td>
                            {if !empty($voyant.displayTvaOnInvoice) && !empty($voyant.tva) && $voyant.paymentExpertPlatform == 1} 
                                {math equation="($getTotal + $getTotal * $voyant.tva/100)" format="%.2f"} €                            
                            {else if isset($voyant) && !empty($voyant) && $voyant.paymentExpertPlatform < 1 && !empty($settings.vatPercent)}                           
                                {math equation="($getTotal + $getTotal * $settings.vatPercent/100)" format="%.2f"} €
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
                  <a href="{"/user/order/invoicePrint/$order.orderId"|url}" rel="noopener" target="_blank" class="btn btn-default" style="color: #000;"><i class="fas fa-print"></i> Imprimer</a>
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

{include file="includes/footer.tpl"}
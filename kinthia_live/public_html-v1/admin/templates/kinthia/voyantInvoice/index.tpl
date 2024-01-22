{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title=" Voyants invoices - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Voyants invoices</h1>
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

    <div class="card">
    <div class="card-body">
     <form action="{'/admin/voyantInvoice/'|url}" method="post">
      You can search users. just write their email or a part of their email<br /><br />
      <input type="text" class="input_text_medium" name="email" value="" /> <input type="submit" class="button" value="Search" />
      </form>
    </div>
    </div>

    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Liste des factures</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Voyant</th>
              <th>Number</th>
              <th>Pending</th>
            </tr>
          </thead>
          <tbody>
           {if $totOrderNumbersArr}
              {foreach from=$totOrderNumbersArr item=totOrderNumber key=date}
                  <tr class="{cycle values='bg-grey-kin, '}">
                    <td>{$date}</td>
                    <td>
                       {if isset($totOrderNumber[1]) && !empty($totOrderNumber[1])}
                        {foreach from=$totOrderNumber[1] item=order key=mkey}
                            {'<a href="#">'.$order.'</a>'."<br>"}
                         {/foreach}
                       {/if}
                    </td>
                    <td>{$totOrderNumber[0]}</td>
                    <td>
                      {if isset($totOrderNumber[pendingCount])}
                          {$totOrderNumber[pendingCount]}
                      {else}
                          {"0"}
                      {/if}
                    </td>
                  </tr>
              {/foreach}
            {/if}
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
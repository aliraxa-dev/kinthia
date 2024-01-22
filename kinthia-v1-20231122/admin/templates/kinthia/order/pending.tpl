{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/order/pendingOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Pending user questions'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Liste des avis et des notes en attente</h1>
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
      <div class="card-header">
        <h1><span>{$pendingCheckOrdersCount}</span> Pending orders</h1>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <form action="{'/admin/order/updateStatus'|url}" method="post" id="pendingOrdersForm">
        <div id="holderOfWaitingSites">
        {foreach from=$orders item=order}
          <div class="column_in_waiting_site_{cycle values='grey, blue'}">
            <div class="column_in_waiting_site_checkbox">
              <input type="checkbox" class="checkbox" name="orderIds[]" value="{$order.orderId}" />
            </div>
            <div class="column_in_waiting_site_text" style="padding: 0 0px 25px 50px;margin: -25px;">
            {$order.purchaseDate} | <strong>Question for</strong> : {$order.voyant.name}
            <br /> 
              <strong>{'Pending_Users'|lang}</strong>: <a href="{"/admin/user/edit/$order.user.userId"|url}" >{$order.user.name}</a> &nbsp;&nbsp;&nbsp;<strong>Email</strong>: {$order.user.email}
            <br />
              <strong>{'Pending_Question_select_by_user'|lang}</strong>:
              {foreach from=$order.orderItems item=orderItem}
                {$orderItem.voyantQuestion.title}  
              {/foreach}
            <br/>
              <strong>{'Pending_Payment_pending'|lang}</strong> : <span class="text_green">Yes</span></span>
              <br /> 
              <strong>{'Pending_Order_number'|lang}</strong> : {$order.orderId}</span>
            </div>
          </div><hr>
        {/foreach}

        {include file="includes/pageNavigation.tpl"}
        </div>

        <div class="column_in_waiting_site_button">
        <select name="status" >
            <option value="paid" selected="selected"> {'Pending_Check_ok'|lang}</option>
            <option value="delete">Delete</option>
        </select>
            <input type="button" class="button" value="{'Pending_Check_all'|lang}" id="selectAllButton"/>
            <input type="submit" class="button" value="OK" />
        </div>
      </form>

      </div>
      <div class="card-footer clearfix">
        {include file="includes/pageNavigation.tpl"} 
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
{include file="includes/footer.tpl"}
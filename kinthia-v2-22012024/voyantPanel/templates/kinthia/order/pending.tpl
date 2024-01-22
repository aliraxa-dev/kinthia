{capture assign="headData"}                
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}

{include file='includes/header.tpl' page="index" title="{'Pending_Pending_user_questions'|lang}"} 

<div class="content-wrapper">
	

<div id="left">
	{* {include file='menu/menuleft/menuleftIndex.tpl'} *}
</div>

 <div id="right">
</div>
<!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Pending Orders </h1>
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


<div class="content">
<div class="container-fluid">
<div class="row">
<div class="col-md-12">
<div class="card">

<div id="middle"> 
<div class="column">

<div class="card-header">            
	<h3>
		<span>
			{$pendingCheckOrdersCount}
		</span> 
		{'Pending_Pending_check_orders'|lang}
	</h3>
	<hr />

<div class="card-body table-responsive p-0">
	<form action="{'/voyantPanel/order/updateStatus'|url}" method="post" id="pendingOrdersForm">
		<div id="holderOfWaitingSites">
			{foreach from=$orders item=order}
				<div class="column_in_waiting_site_{cycle values='grey, blue'}">
					<div class="column_in_waiting_site_checkbox">
						<input type="checkbox" class="checkbox" name="orderIds[]" value="{$order.orderId}" />
					</div>

					<div class="column_in_waiting_site_text" style="padding: 0 0px 25px 50px;margin: -25px;">
						{$order.purchaseDate}
						<br /> 
						<strong>User</strong>: <a href="{"/voyantPanel/user/show/$order.user.userId"|url}" >{$order.user.name}</a> &nbsp;&nbsp;&nbsp;<strong>Email</strong>: {$order.user.email}
						<br />
						<strong>Question select by user</strong>:
						<br/>
						{foreach from=$order.orderItems item=orderItem}
							{$orderItem.voyantQuestion.title}  
						{/foreach}
						<br/>
						<strong>Payment pending</strong> : <span class="text_green">Yes</span></span>
						<br /> 
						<strong>Order Number</strong> : {$order.orderId}</span>
					</div>
				</div>
				<hr/>
			{/foreach}
			{include file="includes/pageNavigation.tpl"}
		</div>
		<div class="column_in_waiting_site_button">
			<select name="status" >
				<option value="paid" selected="selected"> Check OK </option>
			</select>
				<input type="button" class="button" value="Check all" id="selectAllButton"/>
				<input type="submit" class="button" value="OK" />
		</div>
	</form>
</div>
	</div>



</div></div></div></div></div></div></div></div>
{include file='includes/footer.tpl'}
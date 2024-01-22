{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/javascript/jquery/magnific-popup/magnific-popup.css'|resurl}" rel="stylesheet" type="text/css" />  
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/magnific-popup/jquery.magnific-popup.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/showOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>  
{/capture}
{include file='includes/header.tpl' page="index" title="{'Profil consultant - Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Profil consultant</h1>
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
	<div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Informations sur le consultant</h3>
              </div>
              <div class="card-body box-profile">
                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>Pseudo</b> <a class="float-right">{$user.name}</a>
                  </li>
                  <li class="list-group-item">
                    <b>Prénom</b> <a class="float-right">{$user.firstName}</a>
                  </li>
                  {* comment
                  <li class="list-group-item">
                    <b>Nom</b> <a class="float-right">{$user.lastName}</a>
                  </li>
                  *}
                  <li class="list-group-item">
                    <b>Date de naissance</b> <a class="float-right">{$user.birthdayDate|date_format:"%d"}-{$user.birthdayDate|date_format:"%m"}-{$user.birthdayDate|date_format:"%Y"}{* {$user.birthdayDate} *}</a>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Photos</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body popup-gallery">
              	<div class="row">
                {foreach from=$user.photos item=photo}
                	<div class="col-md-6 mb-1">
		        	<a href="{$photo.src}" title="$photo.title"><img src="{$photo.thumbSrc}" class="w-100" /></a>
		        	</div>
		        {/foreach}
		        </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
  <div class="col-md-9">
    <div class="card">
  <div class="card-header">
    <h3 class="card-title">Private Message</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
    <thead>
    <tr>
        <th>Date</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
       {foreach from=$voyantmessages item=voyantmessage key=mkey}
    <tr class="{cycle values='bg-grey-kin, '}">
      
        {if $mkey==0}
         <td>{$voyantmessage.date|date_format:"%d-%m-%Y at %I:%M %p"}</td>
         <td><a href="{"/voyantPanel/userMessage/details/$voyantmessage.userId"|url}">Répondre / Envoyer</a></td>
        {/if}

    </tr>
     {/foreach}
    </tbody>
    </table>
  </div>
  <!-- /.card-body -->
</div>
<!-- /.card -->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Questions achetées</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Intitulé de la question</th>
              <th>Statut</th>
              <th>Réponse</th>
              {* comment
              <th>Facture</th>
              <th>Transaction ID</th>
              end comment *}
              <th>Gain</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$user.userQuestions item=userQuestion}
            {if $voyantId==$userQuestion.voyantId}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>{$userQuestion.creationDate|date_format:"%d"}-{$userQuestion.creationDate|date_format:"%m"}-{$userQuestion.creationDate|date_format:"%Y"} à {$userQuestion.creationDate|date_format:"%H"}h{$userQuestion.creationDate|date_format:"%M"}

              {* {$userQuestion.creationDate} *}
          	  </td>
              <td>{$userQuestion.voyantQuestion.title}</td>
              <td>
              	{switch from=$userQuestion.status}
      				    {case value="pending"}
      				    <span class="color-dc3545">En attente</span>
      				    {case value="answered"}
      				    <span class="color-28a745">Traitée</span>
      			      {/switch}
              </td>
              <td><a href="{"/voyantPanel/userQuestion/summary/$userQuestion.questionId"|url}" title="Edit summary" class="">Voir / Ecrire</a></td>
              {* comment
              <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">voir n° {$userQuestion.orderId}</a></td>
    		  <td>{$userQuestion.order.payPalId}{$userQuestion.order.stripeData}</td>
    		  end comment *}
    		      <td>
                {* {$userQuestion.voyantQuestion.price}€ *}
                {if $paymentExpertPlatform==1}
                    {"100%"}
                {/if}

                 {if $paymentExpertPlatform < 1}
                    {"50%"}
                {/if}
              </td>
            </tr>
            {/if}
            {/foreach}
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Consultations par téléphone</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Durée de la consultation</th>
              <th>Gain</th>
              {* comment
              <th>Facture</th>
              <th>Transaction ID</th>
              end comment *}
            </tr>
          </thead>
          <tbody>
            {foreach from=$userConsultaions item=userConsultation}
            {if $voyantId==$userConsultation.voyantId && $userConsultation.type =='phone' && $userConsultation.status =='E'}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>
              {* {$userConsultation.created_at|date_format:"%d"}-{$userConsultation.created_at|date_format:"%m"}-{$userConsultation.created_at|date_format:"%Y"} à {$userConsultation.created_at|date_format:"%H"}h{$userConsultation.created_at|date_format:"%M"} *}

             {$userConsultation.date}
              </td>
              <td>{$userConsultation.durationMinutes}</td>
              <td>{math equation="($userConsultation.duration/60)*1" format="%.2f"}€</td>
              {* comment
              <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">voir n° {$userQuestion.orderId}</a></td>
          <td>{$userQuestion.order.payPalId}{$userQuestion.order.stripeData}</td>
          end comment *}
            </tr>
            {/if}
            {/foreach}
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Consultations par webcam</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Durée de la consultation</th>
              <th>Gain</th>
              {* comment
              <th>Facture</th>
              <th>Transaction ID</th>
              end comment *}
            </tr>
          </thead>
          <tbody>
            {foreach from=$userConsultaions item=userConsultation}
            {if $voyantId==$userConsultation.voyantId && $userConsultation.type =='webcam' && $userConsultation.status =='E'}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>
              {* {$userQuestion.creationDate|date_format:"%d"}-{$userQuestion.creationDate|date_format:"%m"}-{$userQuestion.creationDate|date_format:"%Y"} à {$userQuestion.creationDate|date_format:"%H"}h{$userQuestion.creationDate|date_format:"%M"} *}

              {$userConsultation.date}
          	  </td>
              <td>{$userConsultation.durationMinutes}</td>
              <td>{math equation="($userConsultation.duration/60)*1" format="%.2f"}€</td>
              {* comment
              <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">voir n° {$userQuestion.orderId}</a></td>
    		  <td>{$userQuestion.order.payPalId}{$userQuestion.order.stripeData}</td>
    		  end comment *}
            </tr>
            {/if}
            {/foreach}
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Avis & notes</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Note</th>
              <th>Avis</th>
              <th>Publié</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$user.voyantComments value=voyantComment}
            {if $voyantId == $voyantComment.voyantId}
            <tr class="{cycle values='bg-grey-kin, '}" id="commentForm{$voyantComment.commentId}">  
              <td>{$voyantComment.date|date_format:"%d"}-{$voyantComment.date|date_format:"%m"}-{$voyantComment.date|date_format:"%Y"}

              {* {$voyantComment.date} *}
          	  </td>
              <td>{$voyantComment.rating}/5</td>
              <td>
              	<textarea class="form-control" name="text" cols="50" rows="5" disabled="true">{$voyantComment.text}</textarea> <a href="#" rel="reply">{'Show_Reply'|lang}</span><br/>

              	<div class="replytextarea" style="margin-top:5px;display:none;">
	        		<textarea class="form-control" name="replyText" cols="50" rows="5">{$voyantComment.replyText}</textarea><br>
	        		<a href="#" class="link_green" rel="save">Sauvegarder la réponse</a>
        		</div>
              </td>
              <td>{if $voyantComment.validated}<span class="color-28a745">Oui</span>{else}<span class="color-dc3545">Non</span>{/if}</td>
              {* comment
              <td>
              	<input type="hidden" name="commentId" value="{$voyantComment.commentId}"/>
         				<a href="#" class="link_green" rel="save">{'Show_Save'|lang}</a> <br>
         				<a href="#" class="link_green" rel="publish">Publier</a><br>
         				<a href="#" class="link_green" rel="unpublish">Depublier</a>
         				| <a href="" title="Delete comment" class="link_red" rel="delete">{'Show_Delete'|lang}</a>
              </td>
              *}
            </tr>
            {/if}
            {/foreach}
          </tbody>
        </table>
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
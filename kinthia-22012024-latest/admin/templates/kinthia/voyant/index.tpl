{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="user" title="Utilisateurs - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div id="message" {if $message} style="background: green; color:#fff; text-align: center; padding: 5px 5px 5px 5px" {/if}>
      {$message}
    </div>
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{$voyantsCount} voyants</h1>
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
<form action="{'/admin/voyant'|url}" method="post">
You can search users. just write their email or a part of their email<br /><br />
<input type="text" class="input_text_medium" name="email" value="" /> <input type="submit" class="button" value="Search" />
</form>

</div>
</div>
</div>
</div>



<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">{$voyantsCount} voyants</h3>
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>{'Index_Voyant_Name'|lang}</th>
              <th>Email</th>
              <th>Questions traitées</th>
              <th>Phone</th>
              <th>Webcam</th>
              <th>Chat</th>
              <th>Available</th>
              <th>Online | p-w-e</th>
              <th>Management</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$voyants item=voyant}
            <tr class="{cycle values='bg-grey-kin,'}">
              <td>{$voyant.name} - {$voyant.firstName} {$voyant.lastName}</td>
              <td>{$voyant.email}</td>
              <td>{if !empty($voyant.userQuestions)}{$voyant.userQuestions[0].answeredCount}{else}0{/if}</td>
              <td>{$voyant.phone_usedtime}</td>
              <td>{$voyant.vdo_usedtime}</td>
              <td>{$voyant.chat_usedtime}</td>
              <td>
                {if $voyant.available == 1}
                    <span class="color-28a745">Yes</span>
                   {else}
                    <span class="color-dc3545">No</span>
                {/if}
              </td>

               <td>
                 {if $voyant.displayPhone == 1}
                    <i class="fas fa-circle color-28a745"></i>
                 {/if}
                 {if $voyant.displayPhone == 0 || empty($voyant.displayPhone)}
                    <i class="fas fa-circle color-dc3545"></i>
                 {/if}

                 {if $voyant.displayWebcam == 1}
                    <i class="fas fa-circle color-28a745"></i>
                  {/if}

                  {if $voyant.displayWebcam == 0 || empty($voyant.displayWebcam)}
                    <i class="fas fa-circle color-dc3545"></i>
                 {/if}

                 {if $voyant.displayEmail == 1}
                    <i class="fas fa-circle color-28a745"></i>
                  {/if}
                   {if $voyant.displayEmail == 0 || empty($voyant.displayEmail)}
                    <i class="fas fa-circle color-dc3545"></i>
                 {/if}
              </td>
              <td>
                <ul class="list-inline m-0">
                  <li class="list-inline-item">
                  <a href="{"/admin/voyant/edit/$voyant.voyantId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                  </li>
                  <li class="list-inline-item">
                  <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/voyant/delete/$voyant.voyantId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
                  </li>
                </ul>
              </td>
            </tr>
            {/foreach}
          </tbody>
        </table>
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

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}


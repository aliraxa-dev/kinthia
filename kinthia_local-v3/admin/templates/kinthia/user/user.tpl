{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="user" title="Utilisateurs - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{$usersCount} {'users'|lang}</h1>
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
<form action="{'/admin/user/user'|url}" method="post">
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
        <h3 class="card-title">{$usersCount} {'users'|lang}</h3>
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Name/Pseudo</th>
              <th>Email</th>
              <th>Question buy</th>
              <th>Time Buy</th>
              <th>Time Remaining</th>
              <th>
                Time Spent<br>
                P / W / C
              </th>
              <th>Management</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$users item=user}
            <tr class="{cycle values='bg-grey-kin,'}">
              <td>{$user.name}</td>
              <td>{$user.email}</td>
              <td>{if !empty($user.userQuestions)}{$user.userQuestions[0].boughtCount}{else}0{/if}</td>
              <td>{$user.tot_time}</td>
              <td>{$user.rem_time}</td>
              <td>{$user.vdo_usedtime} / {$user.phone_usedtime} / {$user.chat_usedtime}</td>
              <td>
                <ul class="list-inline m-0">
                <li class="list-inline-item">
                <a href="{"/admin/user/editUser/$user.userId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                </li>
                <li class="list-inline-item">
                <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/user/deleteUser/$user.userId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
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

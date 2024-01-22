{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/showOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Liste des avis et des notes</h1>
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
        <h3 class="card-title">{$commentsCount}  Avis & notes</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>User</th>
              <th>Type</th>
              <th>Note</th>
              <th>Avis</th>
              <th>Pubié</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$comments item=comment}
            <tr class="{cycle values='bg-grey-kin, '}" id="commentForm $voyantComment.commentId">
              <td>{$comment.date|date_format:"%Y-%m-%d"}</td>
              <td>{$comment[user].name}</td>
              <td>{if $comment.type=='Q'} Question {elseif $comment.type=='E' } Email {elseif $comment.type=='W'} Webcam {elseif $comment.type=='P'} Phone {elseif $comment.type=='C'} Chat {/if}</td>
              <td>{$comment.rating}/5</td>
              <td>
                <textarea class="form-control" name="text" cols="50" rows="5" disabled="true">{$comment.text}</textarea>
                <a href="javascript:void(0);" rel="reply">{'Show_Reply'|lang}</span><br/>


              <div class="replytextarea" style="margin-top:5px;display:none;">

                <textarea class="form-control" name="replyText" cols="50" rows="5"></textarea><br>
                <input type="hidden" name="commentId" value={$comment.commentId}/>
                <a href="#" class="link_green" rel="save">Sauvegarder la réponse</a>
              </div>
              </td>
                <td>
                  {if $comment.validated}
                  <span class="color-28a745">Oui</span>
                  {else}
                  <span class="color-dc3545">Non</span>
                  {/if}
                </td>
              {* comment
              <td>
                <input type="hidden" name="commentId" value="$voyantComment.commentId"/>
                <a href="#" class="link_green" rel="save">{'Show_Save'|lang}</a> <br>
                <a href="#" class="link_green" rel="publish">Publier</a><br>
                <a href="#" class="link_green" rel="unpublish">Depublier</a>
                | <a href="" title="Delete comment" class="link_red" rel="delete">{'Show_Delete'|lang}</a>
              </td>
              *}
            </tr>
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
{include file="includes/footer.tpl"}

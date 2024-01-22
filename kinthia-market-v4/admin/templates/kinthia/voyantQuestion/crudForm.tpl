<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{if $edit}Modifier question / service : {$voyantQuestion.title}{else}Créer question / service{/if}</h1>
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
        <h3 class="card-title">Formulaire - {if $edit}Modifier question / service : {$voyantQuestion.title}{else}Créer question / service{/if}</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">



<form action="{'/admin/voyantQuestion/save'|url}" method="post" enctype="multipart/form-data" id="editVoyantQuestionForm">
<input type="hidden" name="questionId" value=""/>
<table class="table text-nowrap">
<tbody>
<tr>
    <td>Voyant: </td>
    <td>
<select name="voyantId">
<option value="0">Select voyant</option>
{html_options options=$voyantOptionsList selected=$voyantOptionListSelectedId}
</select></td>
</tr>
<tr>
    <td>Title: </td>
    <td><input type="text" class="input_text_large" name="title" value="" /></td>
</tr>
<tr>
    <td>Short description: </td>
    <td><textarea class="textarea_large tinyMce" name="shortDescription" cols="50" rows="5" id="shortDescription"></textarea></td>
</tr>
<tr>
    <td>Long description: </td>
    <td><textarea class="textarea_large tinyMce" name="longDescription" cols="50" rows="5" id="longDescription"></textarea></td>
</tr>
<tr>
    <td>Price: </td>
    <td><input type="text" class="input_text_small" name="price" value="" /></td>
</tr>
<tr>
    <td>Additional prices: </td>
    <td>
    
    {assign var="lp" value=0}
    {if $edit}
    {foreach from=$voyantQuestion.voyantQuestionPrices item=price}
    <input type="hidden" name="voyantQuestionPrices[{$lp}][priceId]" value="{$price.priceId}"/>
    Quantity <input type="text" class="input_text_small" name="voyantQuestionPrices[{$lp}][quantity]" value="{$price.quantity}">
    &nbsp; Price <input type="text" class="input_text_small" name="voyantQuestionPrices[{$lp}][price]" value="{$price.price}"><br/><br/>
    {math equation="x + 1" x=$lp assign="lp"}
    {/foreach}
    {/if}
    
    {for start=0 stop=5}
    Quantity <input type="text" class="input_text_small" name="voyantQuestionPrices[{$lp}][quantity]" value="">
    &nbsp; Price <input type="text" class="input_text_small" name="voyantQuestionPrices[{$lp}][price]" value=""><br/><br/>
    {math equation="x + 1" x=$lp assign="lp"}
    {/for}
    
    </td>
</tr>
    <td>HTML TITLE: </td>
    <td><input type="text" class="input_text_large" name="metaTitle" value="" /></td>
</tr>
<tr>
    <td>Meta description: </td>
    <td><input type="text" class="input_text_large" name="metaDescription" value="" /></td>
</tr>
<tr>
    <td>H1: </td>
    <td><input type="text" class="input_text_large" name="headerDescription" value="" /></td>
</tr>
<tr>
    <td>Navigation Name: </td>
    <td><input type="text" class="input_text_large" name="navigationName" value="" /></td>
</tr>
<tr>
    <td>Image: </td>
    <td>
    {if $edit && $voyantQuestion.imageSrc}
    <img src="{$voyantQuestion.imageSrc|realImgSrc:'voyantQuestion'}"/><br/>
    {/if}
    <input type="file" class="input_text_large" name="image" value="" /></td>
</tr>
<tr>
    <td>Affiché en ligne</td>
    <td>
        <input type="checkbox" name="displayOnline" value="1" checked data-bootstrap-switch data-off-color="danger" data-on-color="success">
    </td>
</tr>
<tr>
    <td>Valider par l'admin</td>
    <td>
        <input type="checkbox" name="adminValidation" value="1" checked data-bootstrap-switch data-off-color="danger" data-on-color="success">
    </td>
</tr>
<tr>
    <td></td>
    <td>
    
    {if $edit}
    <input type="submit" class="button" value="Edit Question" />
    <input type="button" class="button" value="Delete Question" onclick="if (confirm('Do you really want to delete it?')) window.location.href = AppRouter.getRewrittedUrl('/admin/voyantQuestion/delete/{$voyantQuestion.questionId}');"  />
    {else}
    <input type="submit" class="button" value="Create Question" />
    {/if}
    </td>
</tr>
</tbody> 
</table>
</form>

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
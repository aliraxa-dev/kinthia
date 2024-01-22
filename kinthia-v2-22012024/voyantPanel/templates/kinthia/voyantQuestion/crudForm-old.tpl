<div class="title_h_1">
<h1>{if $edit}Edit {$voyantQuestion.title}{else}Create new voyant question{/if}</h1>
</div>

<div class="column_in_table2">
<form action="{'/voyantPanel/voyantQuestion/save'|url}" method="post" enctype="multipart/form-data" id="editVoyantQuestionForm">
<input type="hidden" name="questionId" value=""/>
<table class="table2" cellspacing="1">
<tbody>
<tr>
    <td>{'CrudForm_Title'|lang}: </td>
    <td><input type="text" class="input_text_large" name="title" value="" /></td>
</tr>
<tr>
    <td>{'CrudForm_Short_description'|lang}: </td>
    <td><textarea class="textarea_large tinyMce" name="shortDescription" cols="50" rows="5" id="shortDescription"></textarea></td>
</tr>
<tr>
    <td>{'CrudForm_Long_description'|lang}: </td>
    <td><textarea class="textarea_large tinyMce" name="longDescription" cols="50" rows="5" id="longDescription"></textarea></td>
</tr>
<tr>
    <td>{'CrudForm_Price'|lang}: </td>
    <td><input type="text" class="input_text_small" name="price" value="" /></td>
</tr>
<tr>
    <td>{'CrudForm_Additional_price'|lang}: </td>
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
    <td></td>
    <td>
    
    {if $edit}
    <input type="submit" class="btn btn-success mr-2" value="Valider" />
    <input type="button" class="btn btn-danger" value="Supprimer" onclick="if (confirm('Do you really want to delete it?')) window.location.href = AppRouter.getRewrittedUrl('/voyantPanel/voyantQuestion/delete/{$voyantQuestion.questionId}');"  />
    {else}
    <input type="submit" class="btn btn-success" value="Create Question" />
    {/if}
    </td>
</tr>
</tbody> 
</table>
</form>
</div>
<div class="title_h_1">
<h1>{if $edit}Edit {$voyantQuestion.title}{else}Create new voyant question{/if}</h1>
</div>

<div class="column_in_table2">
<form action="{'/admin/voyantQuestion/save'|url}" method="post" enctype="multipart/form-data" id="editVoyantQuestionForm">
<input type="hidden" name="questionId" value=""/>
<table class="table2" cellspacing="1">
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
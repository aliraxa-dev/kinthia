<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{'en'|lang}" lang="{'en'|lang}">
<head>
<title>{'mainLostPassword_lost_password_title'|lang}</title>
<meta name="description" content="{'mainLostPassword_lost_password_meta_description'|lang}" />
<meta name="robots" content="noindex, nofollow" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="{'/admin/templates/adrooo/stylecss/style.css'|resurl}" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="principal_login">

<div id="top_login">
</div>

<div id="main1">
<div id="main2">

<div id="left_login">
</div>

<div id="right">
</div>

<div id="middle_login"> 
<div class="column">

<div class="column_in_table_login">
<form action="{'/admin/main/lostPassword'|url}" method="post"> 
<table class="table_login" cellspacing="1">
<tbody>
<tr>
	<td class="td_login">{'E-mail'|lang}: </td>
	<td><input type="text" class="input_text_login" name="email" value="" /></td>
</tr>
<tr>
	<td class="td_login"></td>
	<td><input type="submit" class="button" value="Submit" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footerLogin.tpl'}  
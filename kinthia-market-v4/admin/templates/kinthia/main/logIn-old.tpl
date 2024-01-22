<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{'en'|lang}" lang="{'en'|lang}">
<head>
<title>{'mainLogIn_login_title'|lang}</title>
<meta name="description" content="{'mainLogIn_login_title'|lang}" />
<meta name="robots" content="noindex, nofollow" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="{'/admin/templates/kinthia/css/style.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/admin/javascript/main/loginOnLoad.js'|resurl}"></script> 
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
<form action="{'/admin/main/logIn'|url}" method="post">
<table class="table_login" cellspacing="1">
<tbody>
<tr>
	<td class="td_login">{'mainLogIn_login'|lang}: </td>
	<td><input type="text" class="input_text_login" name="login" value="" id="login" /></td>
</tr>
<tr>
	<td class="td_login">{'mainLogIn_password'|lang}: </td>
	<td><input type="password" class="input_text_login" name="password" value="" /></td>
</tr>
<tr>
	<td class="td_login"></td>
	<td><input type="submit" class="button" value="{'mainLogIn_loginin_button'|lang}" /> <input type="button" class="button2" value="{'mainLogIn_forgot_password'|lang}" id="forgotPassword" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footerLogin.tpl'}  
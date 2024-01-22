<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{$title}</title>
  <meta name="description" content="{$title}" />
  <meta name="robots" content="noindex, nofollow" />

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/fontawesome-free/css/all.min.css'|resurl}">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/dist/css/adminlte.min.css'|resurl}">
  {if isset($headData)}
  {$headData}{/if}
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/css/custom.css'|resurl}">
</head>
<!--
`body` tag options:

  Apply one or more of the following classes to to the body tag
  to get the desired effect

  * sidebar-collapse
  * sidebar-mini
-->
<body class="hold-transition sidebar-mini">
<div class="wrapper">
{include file='menu/menuheader/menuheader.tpl'}
{include file='menu/menuleft/menuleft.tpl'}
$(function() {

/* MENU LOGIN & MENU MAIN : OPEN/CLOSE */
$(".mobile-user-info").click(function() {
    if (!$("#nav-login").hasClass("open")) {
        $("#nav-login").addClass("open");
        $("#overlayFull").css("width","100%");
        $("#overlayFull").css("opacity","0.8");
    } else {
        $("#nav-login").removeClass("open");
        $("#overlayFull").css("width","0%");
        $("#overlayFull").css("opacity","0");
    }
});

$("#menu-mobile").click(function() {
    if (!$("#nav-main").hasClass("open")) {
        $("#nav-main").addClass("open");
        $("#overlayFull").css("width","100%");
        $("#overlayFull").css("opacity","0.8");
    } else {
        $("#nav-main").removeClass("open");
        $("#overlayFull").css("width","0%");
        $("#overlayFull").css("opacity","0");
    }
});

$(".close-k").click(function() {
    if ($("#nav-login").hasClass("open") || $("#nav-main").hasClass("open"))  {
        $("#nav-login").removeClass("open");
        $("#nav-main").removeClass("open");
        $("#overlayFull").css("width","0%");
        $("#overlayFull").css("opacity","0");
    }
});

$("#overlayFull").click(function() {
    if ($(this).css("width","100%")) {
        $("#nav-login").removeClass("open");
        $("#nav-main").removeClass("open");
        $("#overlayFull").css("width","0%");
        $("#overlayFull").css("opacity","0");
    }
});

/* MAIN MENU : SUBMENU OPEN/CLOSE */
$(".nav-main-sub").click(function() {
    if (!$(this).hasClass("open")) {
        $(this).addClass("open"); 
    } else {
        $(this).removeClass("open");
    }
});

/* STICKY HEADER */
$(window).scroll(function(){
    if ($(window).scrollTop() >= 1) {
        $('.header-nav').addClass('header-is-sticky');
        $("#header").css("padding-top","81px");
    }
    else {
        $('.header-nav').removeClass('header-is-sticky');
        $("#header").css("padding-top","0");
    }
});

/* BACK TO TOP */
$(window).scroll(function() {
    if ($(this).scrollTop() > 400) {
        $('#back-top').fadeIn();
    } else {
        $('#back-top').fadeOut();
    }
});

$('body').on('click', '#back-top', function() {
    $('body,html').animate({
        scrollTop: 0
    }, 800);
    return false;
});


});

    var settings = {};

    $.cookieMessage = function (options) {
        var defaults = {
            mainMessage: "",
            acceptButton: "OK",
            expirationDays: 30,
            cookieName: 'rgpdBar'
        };

        settings = $.extend( {}, defaults, options );
        ready();
    }

    function ready() {
        var coo = getCookie(settings.cookieName);
        if (coo != "true") {
            $(document).ready(function() {
                cookieMessageGenerate();
            })
        }
    }

    function setCookie(c_name, value, exdays) {
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
        document.cookie = c_name + "=" + c_value + "; path=/";
    }

    function getCookie(c_name) {
        var i, x, y, ARRcookies = document.cookie.split(";");
        for (i = 0; i < ARRcookies.length; i++) {
            x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
            y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
            x = x.replace(/^\s+|\s+$/g, "");
            if (x == c_name) {
                return unescape(y);
            }
        }
    }

    function cookieMessageGenerate() {
        var html = '<div id="c-cookies-bar">'+
            '<span class="msg">'+settings.mainMessage+
            '<a href="" class="btn-cookie btn purple c-cookie-btn-style">'+settings.acceptButton+'</a>'+
            '</span></div>';

        $("body").append(html);

        $("#c-cookies-bar a.btn-cookie").click( function(){
            var coo = setCookie(settings.cookieName, true, settings.expirationDays);
            $("#c-cookies-bar").remove();

            return false;
        });
    }

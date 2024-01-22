document.addEventListener("DOMContentLoaded", function(event) {
    var classname = document.querySelectorAll(".wep, .wepmenu, .sidr-class-wepmenu");
    for (var i = 0; i < classname.length; i++) {
        //left
        classname[i].addEventListener('click', myFunction, false);
        //right
        classname[i].addEventListener('contextmenu', myRightFunction, false);
    }
});
//left
var myFunction = function(event) {
    var attribute = this.getAttribute("data-wep");               
            if(event.ctrlKey) {                   
                 var newWindow = window.open(decodeURIComponent(window.atob(attribute)), '_blank');                    
                 newWindow.focus();               
            } else {                    
                 document.location.href= decodeURIComponent(window.atob(attribute));
            }
    };
//right
var myRightFunction = function(event) {
    var attribute = this.getAttribute("data-wep");               
        if(event.ctrlKey) {                   
             var newWindow = window.open(decodeURIComponent(window.atob(attribute)), '_blank');                    
             newWindow.focus();               
        } else {      
             window.open(decodeURIComponent(window.atob(attribute)),'_blank');  
        }
}

jQuery(document).ready(function(){
    //mobile menu
    jQuery(document).on('click contextmenu', "#sidr-main .wep, #sidr-main .wepmenu, #sidr-main .sidr-class-wepmenu", function(e){
        var attribute = this.getAttribute("data-wep");
        if(event.ctrlKey) {                   
            var newWindow = window.open(decodeURIComponent(window.atob(attribute)), '_blank');                    
            newWindow.focus();               
        }
        else{
            if(e.type == "click"){
                document.location.href= decodeURIComponent(window.atob(attribute));
            }
            else{
                window.open(decodeURIComponent(window.atob(attribute)),'_blank');
            }
        }
    });
    //summary category
    jQuery('#summary li span').click(function(){
        jQuery(this).next('ul').slideToggle('500');
        jQuery(this).find('i').toggleClass('fa-plus-circle fa-minus-circle')
    });
})
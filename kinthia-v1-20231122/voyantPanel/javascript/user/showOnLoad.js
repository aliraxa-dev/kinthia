(function($) {
    $(window).load(function () {
        //Magnific popup
        $('.popup-gallery').magnificPopup({
            delegate: 'a',
            type: 'image',
            tLoading: 'Loading image #%curr%...',
            mainClass: 'mfp-img-mobile',
            gallery: {
                enabled: true,
                navigateByImgClick: true,
                preload: [0,1] // Will preload 0 - before current, and 1 after the current image
            },
            image: {
                tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
                titleSrc: function(item) {
                    return item.el.attr('title');
                }
            }
        });
   });
});
$(document).ready(function(){

    $("a.dialog").each(function(){
        $this = $(this);
        $this.click(function(){
            var link = this;
            $.popup.open(link.href, $(link).attr("title"));
            
            return false;
        });
    });
    
    var commentEditor = new CommentEditor();
     
    // $(".commentReply").click(function(){
    //     alert('asdf');
    // });  
});
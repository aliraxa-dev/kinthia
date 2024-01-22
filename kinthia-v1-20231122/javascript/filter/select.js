(function($) {
    $.fn.selectUl = function(){
        var $origSelect = $(this);
        var newId = $(this).attr('name') + '-ul';
        var numOptions = $(this).children().length;
        
        $('<ul id="' + newId + '" class="plainSelect" />')
            .insertAfter($(this));
        $('<li class="guidance" />')
            .text($(this).attr('title'))
            .appendTo('#' + newId);
        
        for (var i = 0; i < numOptions; i++) {
            var text = $(this).find('option').eq(i).text();
           $('<li />').text(text).appendTo('#' + newId);
        }
        
        if ($(this).find('option:selected')) {
            var selected = $(this).find('option:selected').index();
            $('#' + newId)
                .find('li')
                .not(':eq(' + selected + 1 + '), .guidance')
                .addClass('unselected');
        }
        
        $('#' + newId + ' li')
            .hover(
                function(){
                    $(this).click(
                        function(){
                            var newSelect = $(this).index() - 1;
                            $(this)
                                .parent()
                                .find('.unselected')
                                .removeClass('unselected');
                            $(this)
                                .parent()
                                .find('li')
                                .not(this)
                                .not('.guidance')
                                .addClass('unselected');
                            $($origSelect)
                                .find('option:selected')
                                .removeAttr('selected');
                            $($origSelect)
                                .find('option:eq(' + newSelect +')')
                                .attr('selected',true);
                        });
                },
                function(){
            });
                    // assuming that you don't want the 'select' visible:
                    //$(this).hide();
        
        return $(this);
    }
        })(jQuery);


$('.makePlain').selectUl();
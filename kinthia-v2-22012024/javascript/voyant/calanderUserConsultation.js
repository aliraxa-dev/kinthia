$(document).ready(function(){ 
  $("span").click(function(){
      var type = $(this).data("boxtype");
      if(type=='present'){
          var dragOption = {
            delay: 10,
            distance: 5,
            opacity: 0.45,
            revert: "invalid",
            revertDuration: 100,
            start: function(event, ui) {  alert('asdf');
              $(".ui-selected").each(function() {
                $(this).data("original", $(this).position());
              });
            },
            drag: function(event, ui) { 
              var offset = ui.position;
              $(".ui-selected").not(this).each(function() {
                var current = $(this).offset(),
                  targetLeft = document.elementFromPoint(current.left - 1, current.top),
                  targetRight = document.elementFromPoint(current.left + $(this).width() + 1, current.top);
                $(this).css({
                  position: "relative",
                  left: offset.left,
                  top: offset.top
                }).data("target", $.unique([targetLeft, targetRight]));
              });
            },
            stop: function(event, ui) {
              $(".ui-selected").not(this).each(function() {
                var $target = $($(this).data("target")).filter(function(i, elm) {
                  return $(this).is(".slot") && !$(this).has(".item").length;
                });
                if ($target.length) {
                  $target.append($(this).css({
                    top: 0,
                    left: 0
                  }))
                } else {
                  $(this).animate({
                    top: 0,
                    left: 0
                  }, "slow");
                }

              });
              $(".ui-selected").data("original", null)
                .data("target", null)
                .removeClass("ui-selected");
            }
          },
          dropOption = {
            accept: '.item',
            activeClass: "green3",
            drop: function(event, ui) {
              if ($(this).is(".slot") && !$(this).has(".item").length) {
                $(this).append(ui.draggable.css({
                  top: 0,
                  left: 0
                }));
              } else {
                ui.draggable.animate({
                  top: 0,
                  left: 0
                }, 50);
              }
            }
          }

        $(".box").selectable({ 
          filter: ".item",
          start: function(event, ui) {
            $(".ui-draggable").draggable("destroy");
          },
          stop: function(event, ui) {
            $(".ui-selected").draggable(dragOption)
            
                  var arrDate = [];
                  var arrTimeSlot = [];
                  var arrDataId = [];
                  var arr = [];
                  var checkTimeSlot;

                 $(".ui-selected").each(function() {
                  arrDate.push($(this).data('date'));
                  arrTimeSlot.push($(this).data('sector'));
                  arrDataId.push($(this).data('id'));
                  $("#timeslots").val(arrTimeSlot);
                  $("#slotID").val(arrDataId);
                  $("#schedule_date").val(arrDate[0]);
                  $("#type").val('present');
                    checkTimeSlot = $(this).data('timeslot');
                  }); 
                 
                 if(checkTimeSlot=='empty'){
                    var form = document.getElementById('saveCalanderForm');
                    $.ajax({
                        url: form.action,
                        type: form.method,
                        data: $(form).serialize(),
                        //dataType: 'json',
                        success: function(response) {
                         
                           swal({
                                title: "Success",
                                text: response,
                                icon: "success",
                               
                              }).then(function(isConfirm) {
                                if (isConfirm) {
                                  location.reload();
                                }
                              });
                        }
                    });
                 }else{
                  swal("Selected time slot has already booked on particular date. Please choose another time slot.");
                 }      
          }
        });
        $(".slot").droppable(dropOption);
      }else{
        //Type for absent...
           var dragOption = {
            delay: 10,
            distance: 5,
            opacity: 0.45,
            revert: "invalid",
            revertDuration: 100,
            start: function(event, ui) { 
              $(".ui-selected").each(function() {
                $(this).data("original", $(this).position());
              });
            },
            drag: function(event, ui) { 
              var offset = ui.position;
              $(".ui-selected").not(this).each(function() {
                var current = $(this).offset(),
                  targetLeft = document.elementFromPoint(current.left - 1, current.top),
                  targetRight = document.elementFromPoint(current.left + $(this).width() + 1, current.top);
                $(this).css({
                  position: "relative",
                  left: offset.left,
                  top: offset.top
                }).data("target", $.unique([targetLeft, targetRight]));
              });
            },
            stop: function(event, ui) {
              $(".ui-selected").not(this).each(function() {
                var $target = $($(this).data("target")).filter(function(i, elm) {
                  return $(this).is(".slot") && !$(this).has(".item").length;
                });
                if ($target.length) {
                  $target.append($(this).css({
                    top: 0,
                    left: 0
                  }))
                } else {
                  $(this).animate({
                    top: 0,
                    left: 0
                  }, "slow");
                }

              });
              $(".ui-selected").data("original", null)
                .data("target", null)
                .removeClass("ui-selected");
            }
          },
          dropOption = {
            accept: '.item',
            activeClass: "green3",
            drop: function(event, ui) {
              if ($(this).is(".slot") && !$(this).has(".item").length) {
                $(this).append(ui.draggable.css({
                  top: 0,
                  left: 0
                }));
              } else {
                ui.draggable.animate({
                  top: 0,
                  left: 0
                }, 50);
              }
            }
          }

        $(".box").selectable({ 
          filter: ".item",
          start: function(event, ui) {
            $(".ui-draggable").draggable("destroy");
          },
          stop: function(event, ui) {
            $(".ui-selected").draggable(dragOption)
            
                  var arrDate = [];
                  var arrTimeSlot = [];
                  var arrDataId = [];
                  var arr = [];
                  var checkTimeSlot;

                  $(".ui-selected").each(function() {
                      arrDate.push($(this).data('date'));
                      arrTimeSlot.push($(this).data('sector'));
                      arrDataId.push($(this).data('id'));
                      $("#timeslots").val(arrTimeSlot);
                      $("#slotID").val(arrDataId);
                      $("#schedule_date").val(arrDate[0]);
                      $("#type").val('absent');
                  }); 
                                 
                  var form = document.getElementById('saveCalanderForm');
                  $.ajax({
                      url: form.action,
                      type: form.method,
                      data: $(form).serialize(),
                      //dataType: 'json',
                      success: function(response) {
                          swal({
                            title: "Success",
                            text: response,
                            icon: "success",
                           
                          }).then(function(isConfirm) {
                            if (isConfirm) {
                              location.reload();
                            }
                          });
                      }
                  });     
          }
        });
        $(".slot").droppable(dropOption);
      }
  });
});

function getSelect(type){
    if(type != ''){
      $("#consultType").val(type);
      var form = document.getElementById('updateStatus');
        $.ajax({
          url: form.action,
          type: form.method,
          data: $(form).serialize(),
          dataType: 'json',
          success: function(response) {
            //alert();
          }
      });
    }
}




 









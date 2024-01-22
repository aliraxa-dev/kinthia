
$(document).ready(function($){

  $('.live-search-list .side-r-experts ').each(function(){
  $(this).attr('data-search-term', $(this).text().toLowerCase());
  });

  $('.live-search-box').on('keyup', function(){
  var searchTerm = $(this).val().toLowerCase();

      $('.live-search-list .side-r-experts').each(function(){
          if ($(this).filter('[data-search-term *= ' + searchTerm + ']').length > 0 || searchTerm.length < 1) {
            $(this).show();
          }
          else {
              $(this).hide();
          }
      });
  });

  /* DESCRIPTION : OPEN/CLOSE */
  $(".expert-text-description-expander").click(function() {
    if ($(".expert-text-description").hasClass("reduced")) {
        $(".expert-text-description").removeClass("reduced");
        $(".expert-text-description-expander").addClass("d-none");
    }
  });

  /* SEND MESSAGE : OPEN/CLOSE */
  $(".expert-details-display-msg").click(function() {
      if (!$(".expert-details-message-box").hasClass("open")) {
          $(".expert-details-message-box").addClass("open");
      } else {
          $(".expert-details-message-box").removeClass("open");
      }
  });

  $(".expert-details-display-msg").click(function() {
     $(".expert-details-display-msg-to-display").slideToggle("100");
  });


  /* REPORT : OPEN/CLOSE */
  $(".expert-details-display-report").click(function() {
      if (!$(".expert-details-report").hasClass("open")) {
          $(".expert-details-report").addClass("open");
      } else {
          $(".expert-details-report").removeClass("open");
      }
  });

  $(".expert-details-display-report").click(function() {
     $(".expert-details-display-report-to-display").slideToggle("100");
  });

});


$(document).ready(function(){


    $("select[name=priceId]").each(function(){
        var $this = $(this);
        $this.change(function(){
          var $this = $(this);
          var $parent = $this.parent();
          var questionId = $parent.find("input[name=questionId]").val();
          var selectedIndex = $this.attr("selectedIndex");

          var prices = setting.questionPrices[questionId];
          var currentPrice = prices[selectedIndex];
          var standardPrice = prices[0];

          var normalPriceTotalPrice = standardPrice.price * currentPrice.quantity;
          var saveValue = currentPrice.price - normalPriceTotalPrice;
          var savePercentage = Math.round(saveValue * 100 / normalPriceTotalPrice);

          var $div = $parent.parent();
          var $reductionDiv = $div.find("div.column_in_box_voyant_question_list_price_reduction"
                                       + ", div.column_in_box_question_detail_price_reduction");

          if (saveValue == 0) {
              $reductionDiv.hide();
          } else {
              $reductionDiv.text(savePercentage + "%").show();
          }

          $div.find("div.column_in_box_voyant_question_list_price_total"
                    + ", div.column_in_box_question_detail_price_total").text(currentPrice.price + " €");
        });
    });

    $("img.image_caddie, img.image_caddie_question_detail").click(function(){
        var $parent = $(this).parent();
        var priceId = $parent.find("select[name=priceId]").val();
        var questionId = $parent.find("input[name=questionId]").val();
        var url = AppRouter.getRewrittedUrl("/cart/addItem/" + questionId + "/" + priceId);
        $.popup.open(url, _t("You just add to cart the next product"), {width: 800});
        return false;

    });

    $("img.image_caddie, img.image_caddie_question_detail").click(function()
    {
        var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
        progress.dialog("open");

        $.popup.open(
            this.href,
            this.title,
        );
        setTimeout ( function(){
            progress.dialog("close");
        }, 1000 );

        return false;
    });


/* ADD TO CART WITH BUTTON */
  $(".add-to-cart").click(function() {
      var $parent = $(this).parent();
      var priceId = $parent.find("select[name=priceId]").val();
      var questionId = $parent.find("input[name=questionId]").val();
      var url = AppRouter.getRewrittedUrl("/cart/addItem/" + questionId + "/" + priceId);
      $.popup.open(url, _t("You just add to cart the next product"), {width: 800});
      return false;
    });

  $(".add-to-cart").click(function(){
      var progress = $("<div title='" + _t("Loading") + "'>" +
          "<p style='text-align:center;font-size:1.6em'><br/>" +
          "<b>" + _t("Loading...") + "</b><br>" +
          "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
          "</div>")
          .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
      progress.dialog("open");

      $.popup.open(
          this.href,
          this.title,
      );
      setTimeout ( function(){
          progress.dialog("close");
      }, 1000 );

      return false;
  });

/* SCROLL TO QUESTION LIST */
$("#scroll-to-question-list").click(function() {
    $([document.documentElement, document.body]).animate({
        scrollTop: $("#article-to-buy").offset().top
    }, 1000);
});

   $(".typ").click(function()
    {
        /*var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
        progress.dialog("open");*/

        $.popup.open(
            this.href,
            this.title,
        );
        /*setTimeout ( function(){
            progress.dialog("close");
        }, 800 );*/

        return false;
    });


//Calander....
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
          // var userId =  $("#sessuserId").val();
          // if(userId != ""){
              $(".ui-selected").each(function() {
                var selectedSlots = $(this).hasClass("selected");
                if(selectedSlots){
                $(this).removeClass("selected");

                  checkTimeSlot = $(this).data('timeslot');
                  if(checkTimeSlot=='booked'){
                    $(".ui-selected").addClass("ui-booking");
                      arrDate.push($(this).data('date'));
                      arrTimeSlot.push($(this).data('sector'));
                      arrDataId.push($(this).data('id'));

                      $("#timeslots").val(arrTimeSlot);
                      $("#slotID").val(arrDataId);
                      $("#schedule_date").val(arrDate[0]);
                      $("#userId").val(userId);
                  }
                 }else{
                  $(this).addClass("absentCls");
                }
              });
          // }else{
          //   if(swal("Please Registerd and login.")){
          //     window.location.href="/abvoyance/user/main/logIn";
          //   }
          // }

          // var form = document.getElementById('saveUserBookingForm');
          // $.ajax({
          //     url: form.action,
          //     type: form.method,
          //     data: $(form).serialize(),
          //     //dataType: 'json',
          //     success: function(response) {
          //        swal(response);
          //     }
          // });
    }
  });
  $(".slot").droppable(dropOption);
  //Calander js end...

  /* Function to check expert status*/
  if($(".expert-detail-ul-consultation").length > 0){
    var intervalId = window.setInterval(function(){
      $.ajax({
        dataType: "json",
        url: AppRouter.getRewrittedUrl('/voyant/status/' + voyantId),
        success: function (data) {
          toggleExpertStatus(data);
        }
      });
    }, availabilityRefreshRate*1000);
  }
});

function goli(packageId){
   if(packageId != ""){
        var url = AppRouter.getRewrittedUrl("/cart/addPack/" + packageId);
        $.popup.open(url, _t("You just add to cart the next product"), {width: 800});
        return false;
   }
}

/* Load more review on voyant detail page */
var page = 1;
function loadMoreReviews(voyantId, reviewLimit = 10){
  $.ajax({
    dataType: "json",
    url: AppRouter.getRewrittedUrl('/voyant/review/' + voyantId + '/' + page + '/' + reviewLimit),
    success: function (data) {
      html = render(data);
      $(".review-container").append(html);
      page++;
    }
  });
}
function render(data){
  var i;
  var result = "";
  if(data.length == '0'){
    $("#more-review").hide();
    result = '<div class="text-center">No More Reviews</div>';
  }
  else{
    for (i = 0; i < data.length; ++i) {
      console.log(data[i]);
      result += '<div class="expert-details-review-container">';

      if(data[i].type == 'W') result += '<i class="fas fa-video"></i>';
      else if(data[i].type == 'Q') result += '<span class="review-type"><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16"><path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"/></svg></span>';
      else if(data[i].type == 'P') result += '<span class="review-type"><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/></svg></span>';
      else if(data[i].type == 'E') result += '<span class="review-type"><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16"><path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"/></svg></span>';
      else if(data[i].type == 'E') result += 'N/A';

      result += '<span class="review-pseudo">' + data[i].name + '</span>';
      result += '<span class="review-date">' + data[i].date + '</span>';

      result += '<span class="review-start float-right">';
      if(data[i].rating==1) result += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>';
      else if(data[i].rating==2) result += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>';
      else if(data[i].rating==3) result += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>';
      else if(data[i].rating==4) result += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>';
      else if(data[i].rating==5) result +='<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>';
      result += "</span>";


      result += '<div class="review-txt">' + data[i].text + '</div>';

      if(data[i].replyText) result += '<div class="review-txt-answer"><div class="review-answer-pseudo">Réponse de <span>' + data[i].headerDescription + '</span></div><div class="review-answer-msg">' + data[i].replyText + '</div></div>';

      result += '</div>';
    }
  }

  return result;
}

function togglePlay() {
  var audio = document.getElementById("voyant-presentation");
  if (audio) {
    if (audio.paused) {
        // Play the audio if it's paused or stopped
        audio.play();
        $(".player #button").html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.25 5C5.56 5 5 5.56 5 6.25v3.5a1.25 1.25 0 1 0 2.5 0v-3.5C7.5 5.56 6.94 5 6.25 5zm3.5 0c-.69 0-1.25.56-1.25 1.25v3.5a1.25 1.25 0 1 0 2.5 0v-3.5C11 5.56 10.44 5 9.75 5z"/></svg>');
    } else {
        // Stop the audio if it's played
        audio.pause();
        $(".player #button").html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.79 5.093A.5.5 0 0 0 6 5.5v5a.5.5 0 0 0 .79.407l3.5-2.5a.5.5 0 0 0 0-.814l-3.5-2.5z"/></svg>');
    }

    audio.onended = function(){
      $(".player #button").html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.79 5.093A.5.5 0 0 0 6 5.5v5a.5.5 0 0 0 .79.407l3.5-2.5a.5.5 0 0 0 0-.814l-3.5-2.5z"/></svg>');
    };
  }
}

function toggleExpertStatus(data){
  if(data.consultationStatus === "") return;
  if(data.consultationStatus != consultationStatus) location.reload();

  if(data.displayPhone === null) data.displayPhone = "";
  if(data.displayPhone !== displayPhone) location.reload();

  if(data.displayWebcam === null) data.displayWebcam = "";
  if(data.displayWebcam !== displayWebcam) location.reload();

  if(data.displayEmail === null) data.displayEmail = "";
  if(data.displayEmail !== displayEmail) location.reload();

  if(data.displayChat === null) data.displayChat = "";
  if(data.displayChat !== displayChat) location.reload();
}

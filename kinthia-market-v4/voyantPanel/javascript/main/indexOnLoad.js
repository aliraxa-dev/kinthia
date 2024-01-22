$(document).ready(function(){
    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    })

     //-------------
    //- DONUT CHART -
    //-------------
    // Get context with jQuery - using jQuery's .get() method.
    var donutChartCanvas = $('#donutChart').get(0).getContext('2d')

    console.log(donutChartCanvas.canvas.attributes['data-id1']['value']);
    let webcam=donutChartCanvas.canvas.attributes['data-id']['value'];
    let telphone=donutChartCanvas.canvas.attributes['data-id1']['value'];
    let quaestion=donutChartCanvas.canvas.attributes['data-id2']['value'];
    var donutData = {
      labels: [
          'Question',
          'Téléphone',
          'Webcam',
      ],
      datasets: [
        {
          data: [quaestion,telphone,webcam],
          backgroundColor : ['#f56954', '#7bb557', '#965991'],
        }
      ]
    }
    var donutOptions     = {
      maintainAspectRatio : false,
      responsive : true,
    }
    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.
    new Chart(donutChartCanvas, {
      type: 'doughnut',
      data: donutData,
      options: donutOptions
    })

    //Display phone or not...
    var switchStatus = false;
    var display;
    var form1 = document.getElementById('frmPhone');
    $("#displayPhone").on('change', function() { console.log('>>>clicked on phone');
        name = 'displayPhone';
        if ($(this).is(':checked')) {

            switchStatus = $(this).is(':checked');
              display = 1;
        }
        else {
           switchStatus = $(this).is(':checked');
           display = 0;
        }
        
        if(name != ''){
          $.ajax({
              url: form1.action,
              type: form1.method,
              data: {display:display, name:name},
              dataType: 'json',
              success: function(response) {                   
                if(response == 1){
                 var htmldialog = $("<div title='" + _t("activated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Phone consultation activated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
  
                }else{
                  var htmldialog = $("<div title='" + _t("deactivated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Phone consultation deactivated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                }
                htmldialog.dialog("open");
              }
          });
        }
    });

    //Display webcam or not...
    var form2 = document.getElementById('frmWebcam');
    $("#displayWebcam").on('change', function() { console.log('>>>clicked on webcam');
        name = 'displayWebcam';
        if ($(this).is(':checked')) {
            switchStatus = $(this).is(':checked');
              display = 1;
        }
        else {
           switchStatus = $(this).is(':checked');
           display = 0;
        }
      console.log('>>>display webcam', display);
        if(name != ''){
          $.ajax({
              url: form2.action,
              type: form2.method,
              data: {display:display, name:name},
              dataType: 'json',
              success: function(response) {                   
                if(response == 1){
                 var htmldialog = $("<div title='" + _t("activated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Webcam consultation activated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
  
                }else{
                  var htmldialog = $("<div title='" + _t("deactivated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Webcam consultation deactivated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                }
                htmldialog.dialog("open");
              }
          });
        }
    });

    //Display email or not...
    var form3 = document.getElementById('frmEmail');
    $("#displayEmail").on('change', function() { console.log('>>>clicked on email');
        name = 'displayEmail';
        if ($(this).is(':checked')) {
            switchStatus = $(this).is(':checked');
              display = 1;
        }
        else {
           switchStatus = $(this).is(':checked');
           display = 0;
        }
      
        if(name != ''){
          $.ajax({
              url: form3.action,
              type: form3.method,
              data: {display:display, name:name},
              dataType: 'json',
              success: function(response) {                   
                if(response == 1){
                 var htmldialog = $("<div title='" + _t("activated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Email consultation activated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
  
                }else{
                  var htmldialog = $("<div title='" + _t("deactivated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Email consultation deactivated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                }
                htmldialog.dialog("open");
              }
          });
        }
    });
        //Vacance mode...
    var form4 = document.getElementById('frmVacances');
    $("#vacances").on('change', function() { console.log('>>>clicked on vacances');
        name = 'available';
        if ($(this).is(':checked')) {
          $('#displayEmail').prop('checked', false);
           $('#displayWebcam').prop('checked', false);
            $('#displayPhone').prop('checked', false);
             $('#displayEmail').prop('disabled', true);
           $('#displayWebcam').prop('disabled', true);
            $('#displayPhone').prop('disabled', true);
            switchStatus = $(this).is(':checked');
              display = 0;
        }
        else {
          $('#displayEmail').prop('disabled', false);
           $('#displayWebcam').prop('disabled', false);
            $('#displayPhone').prop('disabled', false);
           switchStatus = $(this).is(':checked');
           display = 1;
        }
      
        if(name != ''){
          $.ajax({
              url: form4.action,
              type: form4.method,
              data: {display:display, name:name},
              dataType: 'json',
              success: function(response) {                   
                if(response == 1){
                 var htmldialog = $("<div title='" + _t("deactivated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("vacation mode deactivated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
  
                }else{
                  var htmldialog = $("<div title='" + _t("activated") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("vacation mode activated!") + "</b><br>" +
      "</p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                }
                htmldialog.dialog("open");
              }
          });
        }
    });  

});

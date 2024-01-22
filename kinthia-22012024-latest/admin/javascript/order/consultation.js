$(function() {
    let urlParams = new URLSearchParams(window.location.search);
    let config = {
        locale: {
            format: 'YYYY-MM-DD',
             cancelLabel: 'Clear'
        },
        maxDate: moment()
    };
    if( urlParams.has('start_date') &&  urlParams.has('end_date')){
        config.startDate = urlParams.get('start_date');
        config.endDate = urlParams.get('end_date');
    }
    $('#reservation').daterangepicker(config);

    $('.update-status').on('click', function() {

        var dateRange = $('#reservation').val();
        console.log(dateRange);
        var start = dateRange.split(" - ")[0]
        var end = dateRange.split(" - ")[1]
        window.location = `/admin/order/consultation/?start_date=${start}&end_date=${end}`;
        // Get the selected date range
        
    });
});

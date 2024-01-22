$(document).ready(function () {
    function getTimestampInSeconds() {
        return Math.floor(Date.now() / 1000)
    }

    var startTime = $("#startConsultTime").val();

    function hmsToSeconds(h, m, s) {
        return h * 3600 + m * 60 + (+s || 0);
    }

    function secondsToHMS(secs) {
        function z(n) { return (n < 10 ? '0' : '') + n; }
        var sign = secs < 0 ? '-' : '';
        secs = Math.abs(secs);
        return sign + z(secs / 3600 | 0) + ':' + z((secs % 3600) / 60 | 0) + ':' + z(secs % 60);
    }

    function currentTime() {
        var totTime = secondsToHMS(Math.abs(getTimestampInSeconds() - parseInt(startTime)));

        $(".clock_" + $(vid).val()).text(totTime);
        let t = setTimeout(function () { currentTime() }, 1000);
    }
    currentTime();

    /* Function to count down max expert time */
    var clock;
    var x;
    if (consultationStatus == "B") {
        $.ajax({
            url: "/cart/getMaxUserCreditTime/" + voyantId,
            dataType: 'json',
            success: function (response) {
                if (typeof response.totalTime !== 'undefined') {
                    var countDownDate = new Date(Date.now() + (response.totalTime * 60 * 1000)).getTime();
                    updateRemainingTime(countDownDate - 1);
                    // Update the count down every 1 second
                    x = setInterval(function () {
                        updateRemainingTime(countDownDate);
                    }, 1000);
                }
            }
        });
    }

    function updateRemainingTime(countDownDate) {
        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var hours = padWithLeadingZeros(Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)), 2);
        var minutes = padWithLeadingZeros(Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)), 2);
        var seconds = padWithLeadingZeros(Math.floor((distance % (1000 * 60)) / 1000), 2);

        clock = `${hours}:${minutes}:${seconds}`;
        $(".expert-status-time-remaining .clock").html(clock);

        // If the count down is finished, write some text
        if (distance < 0) {
            clearInterval(x);
            $(".expert-status-time-remaining .clock").html("End");
        }
    }

    function padWithLeadingZeros(num, totalLength) {
        return String(num).padStart(totalLength, '0');
    }
});

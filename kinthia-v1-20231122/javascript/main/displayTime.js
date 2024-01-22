$(document).ready(function() {
    function hmsToSeconds(h,m,s) {
        return h*3600 + m*60 + (+s || 0);                                             
    }
    
    function secondsToHMS(secs) {
      function z(n){return (n<10?'0':'') + n;}
      var sign = secs < 0? '-':'';
      secs = Math.abs(secs);
      return sign + z(secs/3600 |0) + ':' + z((secs%3600) / 60 |0) + ':' + z(secs%60);
    } 
    
   function changeTimezone(date, ianatz, value) {
      var invdate = new Date(date.toLocaleString('en-US', {
        timeZone: ianatz
      }));

      var returnValue;
      if(value=='hour'){
          returnValue = invdate.getHours();
      }

      if(value=='minute'){
          returnValue = invdate.getMinutes();
      }
      if(value=='second'){
          returnValue = invdate.getSeconds();
      }

      return returnValue;
}  
   
    //console.warn("voyantIdArr>>",voyantIdsArr.voyantIdArr);
    for (let i = 0; i < voyantIdsArr.voyantIdArr.length; i++) {
        //console.log("loop>>>", voyantIdsArr.voyantIdArr[i]);
        let cHour = $(".cHour_"+voyantIdsArr.voyantIdArr[i]).val();
        let cMin = $(".cMin_"+voyantIdsArr.voyantIdArr[i]).val();
        let cSec = $(".cSec_"+voyantIdsArr.voyantIdArr[i]).val();

        function currentTime() {
              let d = new Date(); 
              let hh = changeTimezone(d, "UTC" , "hour");
              let mm = changeTimezone(d, "UTC" , "minute");
              let ss = changeTimezone(d, "UTC" , "second"); 
              let session = "AM";

              if(hh === 0){
                  hh = 12;
              }

              if(hh > 12){
                  hh = hh - 12;
                  session = "PM";
              }

            hh = (hh < 10) ? "0" + hh : hh;
            mm = (mm < 10) ? "0" + mm : mm;
            ss = (ss < 10) ? "0" + ss : ss;
                
            let currtime = hh + ":" + mm + ":" + ss;
            let vid = $("#vid").val();
            var totTime = secondsToHMS(hmsToSeconds(hh,mm,ss) - hmsToSeconds(cHour,cMin,cSec));
            //document.getElementById("clock").innerText = totTime;
            $(".clock_"+voyantIdsArr.voyantIdArr[i]).text(totTime);
            let t = setTimeout(function(){ currentTime() }, 1000);
        }
       currentTime();
    }
});

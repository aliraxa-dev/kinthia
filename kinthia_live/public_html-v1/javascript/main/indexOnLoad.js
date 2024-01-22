var filterArray = [];

function filterByInput () {
    var voyantName = $('#inputvoyantName').val();
    $('#inputvoyantName').val('');

    if (!voyantName) return;
    
    if(voyantName.length < 3){
        console.log(voyantName.length);
        return;
    }

    var filtered = filterArray.filter(function (el) {
        return el.type === "voyantName";
    });

    if (!filtered.length) {
        filterArray.push({
            type: "voyantName",
            content: voyantName
        })
        $('.searchengine-filter').show();
    } else {
        var index = filterArray.indexOf(filtered[ 0 ]);
        filterArray[ index ].content = voyantName;
    }
    
    reloadActiveFilter(filterArray);
}

function getConsultOption(consultId) {
    $('#consultation_data_' + consultId).on( 'change', function ( e ) {
        var checkBox = $(this);
        var consultName = $('#consultation_data_' + consultId).attr('data-cons');
        if (checkBox.is(':checked')) {
            if (!filterArray.length) {
                $('.searchengine-filter').show();
            }
            filterArray.push({
                type: "consultation",
                content: consultName,
                consultId: consultId
            });
        } else {
            var index = filterArray.map(el => {
                if (el.type === "consultation") {
                    return el.content;
                }
            }).indexOf(consultName);
            removeFilter(index)
        }

        reloadActiveFilter( filterArray );
        console.log('check status: ', filterArray);
        checkBox.off( 'change' );
    });
}

function reloadActiveFilter(filterarr) {
    $('.active-filter-items').empty();
    $('.ajax-list-loader').show();
    for (var index = 0; index < filterarr.length; index++) {
        var filterItemContent = '<div class="filter-item active category-filter-item" onclick=removeFilter(' + index + ')>' + 
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        $('.active-filter-items').append(filterItemContent);
    }

    // DO AJAX
    $.ajax({
        url: 'main/expertlist',
        type: 'post',
        dataType: 'html',
        data: { filterCriteria: filterarr },
        success: function(response) {
            setTimeout( function() {
                $("#expert-list-container").html(response);
                $('.ajax-list-loader').hide();
            }, 700 );
        }
    });

}

function removeFilter( index ) {
    if (filterArray[ index ].consultId) {
        $('#consultation_data_' + filterArray[ index ].consultId).prop('checked', false);
    }
    filterArray.splice( index, 1 );
    if (!filterArray.length) {
        removeAllFilters()
    } else {
        reloadActiveFilter( filterArray );
    }
}

function removeAllFilters() {
    filterArray.map( el => {
        if (el.type === "consultation") {
            $('#consultation_data_' + el.consultId).prop('checked', false);
        }
    } );

    filterArray = [];
    $('.searchengine-filter').hide();
    reloadActiveFilter(filterArray);
}

function fetch_sort(val1) {
    var form = document.getElementById('sortFrm');
    $("#sortValues").val(val1);
    $('.ajax-list-loader').show();
    
    $.ajax({
        url:form.action,
        type: form.method,
        data: {
            sortValues: val1,
            filterCriteria: filterArray
        },
        dataType: 'html',
        success: function(response) {
            setTimeout( function() {
                $("#expert-list-container").html(response);
                $('.ajax-list-loader').hide();
            }, 700);
        }
    });
}

function inputVoyantName() {
    var form = $('#inputVoyantForm');
    var name = $("#input-voyantname").val();

    $.ajax({
        url:form.action,
        type: form.method,
        data: $(form).serialize(),
        dataType: 'html',
        success: function(response) {
            $("#asdf").html(response);
        }
    });
}

function getLogin()
{
  $.ajax({
    
    
    //dataType: 'json',
    success: function(response) {
      swal({
        icon: 'error',
        title: 'Please Login your Account...',
      
         
      })
    }
});    

}

function userFav(voyantId,userId){
     
         
    if(voyantId != "") {
        $("#voyantId").val(voyantId);
        $("#userId").val(userId);
             
            var form = document.getElementById('voyantFrm');
           
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(data) {
                       
                   
                    if (data == "added"){
                        $("#infav_"+voyantId).css('fill','#ad3b3b');
                        $("#infav_"+voyantId).attr("title","Supprimer le favoris");
                    } else {
                        $("#infav_"+voyantId).css('fill','#333');
                        $("#infav_"+voyantId).attr("title","Make favoris");
                    }

                }
            });
            
        }
    
}

 
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('.searchengine-filter').hide();

    // ajax for the default sorting of the list
    $.ajax({
        url: 'main/expertlist',
        type: 'post',
        dataType: 'html',
        data: {sortValues: 'default'},
        success: function(response) {
            setTimeout( function() {
                $("#expert-list-container").html(response);
            }, 700 );
        }
    });

    $('#inputvoyantName').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13') {
            filterByInput();
        }
    });

    $("#startConsultation").click(function()
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
        }, 800 );

        return false;
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
});

function deleteAllSkill() {
   
    document.getElementById("activefiltersskill").innerHTML = "";
     
    $("[id^=skill_]").removeClass('active');    
    
    // window.location.reload();    
    }

    function deleteAllLang() {
   
        document.getElementById("activefilterslang").innerHTML = "";
        
        $("[id^=language_]").removeClass('active');    
        // window.location.reload();    
        }


        function deleteAllCons() {
   
            document.getElementById("activefilterscons").innerHTML = "";
            
            $("[id^=consultation_data_]").remove();  
       
            // window.location.reload();    
            }

            function deleteAllExperts() {
   
                document.getElementById("activefiltersexperts").innerHTML = "";
                
                $("[id^=expert_]").removeClass('active');    
                // window.location.reload();    
                }
        
        
  
    

    
var skillIds = [];
function getSkill(skillId){
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
	if(skillId != ''){
		$('.filter-item:hover').toggleClass('active');
		var selected_activities =$('.active');
		var classExist = document.getElementsByClassName('active');
        var activFilter = document.getElementById('activefilters');
        //push value if value not exist or delete value if value alredy exist
        if(!skillIds.includes(skillId)){
            skillIds.push(skillId);
        }else{
            const index = skillIds.indexOf(skillId);
            if (index > -1){
                skillIds.splice(index, 1);
                
                $("#skill_"+skillId).removeClass("active");                 
            }
        }
        if ( $(".filter-item").hasClass("active") ){
            //true: myID has select active
            $('#activefiltersskill').html("");
            skillIds.forEach(function(value,index){
                let skillValue = $("#skill_data_"+value).attr('data-skill');
                $('#activefiltersskill').append("<div onclick='getSkill("+value+")' class='category-filter-item  active'  id='"+value+"'><span>"+skillValue+"</span></div>")
            }) 
            $('#activefiltersskill').append("<div onclick='deleteAllSkill()' class='filter-reset' style='float:right'></div>")
        } else {
            window.location.reload();     
        }
	    if(skillIds != ""){
	    	$("#filterSkillIds").val(skillIds);  
		    var form = document.getElementById('filterSkillFrm');
    		$.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(response) {
                   $("#asdf").html(response);
                }
            });
	    }
	}
    
}

var landIds = [];
function getLanguage(languageId){
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
    if(languageId != ''){
		$('.filter-item:hover').toggleClass('active');
		var selected_activities =$('.active');
		var classExist = document.getElementsByClassName('active');
        var activFilter = document.getElementById('activefilters');
        //push value if value not exist or delete value if value alredy exist
        if(!landIds.includes(languageId)){
            landIds.push(languageId);
        }else{
            const index = landIds.indexOf(languageId);
            if (index > -1) {
                landIds.splice(index, 1);
                $("#language_"+languageId).removeClass("active"); 
            }
        }
        if ( $(".filter-item").hasClass("active") ){
            //true: myID has select active
            $('#activefilterslang').html("");
            landIds.forEach(function(value,index){
                let landValue = $("#language_data_"+value).attr('data-language');
                $('#activefilterslang').append("<div onclick='getLanguage("+value+")' class='category-filter-item  active'  id='"+value+"'><span>"+landValue+"</span></div> ")
            })
            $('#activefilterslang').append("<div onclick='deleteAllLang()' class='filter-reset' style='float:right'></div>") 
        } else {
            window.location.reload();
        }
	    if(landIds != "")
        {
            $("#filterLanguageIds").val(landIds);
            var form = document.getElementById('filterLanguageFrm');      
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(response) {
                    $("#asdf").html(response);
                }
            });
        }
	}
}

var consIds = [];
function getConsultation(consultationId) {
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
    if(consultationId != '')
    {
		$('.filter-item:hover').toggleClass('active');
		var selected_activities =$('.active');
		var classExist = document.getElementsByClassName('active');
        var activFilter = document.getElementById('active');
        //push value if value not exist or delete value if value alredy exist
        if(!consIds.includes(consultationId)) {
            consIds.push(consultationId);
        } else {
            const index = consIds.indexOf(consultationId);
            if (index > -1) {
                consIds.splice(index, 1);
               $("#consultation_data_"+consultationId).remove();
            }
        }

        if ( $(".filter-item").hasClass("active") ) {
            //true: myID has select active
            $('#activefilterscons').html("");
            consIds.forEach(function(value,index) {
                console.log("values:", value);
                let consValue = $("#consultation_data_"+value).attr('data-cons');
                $('#activefilterscons').append("<div onclick='getConsultation("+value+")'  class='category-filter-item  active'  id='"+value+"'><span>"+consValue+"</span></div> ")
            })
            $('#activefilterscons').append("<div onclick='deleteAllCons()' class='filter-reset' style='float:right'></div>")
        } else {
            //false: myID does not have class select  
            $("#"+consultationId).remove();
            window.location.reload();
        }
        if(consIds != "") {
            $("#filterConsultationIds").val(consIds);
            var form = document.getElementById('filterConsultationFrm');      
            
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(response) {
                    $("#asdf").html(response);
                }
            });
        }
	}
}


var expertValues = [];
function getExpert(expertValue)
{     
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
    if(expertValue != '') {
		$('.filter-item:hover').toggleClass('active');
		var selected_activities =$('.active');
		var classExist = document.getElementsByClassName('active');
        var activFilter = document.getElementById('active');

        //push value if value not exist or delete value if value alredy exist
        if(!expertValues.includes(expertValue)){
            expertValues.push(expertValue);
        }else{
            const index = expertValues.indexOf(expertValue);
            if (index > -1)
            {
                expertValues.splice(index, 1);
                $("#expert_"+expertValue).removeClass("active"); 
            }
        }
        if ( $(".filter-item").hasClass("active") ) {
            //true: myID has select active
            $('#activefiltersexperts').html("");
            expertValues.forEach(function(value,index) {
                let expValue = $("#expert_data_"+value).attr('data-expert');
                $('#activefiltersexperts').append("<div onclick=getExpert('"+value+"')  class='category-filter-item  active'  id='"+value+"'><span>"+expValue+"</span></div> ")
            })

            $('#activefiltersexperts').append("<div onclick='deleteAllExperts()' class='filter-reset' style='float:right'></div>")
        } else {
            //false: myID does not have class select 
            $("#"+expertValue).remove();
            window.location.reload();
        }
        if(expertValues != "") {
            $("#filterExpertValues").val(expertValues);
            var form = document.getElementById('filterExpertFrm');    
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(response) {
                    $("#asdf").html(response);
                }
            });
        }
	}
}





var userIdValues = [];
function getFavorite(userId)
{   
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
    if(userId != ''){  
		$('.filter-item:hover').toggleClass('active');
		var selected_activities =$('.active');
		var classExist = document.getElementsByClassName('active');
        var activFilter = document.getElementById('active');

        //push value if value not exist or delete value if value alredy exist
        if(!userIdValues.includes(userId)){
            userIdValues.push(userId);
        }else{
            const index = userIdValues.indexOf(userId);
            if (index > -1)
            {
                userIdValues.splice(index, 1);
                // $("#favorite_data_"+userId).remove();
                window.location.reload();
            }
        }
        if ( $(".filter-item").hasClass("active") ){
            
            //true: myID has select active
            $('#activefiltersfav').html("");
            userIdValues.forEach(function(value,index){
                let userValue = $("#favorite_data_"+value).attr('data-fav');
                $('#activefiltersfav').append("<div onclick=getFavorite("+value+")  class='category-filter-item  active'  id='"+value+"'><span>"+userValue+"</span></div> ")
            })
        } else {
            //false: myID does not have class select 
            
            // ("#"+userId).remove();
          
            window.location.reload();
        }
        if(userIdValues != ""){
            $("#filterFav").val(userIdValues);
            var form = document.getElementById('filterFavFrm');    
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(response) {
                    $("#asdf").html(response);
                }
            });
        }
	}
}

 
function playVid() { 
    $('#webcam-container').get(0).pause();
}


/* Search : OPEN/CLOSE */
$(function() {
    $("#collapseAdvancedSearch").click(function() {
        if (!$("#collapseAdvancedSearchContainer").hasClass("open")) {
            $("#collapseAdvancedSearchContainer").addClass("open");
        } else {
            $("#collapseAdvancedSearchContainer").removeClass("open");
        }
    });
});

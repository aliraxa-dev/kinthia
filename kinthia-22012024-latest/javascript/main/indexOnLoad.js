var filterArray = [];
var selectedFilters = {};
var skillIds = [];
var langIds = [];
var consIds = [];
var expertValues = [];
var userIdValues = [];
var isLoading = false;
var currentPage = 2;
var sortPage = 1;
var isFetchSortCalled = false;
var defaultSort = 'default';

// loadMoreItems([], defaultSort);
$(window).scroll(function () {
    var threshold = isMobile() ? 300 : 100;
    if ($(window).scrollTop() + $(window).height() >= $(document).height() - threshold && !isLoading) {
        if (isFetchSortCalled) {
            isFetchSortCalled = true;
            fetch_sort(defaultSort);
        } else {
            loadMoreItems(filterArray, defaultSort);
        }
    }
});
function isMobile() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

// Show/Hide all Filters
$(function() {
    $("#collapseAdvancedSearch").click(function() {
        if (!$("#collapseAdvancedSearchContainer").hasClass("open")) {
            $("#collapseAdvancedSearchContainer").addClass("open");
        } else {
            $("#collapseAdvancedSearchContainer").removeClass("open");
        }
    });
});

function playVid() { 
    $('#webcam-container').get(0).pause();
}

// Search bar filter
function filterByInput () {
    var voyantName = $('#inputvoyantName').val();
    $('#inputvoyantName').val('');

    if (!voyantName) return;
    
    if(voyantName.length < 3){
        return;
    }

    var filtered = filterArray.filter(function (el) {
        return el.type === "voyantName";
    });

    if (!filtered.length) {
        filterArray.push({
            type: "voyantName",
            content: voyantName,
            voyantId: voyantName.split(' ').join('_')
        })
        
    } else {
        var index = filterArray.indexOf(filtered[ 0 ]);
        filterArray[ index ].content = voyantName;
    }
    
    reloadActiveFilter(filterArray);
    loadMoreItems(filterArray, 'default');

}


function reloadActiveFilter(filterarr) {
    $('.active-filter-items').empty();
    $('.searchengine-filter').show();
    for (var index = 0; index < filterarr.length; index++) {
        if (filterarr[ index ].type === "consultation") {
            var filterItemContent = '<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="consultation_data_' + filterarr[ index ].consultId + '" name="' + filterarr[ index ].content + '" onclick=removeFilter(' + filterarr[ index ].consultId + ')>' +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        } else if (filterarr[ index ].type === "skill") {
            var filterItemContent = '<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="skill_data_' + filterarr[ index ].skillId + '" name="' + filterarr[ index ].content + '" onclick=removeFilter(' + filterarr[ index ].skillId + ')>' +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        } else if (filterarr[ index ].type === "language") {
            var filterItemContent = '<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="language_data_' + filterarr[ index ].languageId + '" name="' + filterarr[ index ].content + '" onclick=removeFilter(' + filterarr[ index ].languageId + ')>' +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        } else if (filterarr[ index ].type === "expert") {
            var filterItemContent = '<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="expert_data_' + filterarr[ index ].expertValue + '" name="' + filterarr[ index ].content + '" onclick=removeFilter("' + filterarr[ index ].expertValue + '")>' +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        } else if (filterarr[ index ].type === "favorite") {
            var filterItemContent = '<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="favorite_data_' + filterarr[ index ].userId + '" name="' + filterarr[ index ].content + '" onclick=removeFilter(' + filterarr[ index ].userId + ')>' +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        } else {
        var filterItemContent = `<div class="filter-item active category-filter-item" style="padding: 0 3%;" filter-id="inputvoyantName" name='${filterarr[index].content}' onclick=removeFilter('${filterarr[index].voyantId}')>` +
                                '<span>' + filterarr[ index ].content + '</span>' +
                                '</div>';
        }
        if (!selectedFilters[ filterarr[ index ].content ]) {
            selectedFilters[ filterarr[ index ].content ] = filterItemContent;
        }
    }
    for (var key in selectedFilters) {
        $('.active-filter-items').append(selectedFilters[ key ]);
    }
    if (filterArray.length === 0) {
        $('.searchengine-filter').hide();
    }
    
    filterarr.map( el => {
        if (el.type === "favorite") {
            updateFavResults();
        } else if (el.type === "skill") {
            updateResults();
        } else if (el.type === "language") {
            updateLangResults();
        } else if (el.type === "expert") {
            updateExpertResults();
        } else {
            loadMoreItems(filterArray, 'default');
        }
    });
    // fetch_sort('default');

}

// Filter by Phone or Chat or Email or Webcam
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
            removeFilter(consultId)
            delete selectedFilters[ consultName ];
        }

        reloadActiveFilter( filterArray );
        checkBox.off( 'change' );

    });
}
// function removeFilter( index ) {
//     if (filterArray[ index ].consultId) {
//         $('#consultation_data_' + filterArray[ index ].consultId).prop('checked', false);
//     } else if (filterArray[ index ].skillId) {
//         $('#skill_data_' + filterArray[ index ].skillId).removeClass("active");
//     } else if (filterArray[ index ].languageId) {
//         $('#language_data_' + filterArray[ index ].languageId).removeClass("active");
//     } else if (filterArray[ index ].expertValue) {
//         $('#expert_data_' + filterArray[ index ].expertValue).removeClass("active");
//     } else if (filterArray[ index ].userId) {
//         $('#favorite_data_' + filterArray[ index ].userId).prop('checked', false);
//     } else if (filterArray[ index ].content) {
//         $('#inputvoyantName').val('');
//     }

//     loadMoreItems(filterArray, 'default');

//     filterArray.splice( index, 1 );
//     if (!filterArray.length) {
//         removeAllFilters()
//     } else {
//         reloadActiveFilter( filterArray );
//     }
// }

function removeFilter(id) {
    const filter = filterArray.find(el => {
        if (el.type === "consultation") {
            return el.consultId === id;
        } else if (el.type === "skill") {
            return el.skillId === id;
        } else if (el.type === "language") {
            return el.languageId === id;
        } else if (el.type === "expert") {
            return el.expertValue === id;
        } else if (el.type === "favorite") {
            return el.userId === id;
        } else if (el.type === "voyantName") {
            return el.voyantId === id;
        }
    });
    if (!filter) {
        console.error('Invalid filter for id', id);
        return;
    }
    var dataId = null;
    if (filter.type === "expert") {
        dataId = filter[ `content` ];
    } else if(filter.type === "favorite" || filter.type === "consultation") {
        dataId = filter[ filter.type === 'favorite' ? 'userId' : `consultId` ];
    } else {
        dataId = filter[ filter.type === 'voyantName' ? 'content' : `${filter.type}Id` ]
    }

    if (dataId) {
        const elementId = getElementId(filter.type, dataId);
        if (elementId) {
            if (filter.type === 'voyantName') {
                clearInputField(dataId);
            } else if (filter.type === 'consultation') {
                $('#consultation_data_' + dataId).prop('checked', false);
                const filterId = $('.active-filter-items').find(`[filter-id="${`consultation_data_` + dataId}"]`).attr('name');
                if (filterId) {
                    for (var key in selectedFilters) {
                        if (key === filterId) {
                            delete selectedFilters[ key ];
                        }
                    }
                }
            } else if (filter.type === 'favorite') {
                $('#favorite_data_' + dataId).prop('checked', false);
                const filterId = $('.active-filter-items').find(`[filter-id="${`favorite_data_` + dataId}"]`).attr('name');
                if (filterId) {
                    for (var key in selectedFilters) {
                        if (key === filterId) {
                            delete selectedFilters[ key ];
                        }
                    }
                }
            } 
            else {
                toggleActiveClass(elementId);
            }
        }
    }

    // fetch_sort('default');
    loadMoreItems(filterArray, 'default');

    const index = filterArray.indexOf(filter);
    if( filterArray[index] != undefined &&  selectedFilters[filterArray[index].content] != undefined)
    {
        if( filterArray[index].content == "M" )
        { delete selectedFilters.M; }else if( filterArray[index].content == "F" ) 
        { delete selectedFilters.F; }else{
        delete selectedFilters[ `"${filterArray[index].content}"` ];
        }

        
    }
    

    filterArray.splice(index, 1);
    if (!filterArray.length) {
        removeAllFilters();
    } else {
        reloadActiveFilter(filterArray);
    }
    resetCurrentPage();
}

function getElementId(type, id) {
    switch (type) {
        case 'consultation':
            return `consultation_data_${id}`;
        case 'skill':
            return `skill_data_${id}`;
        case 'language':
            return `language_data_${id}`;
        case 'expert':
            return `expert_data_${id}`;
        case 'favorite':
            return `favorite_data_${id}`;
        case 'voyantName':
            return `${type}`;
        default:
            console.warn('Unhandled filter type:', type);
            return null;
    }
}

function toggleActiveClass(id) {
    $(`#${id}`).toggleClass('active');
    const modifiedId = id.replace('data_', '');
    $(`#${modifiedId}`).toggleClass('active');
    const filterId = $('.active-filter-items').find(`[filter-id="${id}"]`).attr('name');
    if (filterId) {
        for (var key in selectedFilters) {
            if (key === filterId) {
                delete selectedFilters[ key ];
            }
        }
    }
}

function clearInputField(id) {
    for (var key in selectedFilters) {
        if (key === id) {
            delete selectedFilters[ key ];
        }
    }
}



// Remove all filters
function removeAllFilters() {
    filterArray.map( el => {
        if (el.type === "consultation") {
            $('#consultation_data_' + el.consultId).prop('checked', false);
        } else if (el.type === "favorite") {
            $('#favorite_data_' + el.userId).prop('checked', false);
        }
    } );

    filterArray = [];
    $('.searchengine-filter').hide();
    reloadActiveFilter(filterArray);
    $('.filter-item').removeClass('active');
    deleteAll();
    // fetch_sort('default');
    loadMoreItems(filterArray, 'default');

    resetCurrentPage();
}
function deleteAll() {
    skillIds = [];
    langIds = [];
    consIds = [];
    expertValues = [];
    userIdValues = [];
    selectedFilters = {};
    if ($('#favorite_data_2679').is(':checked')) {
        $('#favorite_data_2679').prop('checked', false);
    }
    var activFilter = document.querySelector('.searchengine-filter');
    if (activFilter.style.display == 'flex') {
        activFilter.style.display = 'none';
    }
    $("#expert-list-container").html('');
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

// Filter by Favorite
function getFavorite(userId)
{ 
    $('#favorite_data_' + userId).on( 'change', function ( e ) {
        var checkBox = $(this);
        var favName = $('#favorite_data_' + userId).attr('data-fav');
        if (checkBox.is(':checked')) {
            if (!filterArray.length) {
                $('.searchengine-filter').show();
            }
            filterArray.push({
                type: "favorite",
                content: favName,
                userId: userId
            });
        } else {
            var index = filterArray.map(el => {
                if (el.type === "favorite") {
                    return el.content;
                }
            }).indexOf(favName);
            removeFavoriteFilter(index)
            delete selectedFilters[ favName ];
        }

        reloadActiveFilter( filterArray );
        checkBox.off( 'change' );
    });
}

function removeFavoriteFilter( index ) {
    if (filterArray[ index ].userId) {
        $('#favorite_data_' + filterArray[ index ].userId).prop('checked', false);
    }
    filterArray.splice( index, 1 );
    if (!filterArray.length) {
        removeAllFilters()
    } else {
        reloadActiveFilter( filterArray );
    }
}

function updateFavResults() {
    const userIds = filterArray.map(el => {
        if (el.type === "favorite") {
            return el.userId;
        }
    });
    $("#filterFav").val(userIds);
    var form = document.getElementById('filterFavFrm');
    $.ajax({
        url: form.action,
        type: form.method,
        data: $(form).serialize(),
        dataType: 'html',
        success: function (response) {
            $("#expert-list-container").html(response);
            
        }
    });

}

// Filter by Skill
function getSkill(skillId) {
    $("#loadData1").hide();
    $(".voyantcontainer1").hide();
    $('#skill_' + skillId).toggleClass("active");
    $('#skill_data_' + skillId).toggleClass("active");
    var skillName = $('#skill_data_' + skillId).attr('data-skill');
    if ($('#skill_data_' + skillId).hasClass("active")) {
        if (!filterArray.length) {
            $('.searchengine-filter').show();
        }
        filterArray.push({
            type: "skill",
            content: skillName,
            skillId: skillId
        });
    } else {
        var index = filterArray.map(el => {
            if (el.type === "skill") {
                return el.content;
            }
        }).indexOf(skillName);
        removeSkillFilter(index)
        delete selectedFilters[ skillName ];
    }

    reloadActiveFilter(filterArray);

}

function removeSkillFilter(index) {
    if (filterArray[ index ].skillId) {
        $('#skill_data_' + filterArray[ index ].skillId).removeClass("active");
    }
    filterArray.splice(index, 1);
    if (!filterArray.length) {
        removeAllFilters()
    } else {
        reloadActiveFilter(filterArray);
    }
}

function updateResults() {
    const skillIds = filterArray.map(el => {
        if (el.type === "skill") {
            return el.skillId;
        }
    });
    $("#filterSkillIds").val(skillIds);
    var form = document.getElementById('filterSkillFrm');
    $.ajax({
        url: form.action,
        type: form.method,
        data: $(form).serialize(),
        dataType: 'html',
        success: function (response) {
            $("#expert-list-container").html(response);
            
        }
    });
}

// Filter by Language
function getLanguage(languageId) {
    $("#loadData1").hide();
    $(".voyantcontainer1").hide();
    $('#language_' + languageId).toggleClass("active");
    $('#language_data_' + languageId).toggleClass("active");
    var languageName = $('#language_data_' + languageId).attr('data-language');
    if ($('#language_data_' + languageId).hasClass("active")) {
        if (!filterArray.length) {
            $('.searchengine-filter').show();
        }
        filterArray.push({
            type: "language",
            content: languageName,
            languageId: languageId
        });
    
    } else {
        var index = filterArray.map(el => {
            if (el.type === "language") {
                return el.content;
            }
        }).indexOf(languageName);
        removeLanguageFilter(index)
        delete selectedFilters[ languageName ];
    }

    reloadActiveFilter(filterArray);
}

function removeLanguageFilter(index) {
    if (filterArray[ index ].languageId) {
        $('#language_data_' + filterArray[ index ].languageId).removeClass("active");
    }
    filterArray.splice(index, 1);
    if (!filterArray.length) {
        removeAllFilters()
    } else {
        reloadActiveFilter(filterArray);
    }
}

function updateLangResults() {
    const langIds = filterArray.map(el => {
        if (el.type === "language") {
            return el.languageId;
        }
    });
    $("#filterLanguageIds").val(langIds);
    var form = document.getElementById('filterLanguageFrm');
    $.ajax({
        url: form.action,
        type: form.method,
        data: $(form).serialize(),
        dataType: 'html',
        success: function (response) {
            $("#expert-list-container").html(response);
            
        }
    });
}

// Filter by Expert
function getExpert(expertValue)
{     
    $("#loadData1").hide(); 
    $(".voyantcontainer1").hide(); 
    $('#expert_' + expertValue).toggleClass("active");
    var expertName = $('#expert_' + expertValue).attr('data-expert');

    if ($('#expert_' + expertValue).hasClass("active")) {
        if (!filterArray.length) {
            $('.searchengine-filter').show();
        }
        filterArray.push({
            type: "expert",
            content: expertName,
            expertValue: expertValue
        });
    } else {
        var index = filterArray.map(el => {
            if (el.type === "expert") {
                return el.content;
            }
        }).indexOf(expertName);
        removeExpertFilter(index)
        delete selectedFilters[ expertName ];
        
    }

    reloadActiveFilter(filterArray);
}

function removeExpertFilter(index) {
    if (filterArray[ index ].expertValue) {
        $('#expert_' + filterArray[ index ].expertValue).removeClass("active");
    }
    filterArray.splice(index, 1);
    if (!filterArray.length) {
        removeAllFilters()
    } else {
        reloadActiveFilter(filterArray);
    }

}

function updateExpertResults() {
    const expertValues = filterArray.map(el => {
        if (el.type === "expert") {
            return el.content;
        }
    });
    $("#filterExpertValues").val(expertValues);
    var form = document.getElementById('filterExpertFrm');
    $.ajax({
        url: form.action,
        type: form.method,
        data: $(form).serialize(),
        dataType: 'html',
        success: function (response) {
            $("#expert-list-container").html(response);
        }
    });
}

function fetch_sort(val1) {
    isLoading = true;
    isFetchSortCalled = true;
    if (val1 !== defaultSort) {
        sortPage = 1;
        defaultSort = val1;
        $('#sort-expert-list-container').html('');
    }

    if (sortPage === 1) {
        $("#expert-list-container").html('');
    }
    var form = document.getElementById('sortFrm');
    $("#sortValues").val(val1);
    $('.ajax-list-loader').show();

    const filtersExist = filterArray && filterArray.length > 0;
    $.ajax({
        url: 'main/expertlist/' + sortPage,
        type: 'post',
        data: {
            sortValues: val1,
            filterCriteria: filterArray,
        },
        dataType: 'html',
        success: function(response) {
            var containsNoExpertsFound = response.match(/No Experts Found/g);
            if (containsNoExpertsFound) {
                return;
            }

            // Load default data if no filters are selected
            if (!filtersExist) {
                $('.list-loader').hide();
                $("#sort-expert-list-container").append(response);
            } else {
                // Load filtered and sorted data
                $('.list-loader').hide();
                $("#sort-expert-list-container").append(response);
            }

            sortPage++;
            defaultSort = val1;

        },
        complete: function () {
            isLoading = false;
        }
    });
}

// Function to load more items
function loadMoreItems(filterValues, sortOption) {
    isLoading = true;
    console.log(filterValues);
    const expertClass = $('.expert-list-container');
    const experListId =  $("#expert-list-container")[0].firstChild;

    if (expertClass.length) {
        for (var i = 0; i < filterValues.length; i++) {
            if (filterValues[ i ].type === "voyantName") {
                $('.expert-list-container').html('');
                if( $('#expert-list-container').hasClass('expert-list-container') ){
                    currentPage = 1;
                    $('#expert-list-container').removeClass('expert-list-container');
                }
            }
        }
    }



    const data = {
        filterCriteria: filterValues,
        sortValues: sortOption
    };
    $('.list-loader').hide();
    // Check if any filters exist
    const filtersExist = filterValues && filterValues.length > 0;

    $.ajax({
        url: 'main/expertlist/' + currentPage,
        type: 'post',
        data: data,
        dataType: 'html',
        async: false,
        success: function(response) {
            var containsNoExpertsFound = response.match(/No Experts Found/g);
            if (containsNoExpertsFound) {
                return;
            }

            // Load default data if no filters are selected
            if (!filtersExist) {
                $('.list-loader').hide();
                $("#expert-list-container").append(response);
            } else {
                // Load filtered and sorted data
                $('.list-loader').hide();
                $("#expert-list-container").append(response);
            }

            currentPage++; // Increment the page for the next load
            console.log('currentPage: ', currentPage );
            defaultSort =  sortOption; // Update current sort value
            filterArray = filterValues; // Update current filter array
        },
        complete: function () {
            isLoading = false;
        }
    });
}

// function when ever selectedFilers is empty after remove all filters set the value of currentPage 1
function resetCurrentPage() {
    // location reload
    if (!filterArray.length) {
        location.reload();
        currentPage = 1;
    }
}




// function getConsultation(consultationId) {
//     $("#loadData1").hide(); 
//     $(".voyantcontainer1").hide(); 
//     if(consultationId != '')
//     {
// 		$('.filter-item:hover').toggleClass('active');
//         //push value if value not exist or delete value if value alredy exist
//         if(!consIds.includes(consultationId)) {
//             consIds.push(consultationId);
//         } else {
//             const index = consIds.indexOf(consultationId);
//             if (index > -1) {
//                 consIds.splice(index, 1);
//                $("#consultation_data_"+consultationId).remove();
//             }
//         }

//         if ( $(".filter-item").hasClass("active") ) {
//             //true: myID has select active
//             consIds.forEach(function(value,index) {
//                 console.log("values:", value);
//                 let consValue = $("#consultation_data_"+value).attr('data-cons');
//                 const consFilter = "<div onclick='getConsultation("+value+")'  class='category-filter-item  active'  id='"+value+"'><span>"+consValue+"</span></div> ";
//                 if (!selectedFilters[ consValue ]) {
//                     selectedFilters[ consValue ] = consFilter;
//                 }
//             })
//         } else {
//             //false: myID does not have class select  
//             $("#"+consultationId).remove();
//             window.location.reload();
//         }
//         if(consIds != "") {
//             $("#filterConsultationIds").val(consIds);
//             var form = document.getElementById('filterConsultationFrm');      
//             $.ajax({
//                 url:form.action,
//                 type: form.method,
//                 data: $(form).serialize(),
//                 dataType: 'html',
//                 success: function(response) {
//                     $("#expert-list-container").append(response);
                    
//                 }
//             });
    
//         }
// 	}
// }
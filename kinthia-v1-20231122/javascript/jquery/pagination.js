$('.js-load-more').on('click', function(){
  var $this =$(this),
  totalPages = parseInt($('[data-all-pages]').val()),
  currentPage = parseInt($('[data-this-page]').val()),
  datacollurl = $('[data-coll-url]').val();;
  $this.attr('disabled', true);
  $this.find('[load-more-text]').addClass('hide');
  $this.find('[loader]').removeClass('hide');
  var nextUrl = $('[data-next-link]').val();
  var current_page_new = currentPage + 1;
  var next_coll = currentPage + 1;
  //alert(current_page_new)
  //return false;
  $.ajax({
  url: nextUrl,
  type: 'GET',
  dataType: 'html',
  success: function(responseHTML){
  $('[data-next-link]').val(datacollurl + "?page="+next_coll);
  $('[data-this-page]').val(current_page_new);
  $('.voyantcontainer1').append($(responseHTML).find('.grid-2-small-1').html());
  },
  complete: function() {
  if(current_page_new < totalPages) {
  $this.attr('disabled', false); $this.find('[load-more-text]').removeClass('hide'); $this.find('[loader]').addClass('hide');
  } 
  if(current_page_new >= totalPages) {
  // $this.find('[load-more-text]').css( "display", "none" );
  $("#loadData1").hide(); 
  } 
  }
  })
 });

const input = document.getElementById('textInput');
const textElement = document.getElementById('displayText');

function updateValue(e) {
  textElement.textContent = e.target.value;
}
input.addEventListener('input', updateValue);
 

function loadMoreBtn(pagiId){
    alert(pagiId); 
   
 // $.ajax({
        //     url:form.action,
        //     type: form.method,
        //     data: $(form).serialize(),
        //     dataType: 'html',
        //     success: function(response) {
        //        $("#asdf").html(response);

        //     }
        // });

} 

 
    function loadMoreBtn(page){
      $.ajax({
        url : page,
        type: "POST",
        cache:false,
        data:{page_no:page},
        success:function(data){
          if (data) {
            $("#pagination").remove();
            $("#loadData").append(data);
          }else{
            $(".loadbtn").prop("disabled", true);
            $(".loadbtn").html('That is All');
          }
        }
      });
    }
    
    $(document).on('click', '.loadbtn', function(){
      $(".loadbtn").html('Loading...');
      var pId = $(this).data("id");
      loadMoreData(pId);
    });
 
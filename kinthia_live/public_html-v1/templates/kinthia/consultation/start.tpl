

{if $session.user}
<h2 class="voyanth2 mb-5">Entrer en consultation {$type} avec <span class="kin-color-1">{$expertName}</span></h2>

<input type="hidden" id="userNm" value="{$session.user.name}">
<input type="hidden" id="cartUrl" value="{'/cart/pack/'|url}">
<input type="hidden" id="consultationUrl" value="{"/consultation/index/"|url}">
<input type="hidden" id="consultationStatus" value="{$voyant.consultationStatus}">

<form action="{'/consultation/saveUserConsultaionRequest'|url}" method="post" id="saveUserConsultaionRequest"> 
    <input type="hidden" id="username" name="username" value="{$session.user.name}">
    <input type="hidden" id="userId" name="userId" value="{$session.userId}">
    <input type="hidden" id="voyantId" name="voyantId" value="{$voyant.voyantId}">
    <input type="hidden" id="usertype" name="usertype" value="U">
    <input type="hidden" id="room" name="room" value="chat-{$voyant.voyantId}-{$session.userId}">
    <input type="hidden" id="consultationType" name="consultationType" value="{$type}">
</form>

{literal}
	<script type="text/javascript">
		jQuery(document).ready(function(){
		var username = $("userNm").val();
	 	
	    if(username != ""){
	      var form = document.getElementById('getCreditTimeForm');
	       $.ajax({
	            url: form.action,
	            type: form.method,
	            data: $(form).serialize(),
	            dataType: 'json',
	            success: function(response) {  
	                    var cartUrl=$("#cartUrl").val();
	             		//var consultationUrl = $("#consultationUrl").val();
	             		var consultationStatus = $("#consultationStatus").val();
	                if(response.time){
	                	$("#makingConsultation").html("<p style='cursor:pointer' onclick='consultationReq();'>Enter in consultation</p>");
	                	/*if(consultationStatus==2) {
	                		$("#makingConsultation").html("<strong>Please wait expert is busy right now. If expert is free we will send a notification with you.</strong>");
	                	} else if(consultationStatus==1) { 
	                		$("#makingConsultation").html("<p style='cursor:pointer' onclick='consultationReq()'>Enter in consultation</p>");
	                	} else if(consultationStatus==0) {
                            $("#makingConsultation").html("<strong>Expert is not online.</strong>");
	                	}*/	                     
	                }else{
	                    $("#makingConsultation").html("<a href="+cartUrl+" style='cursor:pointer'>Enter in consultation</a>");
	                }
	            }
	        });
	    }

	    });
	</script>

	<script type="text/javascript">
		function consultationReq(){
			var form2 = document.getElementById('saveUserConsultaionRequest');
	       	$.ajax({
	            url: form2.action,
	            type: form2.method,
	            data: $(form2).serialize(),
	            dataType: 'json',
	            success: function(response) {
	            	if(response.status=='success') {
	            	    var consultationUrl = $("#consultationUrl").val();
	            	    window.location.href = consultationUrl+response.id;	
	            	} else {
	            	    alert(response.message);
	            	}
	            }
	        });
		}
	</script>
{/literal}
<div class="text-center" id="makingConsultation" >



</div>
{else}

<h2 class="voyanth2 mb-5">Please <a href="{"/user/main/logIn/$voyant.urlName"|url}"> login </a> or <a href="{"/user/main/logIn/$voyant.urlName"|url}"> Register </a> for Entrer en consultation {$type} avec <span class="kin-color-1">{$expertName}</span></h2>

<div class="text-center">
<a href="{"/user/main/logIn/$voyant.urlName"|url}">Enter in consultation</a>
</div>

{/if}


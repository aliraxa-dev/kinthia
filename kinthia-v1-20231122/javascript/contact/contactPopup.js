$(document).data("popupStart", function(popupWindow)
{
  $("#contactPopupForm", popupWindow).validate({
   rules: {
     title: "required",
     description: "required"
   },
   messages: {
	   title: _t("Please enter a subject"),
	   description: _t("Please enter a description")
   },
  submitHandler: function(form)
  {
      $(form).ajaxSubmit({dataType:  'json',
      success : function(response)
      {
          if(response.status == "error")
          {
              $.alertDialog(response.message);
          }
          
          if(response.status == "ok")
          {
            $.alertDialog(_t("Your message was sent"), function()
            {
                popupWindow.dialog("close");
            });
          }
          
      }});
      return false;
  }
  });
  
  $("input.close", popupWindow).click(function()
  {
      popupWindow.dialog("close");
  });
  
});
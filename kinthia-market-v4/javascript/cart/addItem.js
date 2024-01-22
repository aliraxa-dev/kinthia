$(document).data("popupStart", function(popupWindow)
{
  var $cartItemsCount = $("#cartItemsCount");
  var newItemsCount = parseInt($cartItemsCount.text()) + 1;
  $cartItemsCount.text(newItemsCount);
  
  if (newItemsCount > 1) {
      $('#cartItemsGreaterThanOne').show();
  }

  var $cartItemsCount1 = $("#cartItemsCount1");
  var newItemsCount = parseInt($cartItemsCount1.text()) + 1;
  $cartItemsCount1.text(newItemsCount);
  
   if (newItemsCount > 1) {
      $('#cartItemsGreaterThanOne1').show();
  }
  
  $("#cartItemsNotEmpty").show();
  $("#cartItemsEmpty").hide();
  $("#cartItemsDescriptionNotEmpty").show();
  $("#cartItemsDescriptionEmpty").hide();
  
  $("#cartItemsNotEmpty1").show();
  $("#cartItemsEmpty1").hide();
  $("#cartItemsDescriptionNotEmpty1").show();
  $("#cartItemsDescriptionEmpty1").hide();
  
  $("img.cart_add_item_continue", popupWindow).click(function()
  {
      popupWindow.dialog("close");
  });
  
  $("img.cart_add_item_checkout", popupWindow).click(function()
  { 
      location.href = AppRouter.getRewrittedUrl("/cart/checkout");
  });
    
});
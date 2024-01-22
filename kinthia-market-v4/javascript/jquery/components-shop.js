/**
 Core Shop layout handlers and wrappers
 **/

// BEGIN: Layout Brand
var LayoutQtySpinner = function () {

    return {
        //main function to initiate the module
        init: function () {
            $('.c-spinner .btn:first-of-type').on('click', function () {
                var data_input = $(this).attr('data_input');
                var data_max = ($(this).data('maximum')) ? $(this).data('maximum') : 10;
                if ($('.c-spinner input.' + data_input).val() < data_max) {
                    $('.c-spinner input.' + data_input).val(parseInt($('.c-spinner input.' + data_input).val(), 10) + 1);
                }
            });

            $('.c-spinner .btn:last-of-type').on('click', function () {
                var data_input = $(this).attr('data_input');
                if ($('.c-spinner input.' + data_input).val() != 0) {
                    $('.c-spinner input.' + data_input).val(parseInt($('.c-spinner input.' + data_input).val(), 10) - 1);
                }
            });
        }

    };
}();
// END

// BEGIN: Layout Checkbox Visibility Toggle
var LayoutCheckboxVisibilityToggle = function () {

    return {
        //main function to initiate the module
        init: function () {
            $('.c-toggle-hide').each(function () {
                var $checkbox = $(this).find('input.c-check'),
                    $speed = $(this).data('animation-speed'),
                    $object = $('.' + $(this).data('object-selector'));

                $object.hide();

                if (typeof $speed === 'undefined') {
                    $speed = 'slow';
                }

                $($checkbox).on('change', function () {
                    if ($($object).is(':hidden')) {
                        $($object).show($speed);
                    } else {
                        $($object).slideUp($speed);
                    }
                });
            });
        }
    };

}();
// END

// BEGIN: Layout Shipping Calculator
var LayoutShippingCalculator = function () {

    return {
        //main function to initiate the module
        init: function () {
            var $shipping_calculator = $('.c-shipping-calculator'),
                $radio_name = $($shipping_calculator).data('name'),
                $total_placeholder = $($shipping_calculator).data('total-selector'),
                $subtotal_placeholder = $($shipping_calculator).data('subtotal-selector'),
                $subtotal = parseFloat($('.' + $subtotal_placeholder).text());

            $('input[name=' + $radio_name + ']', $shipping_calculator).on('change', function () {
                var $price = parseFloat($('input[name=' + $radio_name + ']:checked', $shipping_calculator).val()),
                    $overall_total = $subtotal + $price;
                $('.' + $total_placeholder).text($overall_total.toFixed(2));
            });
        }
    };

}();
// END

// BEGIN: Layout Delivery Method
var LayoutDeliveryMethod = function () {

    return {
        stripeObj: null,
        stripeCard: null,
        clientSecret:null,
        init: function () { 
            $("input[name='paymentMethod']").click(function () { 
                
                $('.js-additional-information').hide();
                var paymentMethod = $(this).val();
                if (paymentMethod === 'stripe') {
                    $('#payment-option-1-additional-information').show();
                    
                    LayoutDeliveryMethod.stripeObj = Stripe($("input[name$='stripePublishableKey']").val());
                    //LayoutDeliveryMethod.stripeObj = Stripe("pk_test_3QTm41Gsxekm6CDwCFxUg3Eu");
                    var intentUrl = $("input[name$='intentUrl']").val();    // https://www.kinthia.com/test78/cart/getIntent
                    var voyantId = $("input[name$='voyantId']").val();
                    var type = $("input[name$='type']").val();
                    var amdData = {
                      voyantId: voyantId,
                      type: type
                    };

                    $.ajax({
                        type: 'POST',
                        data: amdData,
                        url: intentUrl,
                        success: function(data) {
                            data = JSON.parse(data);
                            var elements = LayoutDeliveryMethod.stripeObj.elements();
                            
                            //
                            LayoutDeliveryMethod.stripeCard = elements.create('card',{
                                iconStyle: 'solid',
                                style: {
                                    base: {
                                        iconColor: '#8898AA',
                                        color: 'black',
                                        lineHeight: '36px',
                                        fontWeight: 300,
                                        fontFamily: '"Source Sans Pro","Helvetica Neue", Helvetica, sans-serif',
                                        fontSize: '18px',
        
                                        '::placeholder': {
                                            color: '#8898AA',
                                        },
                                    },
                                    invalid: {
                                        iconColor: '#e85746',
                                        color: '#e85746',
                                    }
                                },
                                classes: {
                                    focus: 'is-focused',
                                    empty: 'is-empty',
                                },
                            });
                            LayoutDeliveryMethod.stripeCard.mount('#card-element');
                            LayoutDeliveryMethod.stripeCard.on("change", function (event) {
                            // Disable the Pay button if there are no card details in the Element
                            //document.querySelector("button").disabled = event.empty;
                            document.querySelector(".payment-errors").textContent = event.error ? event.error.message : "";
                            
                            });
                            LayoutDeliveryMethod.clientSecret = data.clientSecret;
                            LayoutDeliveryMethod.intentId = data.intentId;

                        }
                    });
                }
                if (paymentMethod === 'payPal') {
                    $('#payment-option-2-additional-information').show();
                }

                if (paymentMethod === 'check') {
                    $('#payment-option-3-additional-information').show();
                }
            });
            $(".payment-button-new").click(function () {
                // Prevent double submit if disable
                if ($('#buttonValidator').prop('disabled')) {
                    return;
                }

                $("#buttonValidator").attr("disabled", "disabled");
                console.log('payment-button-new click');
                var actionUrl = $("input[name$='actionUrl']").val();
                var voyantId = $("input[name$='voyantId']").val();
                var paymentMethod = $("input[name$='paymentMethod']:checked").val();
                var type = $("input[name$='type']").val();

                if (
                    'payPal' === paymentMethod ||
                    'check' === paymentMethod
                ) {
                    var $form = $('<form action="' + actionUrl + '" method="post"></form>');
                    $form.append('<input type="hidden" name="actionUrl" value="' + actionUrl + '" />');
                    $form.append('<input type="hidden" name="voyantId" value="' + voyantId + '" />');
                    $form.append('<input type="hidden" name="paymentMethod" value="' + paymentMethod + '" />');
                    $form.append('<input type="hidden" name="type" value="' + type + '" />');
                    $(document.body).append($form);
                    $form.submit();
                }

                if (
                    'stripe' === paymentMethod && type === 'VoyantQuestion' || type === 'TimePack' || type === 'Platform'
                ) {
                    var stripeForm = document.getElementById('stripePaymentForm');
                    console.log(LayoutDeliveryMethod.stripeObj);
                    LayoutDeliveryMethod.stripeObj
                        .confirmCardPayment(LayoutDeliveryMethod.clientSecret, {
                          payment_method: {
                            card: LayoutDeliveryMethod.stripeCard
                          }
                        })
                        .then(function(result) {
                          if (result.error) {
                            // Show error to your customer
                            //showError(result.error.message);
                            $(".payment-errors").html(result.error.message);
                            $("#buttonValidator").removeAttr("disabled");
                          } else {
                            // The payment succeeded!
                                // Grab the form:
                            var form = document.getElementById('stripePaymentForm');
                                
                                // Thank you popup
                            var thankYouPopup = $("<div title='" + _t("Loading") + "'>" +
                                "<p style='text-align:center;font-size:1.6em'><br/>" +
                                "<b>" + _t("Thank you, we are processing your payment") + "</b><br>" +
                                "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
                                "</div>")
                                .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                            thankYouPopup.dialog("open");
                            
                            var hiddenInput = document.createElement('input');
                            hiddenInput.setAttribute('type', 'hidden');
                            hiddenInput.setAttribute('name', 'intentId');
                            hiddenInput.setAttribute('value', LayoutDeliveryMethod.intentId);
                            
                            var voyantIdInput = document.createElement('input');
                            voyantIdInput.setAttribute('type', 'hidden');
                            voyantIdInput.setAttribute('name', 'voyantId');
                            voyantIdInput.setAttribute('value', voyantId);

                            var paymentMethodInput = document.createElement('input');
                            paymentMethodInput.setAttribute('type', 'hidden');
                            paymentMethodInput.setAttribute('name', 'paymentMethod');
                            paymentMethodInput.setAttribute('value', paymentMethod);
                            
                            form.appendChild(hiddenInput);
                            form.appendChild(voyantIdInput);
                            form.appendChild(paymentMethodInput);

                            const data = {
                                type,
                                intentId: LayoutDeliveryMethod.intentId,
                                voyantId,
                            };

                            $.ajax({
                                url: form.action,
                                type: form.method,
                                data: data,
                                success: function(response) {
                                    response = JSON.parse(response)
                                    thankYouPopup.dialog("close");
                                    // console.log(response);
                                    if (response.status == "error") {
                                        var stripeErrorPopup = $("<div title='" + _t("Loading") + "'>" +
                                            "<p style='text-align:center;font-size:1.6em'><br/>" +
                                            "<b>" + _t(response.message) + "</b>" +
                                            "</div>")
                                            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                                        stripeErrorPopup.dialog("open");
                                    }
                                    if (response.status == "ok") {
                                        window.location.replace(response.redirectUrl);
                                    }
                                }
                            });
                                
                          }
                        });
                    
                }
            });
        }
    }
}();
// END

// BEGIN: Layout CheckBox Enable Button
var LayoutCheckBoxEnableButton = function () {

    return {
        init: function () {
            $("#checkboxValidator").click(function () {
                $("#buttonValidator").attr("disabled", !this.checked);
            });
        }
    }
}();

// END

// PRODUCT GALLERY
var LayoutProductGallery = function () {
    return {
        //main function to initiate the module
        init: function () {
            $('.c-product-gallery-content .c-zoom').toggleClass('c-hide'); // INIT FUNCTION - HIDE ALL IMAGES

            // SET GALLERY ORDER
            var i = 1;
            $('.c-product-gallery-content .c-zoom').each(function () {
                $(this).attr('img_order', i);
                i++;
            });

            // INIT ZOOM MASTER PLUGIN
            $('.c-zoom').each(function () {
                $(this).zoom();
            });

            // ASSIGN THUMBNAIL TO IMAGE
            var i = 1;
            $('.c-product-thumb img').each(function () {
                $(this).attr('img_order', i);
                i++;
            });

            // INIT FIRST IMAGE
            $('.c-product-gallery-content .c-zoom[img_order="1"]').toggleClass('c-hide');

            // CHANGE IMAGES ON THUMBNAIL CLICK
            $('.c-product-thumb img').click(function () {
                var img_target = $(this).attr('img_order');

                $('.c-product-gallery-content .c-zoom').addClass('c-hide');
                $('.c-product-gallery-content .c-zoom[img_order="' + img_target + '"]').removeClass('c-hide');
            });

            // SET THUMBNAIL HEIGHT
            var thumb_width = $('.c-product-thumb').width();
            $('.c-product-thumb').height(thumb_width);

        }
    }
}();


// Main theme initialization
$(document).ready(function () {
    // init layout handlers
    LayoutQtySpinner.init();
    LayoutCheckboxVisibilityToggle.init();
    LayoutShippingCalculator.init();
    LayoutDeliveryMethod.init();
    LayoutCheckBoxEnableButton.init();
    LayoutProductGallery.init();
});

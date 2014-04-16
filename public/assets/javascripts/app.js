/**
 * My script file
 *
 * @depend stripe.js
 * @depend jquery.js
 * @depend parsley.js
 */

Stripe.setPublishableKey('pk_live_hLAMpuPmwkwtH2VtejsA3KmJ');
var stripeResponseHandler = function(status, response) {
  var $form = $('#payment-form');
  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').slideDown(50).text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and re-submit
    $form.get(0).submit();
  }
};

jQuery(function($) {
  $('input,select').blur(function(){
    $(this).parsley().validate();
  });

  $('#payment-form').submit(function(e) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;

  });
});

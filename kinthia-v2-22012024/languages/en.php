<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Classifieds Ads                   //
//   				 by Hocine Guillaume (c) 2008 - 2009                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/*  English language dictionary
	To create another language, 
	please, copy this file and replace 
	expressions with the same ones in the 
	new language.
	
	The file should be posted in /languages 
	folder. Its name sould be LanguageName.php,
	where LanguageName is the language, shown 
	in the CMS as an language option.
*/

$language = array();

/* !! set this value to the current language name, when creating new languages !! */
$languageName = 'English';


/* Front Sites Texts */

// all
$language['language'] = 'en';
$language['show_arbo_voyance'] = 'Voyance';
$language['show_arbo_tirage'] = 'Voyance';
$language['page'] = 'page';
$language['euro_symbole'] = '€';
$language['euro_text'] = 'EURO';
$language['euro_text_abreviation'] = 'EUR';


//// --> template/templateName/captcha/
// show.tpl
$language['captchaShow_generate_new_image'] = 'Generate new security code';


//// --> template/templateName/cart/includes/
// steps.tpl
$language['cartSteps_caddies'] = 'My caddies';
$language['cartSteps_payment'] = 'Payment';
$language['cartSteps_confirmation'] = 'Confirmation';


//// --> template/templateName/cart/
// addItem.tpl
$language['cartAddItem_title'] = 'You just add to cart the next product';
$language['cartAddItem_quantity'] = 'Quantity :';

// checkout.tpl
$language['cartCheckout_html_title'] = 'My caddies - Kinthia.com';
$language['cartCheckout_meta_description'] = 'My caddies - Kinthia.com';
$language['cartCheckout_arbo'] = 'Mon panier';
$language['cartCheckout_table_item'] = 'List of questions for';
$language['cartCheckout_quantity'] = 'Quantity';
$language['cartCheckout_price'] = 'Price';
$language['cartCheckout_delete'] = 'Delete';
$language['cartCheckout_caddies_total'] = 'Caddies total';
$language['cartCheckout_total_price'] = 'Total Price';

// confirmation.tpl
$language['cartConfirmation_html_title'] = 'Confirmation / validation of your payment';
$language['cartConfirmation_meta_description'] = 'Confirmation / validation of your payment';
$language['cartConfirmation_arbo'] = 'Confirmation / validation of your payment';
$language['cartConfirmation_desc'] = 'Votre paiement est en cours de validation.';
$language['cartConfirmation_desc0'] = 'Une confirmation par email vous sera envoyé dès la validation du paiement effectué.';
$language['cartConfirmation_desc1'] = 'Une fois la validation du paiement effectué, le voyant vous contactera dans les plus bref délais par email pour convenir d\'un rendez-vous.';
$language['cartConfirmation_desc2'] = 'Nous vous remercions pour la confiance que vous accordez';
$language['cartConfirmation_desc3'] = 'à Kinthia.com, et vous souhaitons une agréable journée.';
$language['cartConfirmation_desc4'] = 'L’équipe de Kinthia.com';

// pay.tpl
$language['cartPay_html_title'] = 'Redirection to the secure payment page';
$language['cartPay_html_desc'] = 'You are being redirected to the secure page to process your payment...';
$language['cartPay_html_desc0'] = 'Kinthia.com Team';

// paymentDetails.tpl
$language['cartPaymentDetails_html_title'] = 'Payment - Kinthia.com';
$language['cartPaymentDetails_meta_description'] = 'Payment - Kinthia.com';
$language['cartPaymentDetails_arbo'] = 'Payment';
$language['cartPaymentDetails_order_total_price'] = 'Order total price';
$language['cartPaymentDetails_total_price'] = 'Total Price';
$language['cartPaymentDetails_payment_method'] = 'I choose my payment method';
$language['cartPaymentDetails_card_paypal'] = 'I pay online with my credit card or my paypal account';


//// --> template/templateName/comment/
// voyantComment.tpl
$language['voyantComment_html_title'] = 'Comments on the psychic / medium';
$language['voyantComment_meta_description'] = 'Comments on the psychic / medium';
$language['voyantComment_meta_description1'] = 'by customers who used its services';
$language['voyantComment_arbo'] = 'Comments on the psychic / medium';
$language['voyantComment_h1'] = 'Comments on the psychic / medium';
$language['voyantComment_total_rating'] = 'Rating :';
$language['voyantComment_write_on'] = 'write on';
$language['voyantComment_rating'] = 'Rating :';
$language['voyantComment_reply'] = 'reply';


//// --> template/templateName/contact/
// contactPopup.tpl
$language['contactPopup_send_message'] = 'Send a message';
$language['contactPopup_mandatory_fields'] = '= this fields is mandatory';
$language['contactPopup_your_email'] = 'Your Email';
$language['contactPopup_object'] = 'Object';
$language['contactPopup_message'] = 'Message';
$language['contactPopup_security_code'] = 'Security code';
$language['contactPopup_button_send'] = 'Send';
$language['contactPopup_button_cancel'] = 'Cancel';

// index.tpl
$language['contactIndex_html_title'] = 'Contact';
$language['contactIndex_meta_description'] = 'Contact';
$language['contactIndex_arbo'] = 'Contact';
$language['contactIndex_contact'] = 'Contact';
$language['contactIndex_form'] = 'Contact form';
$language['contactIndex_email'] = 'Email';
$language['contactIndex_subject'] = 'Subject';
$language['contactIndex_message'] = 'Message';
$language['contactIndex_security_code'] = 'Security code';
$language['contactIndex_button_send'] = 'Send';


//// --> template/templateName/front/
// 404.tpl
$language['front404_html_title'] = 'Error, Page not found...';
$language['front404_meta_description'] = 'The page you want to achieve is not (or more). Excuse us for the inconvenience...';
$language['front404_h1'] = 'Error, Page not found...';
$language['front404_description'] = 'The page you want to achieve is not (or more). Excuse us for the inconvenience...';


//// --> template/templateName/includes/
// pageNavigation.tpl
$language['pageNavigation_from'] = 'from';

// profileBox.tpl
$language['profileBox_caddies'] = 'My caddies';
$language['profileBox_empty_caddies'] = 'Empty caddies';
$language['profileBox_item'] = 'item';
$language['profileBox_items'] = 'items';
$language['profileBox_cient_area'] = 'My client area';
$language['profileBox_logout'] = 'Logout';
$language['profileBox_login_registration'] = 'Login / registration';


//// --> template/templateName/javascript/
// config.tpl
$language['javascriptConfig_changes_were_saved'] = 'Changes were saved';
$language['javascriptConfig_loading_content'] = 'Loading...';
$language['javascriptConfig_loading_title'] = 'Loading';
$language['javascriptConfig_please_enter_your_pseudo'] = 'Please enter your pseudo'; 
$language['javascriptConfig_please_enter_your_email'] = 'Please enter your email';    
$language['javascriptConfig_please_confirm_your_email'] = 'Please confirm your email';    
$language['javascriptConfig_please_enter_password'] = 'Please enter password';    
$language['javascriptConfig_please_confirm_your_password'] = 'Please confirm your password';    
$language['javascriptConfig_please_enter_captcha_code'] = 'Please enter captcha code';    
$language['javascriptConfig_your_email_format'] = 'Your email must be in format - name@domain.com';
$language['javascriptConfig_your_changes_were_saved'] = 'Your changes were saved';
$language['javascriptConfig_you_just_add_to_cart_the_next_product'] = 'You just add to cart the next product';
$language['javascriptConfig_your_message_was_sent'] = 'Your message was sent';
$language['javascriptConfig_your_comment_was_saved'] = 'Your comment was saved';
$language['javascriptConfig_new_password_was_sent_to_your_email'] = 'New password was sent to your email';
$language['We haven\'t this email in database'] = 'We haven\'t this email in database';
$language['Confirmation link expired.'] = 'Confirmation link expired.';
$language['javascript_config_file'] = 'File';
$language['javascript_config_was_uploaded_sucessfully'] = 'was uploaded sucessfully';
$language['javascript_config_of'] = 'of';
$language['javascript_config_available_photos_uploaded'] = 'available photos uploaded';
$language['javascript_config_passwords_are_not_equal'] = 'Passwords aren\'t equal';
$language['javascript_config_emails_are_not_equal'] = 'Emails aren\'t equal';
$language['javascript_config_emails_was_used_earlier']  = 'Email was used earlier';
$language['javascriptConfig_wrong_password']  = 'Wrong password';
$language['javascriptConfig_this_field_is_required']  = 'This field is required';
$language['javascriptConfig_new_password_changed']  = 'New password changed';
$language['javascriptConfig_thank_you_payment_processing']  = 'Thank you, we are processing your payment';
$language['javascriptConfig_Please_enter_a_correct_date,_needed_format_is_dd/mm/YYYY']  = 'Please enter a correct date, needed format is dd/mm/YYYY';


//// --> template/templateName/main/
// index.tpl
$language['mainIndex_html_title'] = 'Liste des voyants / mediums à consulter en ligne et en direct';
$language['mainIndex_meta_description'] = 'Consulter des voyants et mediums professionnel en ligne et en direct sélectionner par Kinthia.com';
$language['mainIndex_h1'] = 'Tirage des cartes et tarots en direct - Voyance en ligne avec des voyants / mediums professionnels';


//// --> template/templateName/newsletter/
// confirmNewsletterEmailAdd.tpl
$language['newsletter_email_verification'] = 'Email verification';
$language['newsletter_thank_you_confirmation_newsletter'] = 'Thank you for confirming your registration to the newsletter';

// confirmNewsletterEmailDel.tpl
$language['newsletter_email_deleted_verification'] = 'Email deleted verification';
$language['newsletter_thank_you_confirmation_unsubscribe'] = 'Thank you for confirming your unsubscribe to the newsletter';

// index.tpl
$language['newsletter_html_title'] = 'Newsletter';
$language['newsletter_meta_description'] = 'Subscribe to newsletter';
$language['newsletter_arbo'] = 'Newsletter';
$language['newsletter_h1'] = 'Newsletter';
$language['newsletter_your_email'] = 'Your email';
$language['newsletter_button_subscribe'] = 'Subscribe';
$language['newsletter_button_unsubscribe'] = 'Unsubscribe';
$language['Email must have format login@domain.com'] = 'Email must have format login@domain.com';
$language['Your email was added. Check your inbox to confirm it'] = 'Your email was added. Check your inbox to confirm it';
$language['This email was added earlier'] = 'This email was added earlier';
$language['Check your inbox and click on remove link'] = 'Pour définitivement supprimer votre email de la newsletter, merci de confirmer votre désinscription en cliquant sur le lien présent dans le mail qui vient de vous être envoyé.';
$language['This email do not exists in our db'] = 'This email do not exists in our db';


//// --> template/templateName/voyant/
// details.tpl
$language['voyantDetails_hourly'] = 'Hourly';
$language['voyantDetails_contact_possibilites'] = 'Contact possibilites';
$language['voyantDetails_support_divinatory'] = 'Support divinatory';
$language['voyantDetails_see_comments'] = 'See comments';
$language['voyantDetails_quantity'] = 'Quantity :';
$language['voyantDetails_you win'] = 'You win';
$language['voyantDetails_voyant_not_available'] = 'Voyant isn\'t availalbe';
$language['You just add to cart the next product'] = 'You just add to cart the next product';


//// --> template/templateName/voyantQuestion/
// details.tpl
$language['voyantQuestionDetails_quantity'] = 'Quantity :';
$language['voyantQuestionDetails_you win'] = 'You win';


/* END Front Sites Texts */



/*foreach ($language as $key => $val)
{
	$language[$key] = str_replace("'", "`",$val);
} */

// set values of English expressions same as keys
if ($languageName == 'English')
{
	foreach ($language as $key => $val)
	{
		if ($val == '')
			$language[$key] = $key;
	}
}
?>

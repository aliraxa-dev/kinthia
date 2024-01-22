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


//// --> template/templateName/main/
// index.tpl
$language['mainIndex_html_title'] = 'Liste des voyants / mediums à consulter en ligne et en direct';
$language['mainIndex_meta_description'] = 'Consulter des voyants et mediums professionnel en ligne et en direct sélectionner par Kinthia.com';
$language['mainIndex_h1'] = 'Tirage des cartes et tarots en direct - Voyance en ligne avec des voyants / mediums professionnels';
$language['mainPasswordConfirmationForm_change'] = 'Password Change';


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


//// --> template/templateName/voyantQuestion/
// details.tpl
$language['voyantQuestionDetails_quantity'] = 'Quantity :';
$language['voyantQuestionDetails_you win'] = 'You win';


//// --> template/templateName/user/comment/
// popup.tpl
$language['commentPopup_post_comment'] = 'Post a comment';
$language['commentPopup_rating'] = 'Rating';
$language['commentPopup_message'] = 'Message';
$language['commentPopup_button_send'] = 'Send';
$language['commentPopup_button_cancel'] = 'Cancel';
$language['commentPopup_already_commented'] = 'You have already commented this site today.';


//// --> template/templateName/user/includes/
// profileMenu.tpl
$language['profileMenu_account_management'] = 'Account management';
$language['profileMenu_order_tracking'] = 'Order tracking';
$language['profileMenu_information'] = 'Your information';
$language['profileMenu_photo'] = 'Your photo';


//// --> template/templateName/user/main/
// logIn.tpl
$language['mainLogin_title_html'] = 'Login / Registration';
$language['mainLogin_meta_description'] = 'Login / Registration';
$language['mainLogin_title_arbo'] = 'Login / Registration';
$language['mainLogin_h1'] = 'Already a member ?';
$language['mainLogin_desc'] = 'Enter your IDs below';
$language['mainLogin_wrong'] = 'You have entered wrong login / password';
$language['mainLogin_email'] = 'Email';
$language['mainLogin_pass'] = 'Password';
$language['mainLogin_remember'] = 'Remember me';
$language['mainLogin_forgot_pass'] = 'Forgot password?';
$language['mainLogin_button_login'] = 'Login';

// lostPassword.tpl
$language['lostPassword_lost_password'] = 'Lost password';
$language['lostPassword_description_1'] = 'Enter your email address below if you have forgotten your password.';
$language['lostPassword_description_2'] = 'You will receive an email containing a link to change your password.';
$language['lostPassword_this_fields_mandatory'] = '= this fields is mandatory';
$language['lostPassword_your_email'] = 'Your email';
$language['lostPassword_security_code'] = 'Security code';
$language['lostPassword_button_send_new_password'] = 'Send new password';
$language['lostPassword_button_cancel'] = 'Cancel';
$language['We haven\'t this email in database'] = 'We haven\'t this email in database';


//// --> template/templateName/user/management/
// index.tpl
$language['managementIndex_title_html'] = 'My client area';
$language['managementIndex_meta_description'] = 'My client area';
$language['managementIndex_arbo'] = 'My client area';
$language['managementIndex_manage_my_account'] = 'I manage my account';
$language['managementIndex_change_personnal_info'] = 'I change my personnal information';
$language['managementIndex_email_first_name'] = '(email, first name, last name, birtdate, newsletter...)';
$language['managementIndex_change_pass'] = 'I change my password';
$language['managementIndex_manage_photos'] = 'I manage my photos';
$language['managementIndex_add_delete_photos'] = 'I add or delete photos';
$language['managementIndex_photos_more_info'] = 'Give more information to voyant';
$language['managementIndex_order_tracking'] = 'My order tracking';
$language['managementIndex_see_order_tracking'] = 'I see my order tracking';
$language['managementIndex_order_tracking_more_info'] = '(you can see invoice, add comment/rating, see summary...)';
$language['managementIndex_payment_methods'] = 'Payment Methods';
$language['managementIndex_security_shopping'] = 'The security of my shopping';
$language['managementIndex_reimbursed'] = 'be reimbursed';


//// --> template/templateName/user/order/
// index.tpl
$language['orderIndex_title_html'] = 'My order tracking';
$language['orderIndex_meta_description'] = 'My order tracking';
$language['orderIndex_arbo'] = 'My order tracking';
$language['orderIndex_order_number'] = 'Order number';
$language['orderIndex_items'] = 'Items';
$language['orderIndex_quantity'] = 'Quantity';
$language['orderIndex_status'] = 'Status';
$language['orderIndex_questions'] = 'Questions';
$language['orderIndex_purchase_date'] = 'Purchase Date';
$language['orderIndex_voyant'] = 'Voyant';
$language['orderIndex_see_summary'] = 'See Summary';
$language['orderIndex_rating_comment'] = 'Add rating / comment';
$language['orderIndex_see_invoice'] = 'See invoice';
$language['orderIndex_contact'] = 'Contact';
$language['orderIndex_pending'] = 'Pending';
$language['orderIndex_unpaid'] = 'Unpaid';
$language['orderIndex_paid'] = 'Paid';
$language['orderIndex_answered'] = 'Answered';
$language['orderIndex_see'] = 'See';
$language['orderIndex_comment_rating'] = 'comment / rating';
$language['orderIndex_comment_rating_title'] = 'Post a comment';
$language['orderIndex_contact_voyant'] = 'contact voyant';
$language['orderIndex_contact_voyant_title'] = 'contact voyant';

// ratingComment.tpl

// refund.tpl
$language['orderRefund_title_html'] = 'Claim';
$language['orderRefund_meta_description'] = 'Claim';
$language['orderRefund_arbo'] = 'Claim';
$language['orderRefund_h1'] = 'Claim';
$language['orderRefund_explanation'] = 'Explanation message';
$language['orderRefund_order_paiement'] = 'Order paiement';
$language['orderRefund_select_order_paiement'] = 'Select an order paiement';
$language['orderRefund_message'] = 'Message';
$language['orderRefund_button_send'] = 'Send';

// summary.tpl
$language['orderSummary_title_html'] = 'Summary of your consultations';
$language['orderSummary_meta_description'] = 'Summary of your consultations';
$language['orderSummary_arbo'] = 'Summary of your consultations';
$language['orderSummary_h1'] = 'Summary of your question :';


//// --> template/templateName/user/profile/
// index.tpl
$language['profileIndex_title_html'] = 'Your personal information';
$language['profileIndex_meta_description'] = 'Your personal information';
$language['profileIndex_arbo'] = 'Your personal information';
$language['profileIndex_h1'] = 'Your Login';
$language['profileIndex_desc'] = 'Here you can manage all your personal information : email, password';
$language['profileIndex_email'] = 'Email';
$language['profileIndex_repeat_email'] = 'Repeat email';
$language['profileIndex_change_password'] = 'Change password';
$language['profileIndex_change_password_click_here'] = 'If you want change password click here';
$language['profileIndex_new_pass'] = 'New password';
$language['profileIndex_repeat_new_pass'] = 'Repeat new password';
$language['profileIndex_h1_personnal_information'] = 'Personnal information';
$language['profileIndex_pseudo'] = 'Pseudo';
$language['profileIndex_title'] = 'Title';
$language['profileIndex_melle'] = 'Mrs.';
$language['profileIndex_madame'] = 'Ms.';
$language['profileIndex_monsieur'] = 'Mr.';
$language['profileIndex_first_name'] = 'First Name';
$language['profileIndex_last_name'] = 'Last Name';
$language['profileIndex_birthdate'] = 'Birthdate';
$language['profileIndex_phone'] = 'Phone';
$language['profileIndex_mobile_phone'] = 'Mobile Phone';
$language['profileIndex_newsletter'] = 'subscribe to newsletter';
$language['profileIndex_save'] = 'Save';
$language['Your changes was saved'] = 'Your changes was saved';

// photo.tpl
$language['photoIndex_title_html'] = 'My photo';
$language['photoIndex_meta_description'] = 'My photo';
$language['photoIndex_arbo'] = 'My photo';
$language['photoIndex_h1'] = 'My photo';
$language['photoIndex_desc'] = 'If voyant want see your photo, you can upload here';
$language['photoIndex_add_photo'] = 'Add photo';
$language['of'] = 'of';


//// --> template/templateName/user/register/
// confirmUserEmail.tpl
$language['registerConfirmUserEmail_title_html'] = 'Thank you for checking your email';
$language['registerConfirmUserEmail_meta_description'] = 'Thank you for checking your email';
$language['registerConfirmUserEmail_arbo'] = 'Thank you for checking your email';
$language['registerConfirmUserEmail_h1'] = 'Thank you for checking your email';
$language['registerConfirmUserEmail_desc'] = 'Thank you for verifying your email';
$language['registerConfirmUserEmail_desc0'] = 'You can now log into your account';

// registerForm.tpl
$language['registerRegisterForm_new_create_account'] = 'New ? Create an account';
$language['registerRegisterForm_pseudo'] = 'Pseudo';
$language['registerRegisterForm_email'] = 'Email';
$language['registerRegisterForm_repeat_email'] = 'Repeat email';
$language['registerRegisterForm_password'] = 'Password';
$language['registerRegisterForm_repeat_password'] = 'Repeat password';
$language['registerRegisterForm_subscribe_newsletter'] = 'Subscribe newsletter';
$language['registerRegisterForm_security_code'] = 'Security code';
$language['registerRegisterForm_button_registration'] = 'Registration';
$language['Passwords aren\'t equal']  = 'Passwords aren\'t equal';
$language['javascript_config_emails_was_used_earlier']  = 'Email déjà utilisé';
$language['Your email must be in format - name@domain.com']  = 'Your email must be in format - name@domain.com';








$language['mainLogin_terms'] = 'Terms of referencing';
$language['mainLogin_new_create'] = 'New ? Create an account';
$language['mainLogin_desc2'] = 'By registering, you can post and manage your website';
$language['mainLogin_repeat_pass'] = 'Repeat password';
$language['mainLogin_subscribe_news'] = 'Subscribe newsletter';
$language['mainLogin_security_code'] = 'Security code';
$language['mainLogin_button_registration'] = 'Registration';
$language['The registration was successful! You can login now.'] = 'The registration was successful! You can login now.';








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

<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/* !! set this value to the current language name, when creating new languages !! */
$languageName = 'Français';

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


/* Front Sites Texts */

// all
$language['language'] = 'fr';
$language['show_arbo_voyance'] = 'Voyance';
$language['show_arbo_tirage'] = 'Tirage des cartes - Voyance en direct';
$language['page'] = 'page';
$language['euro_symbole'] = '€';
$language['euro_text'] = 'EURO';
$language['euro_text_abreviation'] = 'EUR';


//// --> template/templateName/captcha/
// show.tpl
$language['captchaShow_generate_new_image'] = 'Générer un nouveau code de sécurité';


//// --> template/templateName/cart/includes/
// steps.tpl
$language['cartSteps_caddies'] = 'Mon panier';
$language['cartSteps_payment'] = 'Paiement';
$language['cartSteps_confirmation'] = 'Confirmation';


//// --> template/templateName/cart/
// addItem.tpl
$language['cartAddItem_title'] = 'Vous venez d\'ajouter au panier le(s) produit(s) suivant(s) :';
$language['cartAddItem_quantity'] = 'Quantité :';

// checkout.tpl
$language['cartCheckout_html_title'] = 'Mon panier - Kinthia.com';
$language['cartCheckout_meta_description'] = 'Mon panier - Kinthia.com';
$language['cartCheckout_arbo'] = 'Mon panier';
$language['cartCheckout_table_item'] = 'Liste des questions pour';
$language['cartCheckout_quantity'] = 'Quantité';
$language['cartCheckout_price'] = 'Prix';
$language['cartCheckout_delete'] = 'Supprimer';
$language['cartCheckout_caddies_total'] = 'Total de mon panier';
$language['cartCheckout_total_price'] = 'Total à régler';

// confirmation.tpl
$language['cartConfirmation_html_title'] = 'Confirmation / validation de votre paiement';
$language['cartConfirmation_meta_description'] = 'Confirmation / validation de votre paiement';
$language['cartConfirmation_arbo'] = 'Confirmation / validation de votre paiement';
$language['cartConfirmation_desc'] = 'Votre paiement est en cours de validation.';
$language['cartConfirmation_desc0'] = 'Une confirmation par email vous sera envoyée dès la validation du paiement effectué.';
$language['cartConfirmation_desc1'] = 'Une fois la validation du paiement effectuée, le professionnel vous contactera dans les plus brefs délais par email pour convenir d\'un rendez-vous.';
$language['cartConfirmation_desc2'] = 'Nous vous remercions pour la confiance que vous nous accordez';
$language['cartConfirmation_desc3'] = 'à Kinthia.com, et vous souhaitons une agréable journée.';
$language['cartConfirmation_desc4'] = 'L\'équipe de Kinthia.com';

// pay.tpl
$language['cartPay_html_title'] = 'Redirection vers la page de paiement sécurisé';
$language['cartPay_html_desc'] = 'Redirection en cours vers la page sécurisée pour traiter votre paiement…';
$language['cartPay_html_desc0'] = 'L\'équipe de Kinthia.com';

// paymentDetails.tpl
$language['cartPaymentDetails_html_title'] = 'Paiement - Kinthia.com';
$language['cartPaymentDetails_meta_description'] = 'Paiement - Kinthia.com';
$language['cartPaymentDetails_arbo'] = 'Paiement';
$language['cartPaymentDetails_order_total_price'] = 'Le point sur ma commande';
$language['cartPaymentDetails_total_price'] = 'Total à régler';
$language['cartPaymentDetails_payment_method'] = 'Je choisis mon mode de paiement';
$language['cartPaymentDetails_card_paypal'] = 'Je paie en ligne avec ma carte bancaire ou mon compte paypal';


//// --> template/templateName/comment/
// voyantComment.tpl
$language['voyantComment_html_title'] = 'Commentaires sur la voyante / médium';
$language['voyantComment_meta_description'] = 'Commentaires sur la voyante / médium';
$language['voyantComment_meta_description1'] = 'par des clients ayant utilisés ses services';
$language['voyantComment_arbo'] = 'Commentaires sur la voyante / médium';
$language['voyantComment_h1'] = 'Commentaires sur la voyante / médium';
$language['voyantComment_total_rating'] = 'Notes :';
$language['voyantComment_write_on'] = 'a écrit le';
$language['voyantComment_rating'] = 'Note :';
$language['voyantComment_reply'] = 'Réponse de';


//// --> template/templateName/contact/
// contactPopup.tpl
$language['contactPopup_send_message'] = 'Envoyer un message';
$language['contactPopup_mandatory_fields'] = '= champs obligatoires';
$language['contactPopup_your_email'] = 'Votre email';
$language['contactPopup_object'] = 'Sujet';
$language['contactPopup_message'] = 'Message';
$language['contactPopup_security_code'] = 'Code de sécurité';
$language['contactPopup_button_send'] = 'Envoyer';
$language['contactPopup_button_cancel'] = 'Annuler';

// index.tpl
$language['contactIndex_html_title'] = 'Contact';
$language['contactIndex_meta_description'] = 'Contact';
$language['contactIndex_arbo'] = 'Contact';
$language['contactIndex_contact'] = 'Contact';
$language['contactIndex_form'] = 'Formulaire de contact';
$language['contactIndex_email'] = 'Email';
$language['contactIndex_subject'] = 'Sujet';
$language['contactIndex_message'] = 'Message';
$language['contactIndex_security_code'] = 'Code de sécurité';
$language['contactIndex_button_send'] = 'Envoyer';


//// --> template/templateName/front/
// 404.tpl
$language['front404_html_title'] = 'Erreur, Page inaccessible ...';
$language['front404_meta_description'] = 'La page que vous avez désiré atteindre n\'existe pas (ou plus). Excusez-nous pour la gêne occasionnée ...';
$language['front404_h1'] = 'Erreur, Page inaccessible ...';
$language['front404_description'] = 'La page que vous avez désiré atteindre n\'existe pas (ou plus). Excusez-nous pour la gêne occasionnée ...';


//// --> template/templateName/includes/
// pageNavigation.tpl
$language['pageNavigation_from'] = 'sur';

// profileBox.tpl
$language['profileBox_caddies'] = 'Mon panier';
$language['profileBox_empty_caddies'] = 'Panier vide';
$language['profileBox_item'] = 'article';
$language['profileBox_items'] = 'articles';
$language['profileBox_cient_area'] = 'Mon espace client';
$language['profileBox_logout'] = 'Me déconnecter';
$language['profileBox_login_registration'] = 'Me connecter / M\'inscrire';


//// --> template/templateName/javascript/
// config.tpl
$language['javascriptConfig_changes_were_saved'] = 'Changement sauvegardé';
$language['javascriptConfig_loading_content'] = 'Chargement...';
$language['javascriptConfig_loading_title'] = 'Chargement';
$language['javascriptConfig_please_enter_your_pseudo'] = 'Merci d\'entrer votre pseudo'; 
$language['javascriptConfig_please_enter_your_email'] = 'Merci d\'entrer votre email';    
$language['javascriptConfig_please_confirm_your_email'] = 'Merci de confirmer votre email';    
$language['javascriptConfig_please_enter_password'] = 'Merci d\'entrer votre mot de passe';    
$language['javascriptConfig_please_confirm_your_password'] = 'Merci de confirmer votre mot de passe';    
$language['javascriptConfig_please_enter_captcha_code'] = 'Merci d\'entrer le code de sécurité';    
$language['javascriptConfig_your_email_format'] = 'Votre email doit être de la forme - aa@bb.com';
$language['javascriptConfig_your_changes_were_saved'] = 'Changement sauvegardé';
$language['javascriptConfig_you_just_add_to_cart_the_next_product'] = 'Ajout d\'article(s) à votre panier';
$language['javascriptConfig_your_message_was_sent'] = 'Votre message a été envoyé';
$language['javascriptConfig_your_comment_was_saved'] = 'Votre commentaire / note a été sauvegardé';
$language['javascriptConfig_new_password_was_sent_to_your_email'] = 'Votre nouveau mot de passe vient de vous être envoyé par email';
$language['We haven\'t this email in database'] = 'Cet email n\'existe pas dans notre base de données';
$language['Confirmation link expired.'] = 'Le lien pour changer votre mot de passe a expiré. Merci de redemander un nouveau changement de mot de passe.';
$language['javascript_config_file'] = 'fichier';
$language['javascript_config_was_uploaded_sucessfully'] = 'uploadée avec succès';
$language['javascript_config_of'] = 'sur';
$language['javascript_config_available_photos_uploaded'] = 'photos uploadées';
$language['javascript_config_passwords_are_not_equal'] = 'Mot de passe non identique';
$language['javascript_config_emails_are_not_equal'] = 'Emails non identique'; 
$language['javascriptConfig_wrong_password']  = 'Le mot de passe que vous avez indiqué est incorrect';
$language['javascriptConfig_change_email'] = 'Changement d\'email'; 
$language['javascriptConfig_change_password']  = 'Changement de mot de passe';
$language['javascriptConfig_this_field_is_required']  = 'Ce champ est obligatoire';
$language['javascriptConfig_new_password_changed']  = 'Mot de passe changé avec succès';
$language['javascriptConfig_thank_you_payment_processing']  = 'Votre paiement est en cours de traitement. Merci de bien vouloir patienter quelques instants.';
$language['javascriptConfig_Please_enter_a_correct_date,_needed_format_is_dd/mm/YYYY']  = 'Merci d\'indiquer une date valide. Le format de la date doit être le suivant : 31/12/1927';
$language['javascriptConfig_Please_enter_a_subject'] = 'Merci d\'indiquer le sujet de votre demande';
$language['javascriptConfig_Please_enter_a_description'] = 'Merci de nous détailler votre demande';
$language['javascriptConfig_Refund_request_sended'] = 'Votre demande de remboursement a été envoyée avec succès.';
$language['javascriptConfig_Your_password_changed'] = 'Votre mot de passe a été changé avec succès. Vous pouvez dès à présent vous connecter avec votre nouveau mot de passe.';



//// --> template/templateName/main/
// index.tpl
$language['mainIndex_html_title'] = 'Liste des voyants / médiums à consulter en ligne et en direct';
$language['mainIndex_meta_description'] = 'Consulter des voyants et médiums professionnels en ligne et en direct sélectionnés par Kinthia.com';
$language['mainIndex_h1'] = 'Voyance en direct - Tirages tarots et cartes avec des voyants / médiums professionnels';


//// --> template/templateName/newsletter/
// confirmNewsletterEmailAdd.tpl
$language['newsletter_email_verification'] = 'Vérification de votre email';
$language['newsletter_thank_you_confirmation_newsletter'] = 'Merci d\'avoir confirmé votre inscription à la newsletter';

// confirmNewsletterEmailDel.tpl
$language['newsletter_email_deleted_verification'] = 'Vérification de votre email';
$language['newsletter_thank_you_confirmation_unsubscribe'] = 'Merci d\'avoir confirmé votre désinscription à la newsletter';

// index.tpl
$language['newsletter_html_title'] = 'Newsletter';
$language['newsletter_meta_description'] = 'Inscription à la newsletter';
$language['newsletter_arbo'] = 'Newsletter';
$language['newsletter_h1'] = 'Newsletter';
$language['newsletter_your_email'] = 'Votre email';
$language['newsletter_button_subscribe'] = 'Inscription';
$language['newsletter_button_unsubscribe'] = 'Désinscription';
$language['Email must have format login@domain.com'] = 'Votre email doit être sous la forme aa@bb.com';
$language['Your email was added. Check your inbox to confirm it'] = 'Votre email a été ajouté avec succès. Pour recevoir la newsletter, merci de confirmer votre inscription en cliquant sur le lien présent dans le mail qui vient de vous être envoyé.';
$language['This email was added earlier'] = 'Cet email a déjà été ajouté à la newsletter';
$language['Check your inbox and click on remove link'] = 'Pour définitivement supprimer votre email de la newsletter, merci de confirmer votre désinscription en cliquant sur le lien présent dans le mail qui vient de vous être envoyé.';
$language['This email do not exists in our db'] = 'Cet email n\'existe pas dans notre base de données';


//// --> template/templateName/voyant/
// details.tpl
$language['voyantDetails_hourly'] = 'Horaires';
$language['voyantDetails_contact_possibilites'] = 'Possibilités de contact';
$language['voyantDetails_support_divinatory'] = 'Supports divinatoires';
$language['voyantDetails_see_comments'] = 'Commentaires';
$language['voyantDetails_quantity'] = 'Quantité :';
$language['voyantDetails_you win'] = 'Vous gagnez';
$language['voyantDetails_voyant_not_available'] = 'Le voyant n\'est pas disponible actuellement';
$language['You just add to cart the next product'] = 'Produit(s) ajouté au panier';


//// --> template/templateName/voyantQuestion/
// details.tpl
$language['voyantQuestionDetails_quantity'] = 'Quantité :';
$language['voyantQuestionDetails_you win'] = 'Vous gagnez';
$language['javascript_config_emails_was_used_earlier']  = 'Email déjà utilisé';

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

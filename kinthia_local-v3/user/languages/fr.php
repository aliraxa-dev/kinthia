﻿<?php
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
$language['cartConfirmation_desc1'] = 'Une fois la validation du paiement effectué, le professionnel vous contactera dans les plus brefs délais par email pour convenir d\'un rendez-vous.';
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
$language['javascript_config_emails_was_used_earlier']  = 'Email déjà utilisé';


//// --> template/templateName/main/
// index.tpl
$language['mainIndex_html_title'] = 'Liste des voyants / médiums à consulter en ligne et en direct';
$language['mainIndex_meta_description'] = 'Consulter des voyants et médiums professionnels en ligne et en direct sélectionnés par Kinthia.com';
$language['mainIndex_h1'] = 'Tirage des cartes et tarots en direct - Voyance en ligne avec des voyants / médiums professionnels';
$language['mainPasswordConfirmationForm_change'] = 'Password Change'; // TODO: translate to fr


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


//// --> template/templateName/voyantQuestion/
// details.tpl
$language['voyantQuestionDetails_quantity'] = 'Quantité :';
$language['voyantQuestionDetails_you win'] = 'Vous gagnez';


//// --> template/templateName/user/comment/
// popup.tpl
$language['commentPopup_post_comment'] = 'Poster un commentaire';
$language['commentPopup_rating'] = 'Note';
$language['commentPopup_message'] = 'Message';
$language['commentPopup_button_send'] = 'Envoyer';
$language['commentPopup_button_cancel'] = 'Annuler';
$language['commentPopup_already_commented'] = 'Vous avez déjà posté un commentaire aujourd\'hui.';


//// --> template/templateName/user/includes/
// profileMenu.tpl
$language['profileMenu_account_management'] = 'Je gère mon compte';
$language['profileMenu_order_tracking'] = 'Liste de mes commandes';
$language['profileMenu_information'] = 'Mes informations';
$language['profileMenu_photo'] = 'Mes photos';


//// --> template/templateName/user/main/
// logIn.tpl
$language['mainLogin_title_html'] = 'Me connecter / M\'inscrire - Kinthia.com';
$language['mainLogin_meta_description'] = 'Me connecter / M\'inscrire à Kinthia.com - Voyance et tirage des cartes en ligne';
$language['mainLogin_title_arbo'] = 'Me connecter / M\'inscrire';
$language['mainLogin_h1'] = 'Déjà membre ? Connectez-vous';
$language['mainLogin_desc'] = 'Entrez vos identifiants ci-dessous';
$language['mainLogin_wrong'] = 'Vous avez indiqué un mot de passe / nom d\'utilisateur incorrect';
$language['mainLogin_email'] = 'Email';
$language['mainLogin_pass'] = 'Mot de passe';
$language['mainLogin_remember'] = 'Se souvenir de moi';
$language['mainLogin_forgot_pass'] = 'Mot de passe oublié?';
$language['mainLogin_button_login'] = 'Connexion';

// lostPassword.tpl
$language['lostPassword_lost_password'] = 'Mot de passe perdu';
$language['lostPassword_description_1'] = 'Si vous avez perdu votre mot de passe, entrez votre adresse email ci-dessous.';
$language['lostPassword_description_2'] = 'Vous recevrez un email contenant un lien qui vous permettra de changer votre mot de passe.';
$language['lostPassword_this_fields_mandatory'] = '= champs obligatoires';
$language['lostPassword_your_email'] = 'Votre email';
$language['lostPassword_security_code'] = 'Code de sécurité';
$language['lostPassword_button_send_new_password'] = 'Envoyer le nouveau mot de passe';
$language['lostPassword_button_cancel'] = 'Annuler';
$language['We haven\'t this email in database'] = 'Cet email n\'existe pas dans notre base de données';
$language['Confirmation link expired.'] = 'Le lien pour changer votre mot de passe a expiré. Merci de redemander un nouveau changement de mot de passe.';
$language['Token is not secure.'] = 'Le lien pour changer votre mot de passe n\'est plus valide. Merci de recommencer la procédure pour obtenir un nouveau changement de mot de passe.';


//// --> template/templateName/user/management/
// index.tpl
$language['managementIndex_title_html'] = 'Mon espace client - Kinthia.com';
$language['managementIndex_meta_description'] = 'Mon espace client - Kinthia.com';
$language['managementIndex_arbo'] = 'Mon espace client';
$language['managementIndex_manage_my_account'] = 'Je gère mon compte';
$language['managementIndex_change_personnal_info'] = 'Je modifie mes informations personnelles';
$language['managementIndex_email_first_name'] = '(email, nom, prénom, date de naissance, newsletter...)';
$language['managementIndex_change_pass'] = 'Je change mon mot de passe';
$language['managementIndex_manage_photos'] = 'Je gère mes photos';
$language['managementIndex_add_delete_photos'] = 'J\'ajoute ou supprime des photos';
$language['managementIndex_photos_more_info'] = 'Permet de donner plus d\'informations au voyant';
$language['managementIndex_order_tracking'] = 'Le suivi de mes commandes';
$language['managementIndex_see_order_tracking'] = 'Je visualise la liste de mes commandes';
$language['managementIndex_order_tracking_more_info'] = '(Vous pouvez consulter vos factures, ajouter des commentaires, noter votre voyant, consulter le résumé de vos consultations...)';
$language['managementIndex_payment_methods'] = 'Mes services paiement';
$language['managementIndex_security_shopping'] = 'La sécurité de mes achats';
$language['managementIndex_reimbursed'] = 'Je demande à être remboursé de ma commande';


//// --> template/templateName/user/order/
// index.tpl
$language['orderIndex_title_html'] = 'Mon suivi de commande - Kinthia.com';
$language['orderIndex_meta_description'] = 'Mon suivi de commande - Kinthia.com';
$language['orderIndex_arbo'] = 'Mon suivi de commande';
$language['orderIndex_order_number'] = 'Commande N°';
$language['orderIndex_items'] = 'Articles';
$language['orderIndex_quantity'] = 'Quantité';
$language['orderIndex_status'] = 'Paiement';
$language['orderIndex_questions'] = 'Statut';
$language['orderIndex_purchase_date'] = 'Date';
$language['orderIndex_voyant'] = 'Voyant';
$language['orderIndex_see_summary'] = 'Résumé';
$language['orderIndex_rating_comment'] = 'Commentaire / note';
$language['orderIndex_see_invoice'] = 'Facture';
$language['orderIndex_contact'] = 'Contact';
$language['orderIndex_pending'] = 'en attente';
$language['orderIndex_unpaid'] = 'non payé';
$language['orderIndex_paid'] = 'Payé';
$language['orderIndex_answered'] = 'Répondu';
$language['orderIndex_see'] = 'Voir';
$language['orderIndex_comment_rating'] = 'commenter / noter';
$language['orderIndex_comment_rating_title'] = 'Poster un commentaire sur le voyant';
$language['orderIndex_contact_voyant'] = 'contacter';
$language['orderIndex_contact_voyant_title'] = 'Contacter le voyant';

// ratingComment.tpl

// refund.tpl
$language['orderRefund_title_html'] = 'Demande de remboursement - Kinthia.com';
$language['orderRefund_meta_description'] = 'Demande de remboursement - Kinthia.com';
$language['orderRefund_arbo'] = 'Demande de remboursement';
$language['orderRefund_h1'] = 'Demande de remboursement';
$language['orderRefund_explanation'] = 'Merci de sélectionner la commande pour laquelle vous souhaitez être remboursé';
$language['orderRefund_order_paiement'] = 'N° de commande';
$language['orderRefund_select_order_paiement'] = 'Sélectionner un numéro de commande';
$language['orderRefund_message'] = 'Message';
$language['orderRefund_button_send'] = 'Demander le remboursement';

// summary.tpl
$language['orderSummary_title_html'] = 'Résumé de votre consultation';
$language['orderSummary_meta_description'] = 'Résumé de votre consultation';
$language['orderSummary_arbo'] = 'Résumé de votre consultation';
$language['orderSummary_h1'] = 'Résumé de votre question :';


//// --> template/templateName/user/profile/
// index.tpl
$language['profileIndex_title_html'] = 'Vos informations personnelles - Kinthia.com';
$language['profileIndex_meta_description'] = 'Vos informations personnelles - Kinthia.com';
$language['profileIndex_arbo'] = 'Vos informations personnelles';
$language['profileIndex_h1'] = 'Vos identifiants';
$language['profileIndex_desc'] = 'Ici, vous pouvez gérer toutes vos informations personnelles : email, mot de passe';
$language['profileIndex_email'] = 'Email';
$language['profileIndex_repeat_email'] = 'Répéter votre email';
$language['profileIndex_change_password'] = 'Changer votre mot de passe';
$language['profileIndex_change_password_click_here'] = 'Si vous voulez changez votre mot de passe cliquez ici';
$language['profileIndex_new_pass'] = 'Nouveau mot de passe';
$language['profileIndex_repeat_new_pass'] = 'Répéter votre nouveau mot de passe';
$language['profileIndex_h1_personnal_information'] = 'Informations personnelles';
$language['profileIndex_pseudo'] = 'Pseudo';
$language['profileIndex_title'] = 'Titre';
$language['profileIndex_melle'] = 'Mademoiselle';
$language['profileIndex_madame'] = 'Madame';
$language['profileIndex_monsieur'] = 'Monsieur';
$language['profileIndex_first_name'] = 'Prénom';
$language['profileIndex_last_name'] = 'Nom';
$language['profileIndex_birthdate'] = 'Date de naissance';
$language['profileIndex_phone'] = 'Téléphone';
$language['profileIndex_mobile_phone'] = 'Téléphone mobile';
$language['profileIndex_newsletter'] = 'M\'inscrire à la newsletter';
$language['profileIndex_save'] = 'Sauvegarder';
$language['Your changes was saved'] = 'Changement sauvegardé';

// photo.tpl
$language['photoIndex_title_html'] = 'Mes photos - Kinthia.com';
$language['photoIndex_meta_description'] = 'Mes photos - Kinthia.com';
$language['photoIndex_arbo'] = 'Mes photos';
$language['photoIndex_h1'] = 'Mes photos';
$language['photoIndex_desc'] = 'Si un voyant veut voir des photos, vous pouvez les héberger ici';
$language['photoIndex_add_photo'] = 'Ajouter des photos';
$language['of'] = 'sur';


//// --> template/templateName/user/register/
// confirmUserEmail.tpl
$language['registerConfirmUserEmail_title_html'] = 'Merci d\'avoir vérifié votre email';
$language['registerConfirmUserEmail_meta_description'] = 'Merci d\'avoir vérifié votre email';
$language['registerConfirmUserEmail_arbo'] = 'Merci d\'avoir vérifié votre email';
$language['registerConfirmUserEmail_h1'] = 'Merci d\'avoir vérifié votre email';
$language['registerConfirmUserEmail_desc'] = 'Merci d\'avoir vérifié votre email';
$language['registerConfirmUserEmail_desc0'] = 'Vous pouvez maintenant vous connecter à votre compte utilisateur';

// registerForm.tpl
$language['registerRegisterForm_new_create_account'] = 'Nouveau ? Créez un compte';
$language['registerRegisterForm_pseudo'] = 'Pseudo';
$language['registerRegisterForm_email'] = 'Email';
$language['registerRegisterForm_repeat_email'] = 'Répéter votre email';
$language['registerRegisterForm_password'] = 'Mot de passe';
$language['registerRegisterForm_repeat_password'] = 'Répéter votre mot de passe';
$language['registerRegisterForm_subscribe_newsletter'] = 'S\'inscrire à la newsletter';
$language['registerRegisterForm_security_code'] = 'Code de sécurité';
$language['registerRegisterForm_button_registration'] = 'M\'inscrire';
$language['Passwords aren\'t equal'] = 'Mot de passe non identique';
$language['The registration was successful! You can login now.'] = 'Création du compte réussi - Vous pouvez maintenant vous connecter à votre compte utilisateur';









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

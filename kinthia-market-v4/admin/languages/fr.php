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
$language['english_phrase'] = 'Translated phrase';
$language['javascript_config_loading_content'] = 'Chargement...';

//// --> /template/templateName/main/
// index.tpl

$language['mainIndex_welcome_kinthia'] = 'Bienvenue dans le script de Kinthia';
$language['mainIndex_stats'] = 'Statistiques';
$language['mainIndex_value'] = 'Valeur';
$language['mainIndex_question_ok'] = 'Questions répondues';
$language['mainIndex_pending_questions'] = 'Questions en attente';
$language['mainIndex_users'] = 'Utilisateurs';
$language['mainIndex_database_size'] = 'Base de données';
$language['mainIndex_reset'] = 'Remettre à zéro certaines parties du script Kinthia à 0';
$language['mainIndex_run'] = 'Exécuter';
$language['mainIndex_clear_cache'] = 'Vider le cache';
$language['mainIndex_clear_cache_desk'] = 'Permet de supprimer le cache et les requêtes en cache';

// logIn.tpl
$language['mainLogIn_login_title'] = 'Se connecter à l\'administration du script Kinthia';
$language['mainLogIn_login'] = 'Identifiant';
$language['mainLogIn_password'] = 'Mot de passe';
$language['mainLogIn_loginin_button'] = 'Se connecter';
$language['mainLogIn_forgot_password'] = 'Mot de passe perdu?';

// lostPassword.tpl
$language['mainLostPassword_lost_password_title'] = 'Mot de passe perdu';
$language['mainLostPassword_lost_password_meta_description'] = 'Mot de passe perdu';


//// --> /template/templateName/menuheader/
// menuheader.tpl
$language['MenuHeader_Directory'] = 'Général';
$language['MenuHeader_Settings'] = 'Configuration';
$language['MenuHeader_Adsense'] = 'Publicité';
$language['MenuHeader_Users'] = 'Utilisateurs';
$language['MenuHeader_Templates'] = 'Design';
$language['MenuHeader_System'] = 'Système';


//// --> /template/templateName/menuleft/
// LogIn.tpl
$language['MenuLeftLogIn_Logged_in_as'] = 'Vous êtes connectée en tant que';
$language['MenuLeftLogIn_Logout'] = 'Déconnexion';

// MenuLeftAdsense.tpl
$language['MenuLeftAdsense_Criteria'] = 'Critères';
$language['MenuLeftAdsense_Manage_criteria'] = 'Gérer les critères';
$language['MenuLeftAdsense_Adsense'] = 'Publicité';
$language['MenuLeftAdsense_Adsense_in_index'] = 'Publicité dans l\'index';
$language['MenuLeftAdsense_Adsense_in_news'] = 'Publicité dans les nouveautés';
$language['MenuLeftAdsense_Adsense_in_top_hits'] = 'Publicité aux rentabilités supérieures';
$language['MenuLeftAdsense_Adsense_in_top_notes'] = 'Publicité les mieux notées';
$language['MenuLeftAdsense_Adsense_in_top_rank'] = 'Publicité au meilleur grade';

// MenuLeftIndex.tpl
$language['MenuLeftIndex_Questions'] = 'Questions';
$language['MenuLeftIndex_Pending_User_Questions'] = 'Questions d\'utilisateurs en attente';
$language['MenuLeftIndex_Pending_orders'] = 'File d\'attente';
$language['MenuLeftIndex_Add_voyant_question'] = 'Ajouter des questions au voyant';


// MenuLeftUsers.tpl
$language['MenuLeftUsers_Users'] = 'Users';
$language['MenuLeftUsers_Security'] = 'Sécurité';
$language['MenuLeftUsers_Ban_IPs'] = 'Bannir des IPs';
$language['MenuLeftUsers_Ban_Emails'] = 'Bannir des Emails';
$language['MenuLeftUsers_Newsletter_mass_mailer'] = 'Envoi de masse de lettres d\'actualité';
$language['MenuLeftUsers_Send_Newsletter_mass_mailer'] = 'Envoi des lettres d\'actualité en masse';
$language['MenuLeftUsers_Export_import_mails'] = 'Importer/exporter des e-mails';


//// --> /template/templateName/order/
// Pending.tpl
$language['Pending_Users'] = 'Utilisateurs';
$language['Pending_Question_select_by_user'] = 'Question choisie par l\'utilisateur';
$language['Pending_Payment_pending'] = 'Paiement en attente';
$language['Pending_Order_number'] = 'File d\'attente';
$language['Pending_Check_ok'] = 'Question traitée';
$language['Pending_Check_all'] = 'Tout sélectionner';
$language['Pending_Check_status'] = 'Statut';


//// --> /template/templateName/voyant/
// Edit.tpl
$language['Edit_Yes'] = 'Oui';
$language['Edit_No'] = 'Non';
$language['Edit_Save'] = 'Sauvegarder';
$language['Edit_Delete'] = 'Supprimer';
$language['Edit_Ban_IP'] = 'Bannir IP';
$language['Edit_Edit_voyant'] = 'Editer le voyant';

// Index.tpl
$language['Index_Voyant_Name'] = 'Nom du voyant';
$language['Index_Number'] = 'Nombre de questions traitées';

// Summary.tpl
$language['Summary_Pseudo_name'] = 'Pseudo - Nom, prénom';
$language['Summary_Question_title'] = 'Intitulé de la question';
$language['Summary_Title'] = 'Titre';


//// --> /template/templateName/userQuestion/
// Pending.tpl
$language['Pending_Create'] = 'Créer une nouvelle question';
$language['Pending_Pending_Questions'] = 'Questions en attente';

// Summary.tpl
$language['Summary_Question_summary'] = 'Sommaire de la question de l\'utilisateur';
$language['Summary_Pseudo_name'] = 'Pseudo - Nom, prénom';
$language['Summary_Question_title'] = 'Intitulé de la question';


//// --> /template/templateName/voyantQuestion/
// Create.tpl
$language['Create_Create'] = 'Créer une nouvelle question';



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
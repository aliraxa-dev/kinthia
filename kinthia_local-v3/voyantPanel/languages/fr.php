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
// ChangePassword.tpl
$language['ChangePassword_New_password'] = 'Nouveau mot de passe';
$language['ChangePassword_Repeat_new_password'] = 'Répéter un nouveau mot de passe';
$language['ChangePassword_Moderator_change_password'] = 'Modératrice - Changer le mot de passe';

// Index.tpl
$language['Index_Statistic'] = 'Statistiques';
$language['Index_Value'] = 'Valeur';
$language['Index_Questions_ok'] = 'Questions traitées';
$language['Index_Pending_Questions'] = 'Questions en attente';
$language['Index_Users'] = 'Utilisateurs';
$language['Index_Pending_check'] = 'Contrôle de la file d\'attente';
$language['Index_Availability'] = 'Disponibilité';

// LostPassword.tpl
$language['LostPassword_Lost_password'] = 'Mot de passe perdu';


//// --> /template/templateName/menuheader
// MenuHeader.tpl
$language['MenuHeader_Directory'] = 'Généralités';
$language['MenuHeader_Users'] = 'Utilisateurs';


//// --> /template/templateName/menuleft
// Login.tpl
$language['Login_Logout'] = 'Déconnexion';

// MenuleftUsers.tpl
$language['MenuleftUsers_Logout'] = 'Logout';
$language['MenuleftUsers_Users'] = 'Users';
$language['MenuleftUsers_Logged_in_as'] = 'You are logged in as';

// MenuleftIndex.tpl
$language['MenuleftIndex_User_Questions'] = 'User questions';
$language['MenuleftIndex_Pending_user_questions'] = 'Questions en attente d\'utilisateurs';
$language['MenuleftIndex_Pending_check'] = 'Contrôle de l\'attente';
$language['MenuleftIndex_Voyant_questions'] = 'Questions du voyant';
$language['MenuleftIndex_Voyant_questions_list'] = 'Liste des questions du voyant';
$language['MenuleftIndex_Add_voyant_questions'] = 'Ajouter des questions au voyant';


//// --> /template/templateName/order
// Pending.tpl
$language['Pending_Pending_user_questions'] = 'Questions en attente de l\'utilisateur';
$language['Pending_Pending_check_orders'] = 'Contrôle de la file d\attente';


//// --> /template/templateName/user
// Show.tpl
$language['Show_user_details'] = 'Détails de l\'utilisateur';
$language['Show_First_name'] = 'Prénom';
$language['Show_Last_name'] = 'Nom';
$language['Show_Birthday'] = 'Jour d\'anniversaire';
$language['Show_Question_tilte'] = 'Intitulé de la question';
$language['Show_Status'] = 'Statut';
$language['Show_Paypal_id'] = 'Numéro de la transaction';
$language['Show_In_voice'] = 'Facture';
$language['Show_Comments'] = 'Commentaires';
$language['Show_Rating'] = 'Note';
$language['Show_Valitated'] = 'Validé';
$language['Show_Management'] = 'Gestion';
$language['Show_Reply'] = 'Répondre';
$language['Show_Yes'] = 'Oui';
$language['Show_No'] = 'Non';
$language['Show_Save'] = 'Sauvegarder';
$language['Show_Delete'] = 'Supprimer';



//// --> /template/templateName/userQuestion
// Pending.tpl
$language['Pending_Pending_user_question'] = 'Questions de l\'utilisateur en attente';
$language['Pending_Pending_question'] = 'Questions en attente';
$language['Pending_Question_finished'] = 'Question traitée';

// Summary.tpl
$language['Summary_User_question_summary'] = 'Résumé de la question de l\'utilisateur';
$language['Summary_pseudo_name'] = 'Pseudo - Nom, prénom:';
$language['Summary_question_title'] = 'Intitulé de la question';


//// --> /template/templateName/voyantQuestion
// Create.tpl
$language['Create_create'] = 'Create new question';

// CrudForm.tpl
$language['CrudForm_Title'] = 'Title';
$language['CrudForm_Short_description'] = 'Short description';
$language['CrudForm_Long_description'] = 'Longue description';
$language['CrudForm_Price'] = 'Prix';
$language['CrudForm_Additional_price'] = 'Total';

// Edit.tpl
$language['Edit_Edit_question'] = 'Editer la question';

// Index.tpl
$language['Index_Voyant_questions'] = 'Questions du voyant';
$language['Index_Question_title'] = 'Intitulé de la question';
$language['Index_Management'] = 'Gestion';

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
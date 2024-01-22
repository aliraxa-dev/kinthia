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
$language['english_phrase'] = 'Translated phrase';


//// --> /template/templateName/main/
// index.tpl
$language['mainIndex_welcome_kinthia'] = 'Welcome to Kinthia Script';
$language['mainIndex_stats'] = 'Statistics';
$language['mainIndex_value'] = 'Value';
$language['mainIndex_question_ok'] = 'Questions ok';
$language['mainIndex_pending_questions'] = 'Pending questions';
$language['mainIndex_users'] = 'Users';
$language['mainIndex_database_size'] = 'Database size';
$language['mainIndex_reset'] = 'Reset certain parts of the directory to 0';
$language['mainIndex_run'] = 'Run';
$language['mainIndex_clear_cache'] = 'Clear cache';
$language['mainIndex_clear_cache_desk'] = 'Allows emptying the cache as well as all the cached queries';

// logIn.tpl
$language['mainLogIn_login_title'] = 'Login to Arfooo directory Admin panel';
$language['mainLogIn_login'] = 'Login';
$language['mainLogIn_password'] = 'Password';
$language['mainLogIn_loginin_button'] = 'Login Button';
$language['mainLogIn_forgot_password'] = 'Forgot your password?';

// lostPassword.tpl
$language['mainLostPassword_lost_password_title'] = 'Lost Password';
$language['mainLostPassword_lost_password_meta_description'] = 'Lost Password';


//// --> /template/templateName/menuheader/
// menuheader.tpl
$language['MenuHeader_Directory'] = 'Directory';
$language['MenuHeader_Settings'] = 'Settings';
$language['MenuHeader_Adsense'] = 'Adsense';
$language['MenuHeader_Users'] = 'Users';
$language['MenuHeader_Templates'] = 'Templates';
$language['MenuHeader_System'] = 'System';


//// --> /template/templateName/menuleft/
// LogIn.tpl
$language['MenuLeftLogIn_Logged_in_as'] = 'You are logged in as';
$language['MenuLeftLogIn_Logout'] = 'Logout';

// MenuLeftAdsense.tpl
$language['MenuLeftAdsense_Criteria'] = 'Criteria';
$language['MenuLeftAdsense_Manage_criteria'] = 'Manage criteria';
$language['MenuLeftAdsense_Adsense'] = 'Adsense';
$language['MenuLeftAdsense_Adsense_in_index'] = 'Adsense in index';
$language['MenuLeftAdsense_Adsense_in_news'] = 'Adsense in news';
$language['MenuLeftAdsense_Adsense_in_top_hits'] = 'Adsense in top hits';
$language['MenuLeftAdsense_Adsense_in_top_notes'] = 'Adsense in top notes';
$language['MenuLeftAdsense_Adsense_in_top_rank'] = 'Adsense in top rank';

// MenuLeftIndex.tpl
$language['MenuLeftIndex_Questions'] = 'Questions';
$language['MenuLeftIndex_Pending_User_Questions'] = 'Pending user questions';
$language['MenuLeftIndex_Pending_orders'] = 'Pending orders';
$language['MenuLeftIndex_Add_voyant_question'] = 'Add voyant question';

// MenuLeftUsers.tpl
$language['MenuLeftUsers_Users'] = 'Utilisateurs';
$language['MenuLeftUsers_Security'] = 'Security';
$language['MenuLeftUsers_Ban_IPs'] = 'Ban IPs';
$language['MenuLeftUsers_Ban_Emails'] = 'Ban Emails';
$language['MenuLeftUsers_Newsletter_mass_mailer'] = 'Newsletter mass mailer';
$language['MenuLeftUsers_Send_Newsletter_mass_mailer'] = 'Send Newsletter mass mailer';
$language['MenuLeftUsers_Export_import_mails'] = 'Export/import emails';


//// --> /template/templateName/order/
// Pending.tpl
$language['Pending_Users'] = 'Users';
$language['Pending_Question_select_by_user'] = 'Question select by user';
$language['Pending_Payment_pending'] = 'Payment pending';
$language['Pending_Order_number'] = 'Order Number';
$language['Pending_Check_ok'] = 'Check OK';
$language['Pending_Check_all'] = 'Check all';
$language['Pending_Check_status'] = 'Status';


//// --> /template/templateName/voyant/
// Edit.tpl
$language['Edit_Yes'] = 'Yes';
$language['Edit_No'] = 'No';
$language['Edit_Save'] = 'Save';
$language['Edit_Delete'] = 'Delete';
$language['Edit_Ban_IP'] = 'Ban IP';
$language['Edit_Edit_voyant'] = 'Edit voyant';

// Index.tpl
$language['Index_Voyant_Name'] = 'Voyant name';
$language['Index_Number'] = 'Number of question answer';

// Summary.tpl
$language['Summary_Pseudo_name'] = 'Pseudo - Last name, first name';
$language['Summary_Question_title'] = 'Question title';
$language['Summary_Title'] = 'Title';


//// --> /template/templateName/userQuestion/
// Pending.tpl
$language['Pending_Create'] = 'Create new question';
$language['Pending_Pending_Questions'] = 'Pending questions';

// Summary.tpl
$language['Summary_Question_summary'] = 'User question summary';
$language['Summary_Pseudo_name'] = 'Pseudo - Last name, first name';
$language['Summary_Question_title'] = 'Question title';


//// --> /template/templateName/voyantQuestion/
// Create.tpl
$language['Create_Create'] = 'Create new question';





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
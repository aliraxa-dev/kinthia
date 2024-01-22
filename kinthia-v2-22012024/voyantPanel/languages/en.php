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
// ChangePassword.tpl
$language['ChangePassword_New_password'] = 'New password';
$language['ChangePassword_Repeat_new_password'] = 'Repeat new password';
$language['ChangePassword_Moderator_change_password'] = 'Moderator - Change password';

// Index.tpl
$language['Index_Statistic'] = 'Statistic';
$language['Index_Value'] = 'Value';
$language['Index_Questions_ok'] = 'Questions ok';
$language['Index_Pending_Questions'] = 'Pending questions';
$language['Index_Users'] = 'Users';
$language['Index_Pending_check'] = 'Pending check';
$language['Index_Availability'] = 'Availability';

// LostPassword.tpl
$language['LostPassword_Lost_password'] = 'Lost password';


//// --> /template/templateName/menuheader
// MenuHeader.tpl
$language['MenuHeader_Directory'] = 'Directory';
$language['MenuHeader_Users'] = 'Users';


//// --> /template/templateName/menuleft
// Login.tpl
$language['Login_Logout'] = 'Logout';

// MenuleftUsers.tpl
$language['MenuleftUsers_Logout'] = 'Logout';
$language['MenuleftUsers_Users'] = 'Users';
$language['MenuleftUsers_Logged_in_as'] = 'You are logged in as';

// MenuleftIndex.tpl
$language['MenuleftIndex_User_Questions'] = 'User questions';
$language['MenuleftIndex_Pending_user_questions'] = 'Pending user questions';
$language['MenuleftIndex_Pending_check'] = 'Pending check';
$language['MenuleftIndex_Voyant_questions'] = 'Voyant questions';
$language['MenuleftIndex_Voyant_questions_list'] = 'Voyant questions list';
$language['MenuleftIndex_Add_voyant_questions'] = 'Add voyant question';


//// --> /template/templateName/order
// Pending.tpl
$language['Pending_Pending_user_questions'] = 'Pending user questions';
$language['Pending_Pending_check_orders'] = 'Pending check orders';


//// --> /template/templateName/user
// Show.tpl
$language['Show_user_details'] = 'User details';
$language['Show_First_name'] = 'First name';
$language['Show_Last_name'] = 'Last name';
$language['Show_Birthday'] = 'Birthday';
$language['Show_Question_title'] = 'Question title';
$language['Show_Status'] = 'Status';
$language['Show_Summary'] = 'Summary';
$language['Show_Paypal_id'] = 'Paypal ID';
$language['Show_In_voice'] = 'In voice';
$language['Show_Comments'] = 'Comments';
$language['Show_Rating'] = 'Rating';
$language['Show_Valitated'] = 'Valitated';
$language['Show_Management'] = 'Management';
$language['Show_Reply'] = 'Reply';
$language['Show_Yes'] = 'Yes';
$language['Show_No'] = 'No';
$language['Show_Save'] = 'Save';
$language['Show_Delete'] = 'Delete';


//// --> /template/templateName/userQuestion
// Pending.tpl
$language['Pending_Pending_user_question'] = 'Pending user questions';
$language['Pending_Pending_question'] = 'Pending questions';
$language['Pending_Question_finished'] = 'Question finished successfully';

// Summary.tpl
$language['Summary_User_question_summary'] = 'User question summary';
$language['Summary_pseudo_name'] = 'Pseudo - Last name, first name:';
$language['Summary_question_title'] = 'Question title';


//// --> /template/templateName/voyantQuestion
// Create.tpl
$language['Create_create'] = 'Create new question';


// CrudForm.tpl
$language['CrudForm_Title'] = 'Title';
$language['CrudForm_Short_description'] = 'Short description';
$language['CrudForm_Long_description'] = 'Long description';
$language['CrudForm_Price'] = 'Price';
$language['CrudForm_Additional_price'] = 'Additional price';

// Edit.tpl
$language['Edit_Edit_question'] = 'Edit question';

// Index.tpl
$language['Index_Voyant_questions'] = 'Voyant questions';
$language['Index_Question_title'] = 'Questions title';
$language['Index_Management'] = 'Management';




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
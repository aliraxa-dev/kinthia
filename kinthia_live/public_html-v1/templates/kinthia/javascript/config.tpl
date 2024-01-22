var setting = new Array();
setting.siteRootUrl = "{$setting.siteRootUrl|rtrim:'/'}";
setting.urlRewriting = "{$setting.urlRewriting}";

setting.lang = new Object();
setting.lang["Changes were saved"] = "{'javascriptConfig_changes_were_saved'|lang}";
setting.lang["Loading"] = "{'javascriptConfig_loading_title'|lang}";
setting.lang["Loading..."] = "{'javascriptConfig_loading_content'|lang}";
setting.lang["Please enter your pseudo"] = "{'javascriptConfig_please_enter_your_pseudo'|lang}";
setting.lang["Please enter your email"] = "{'javascriptConfig_please_enter_your_email'|lang}";
setting.lang["Please confirm your email"] = "{'javascriptConfig_please_confirm_your_email'|lang}";
setting.lang["Please enter password"] = "{'javascriptConfig_please_enter_password'|lang}";
setting.lang["Please confirm your password"] = "{'javascriptConfig_please_confirm_your_password'|lang}";
setting.lang["Please enter captcha code"] = "{'javascriptConfig_please_enter_captcha_code'|lang}";
setting.lang["Your email must be in format - name@domain.com"] = "{'javascriptConfig_your_email_format'|lang}";
setting.lang["Your changes were saved"] = "{'javascriptConfig_your_changes_were_saved'|lang}";
setting.lang["You just add to cart the next product"] = "{'javascriptConfig_you_just_add_to_cart_the_next_product'|lang}";
setting.lang["Your message was sent"] = "{'javascriptConfig_your_message_was_sent'|lang}";
setting.lang["Your comment was saved"] = "{'javascriptConfig_your_comment_was_saved'|lang}";
setting.lang["New password was sent to your email"] = "{'javascriptConfig_new_password_was_sent_to_your_email'|lang}";
setting.lang["Wrong password"] = "{'javascriptConfig_wrong_password'|lang}";
setting.lang["Change email"] = "{'javascriptConfig_change_email'|lang}";
setting.lang["Change password"] = "{'javascriptConfig_change_password'|lang}";
setting.lang["This field is required"] = "{'javascriptConfig_this_field_is_required'|lang}";
setting.lang["New password changed"] = "{'javascriptConfig_new_password_changed'|lang}";
setting.lang["Thank you, we are processing your payment"] = "{'javascriptConfig_thank_you_payment_processing'|lang}";
setting.lang["Please enter a correct date, needed format is dd/mm/YYYY"] = "{'javascriptConfig_Please_enter_a_correct_date,_needed_format_is_dd/mm/YYYY'|lang}";
setting.lang["Please enter a subject"] = "{'javascriptConfig_Please_enter_a_subject'|lang}";
setting.lang["Please enter a description"] = "{'javascriptConfig_Please_enter_a_description'|lang}";
setting.lang["Refund request sended"] = "{'javascriptConfig_Refund_request_sended'|lang}";
setting.lang["Your password changed"] = "{'javascriptConfig_Your_password_changed'|lang}";

setting.lang["File"] = "{'javascript_config_file'|lang}";
setting.lang["was uploaded sucessfully"] = "{'javascript_config_was_uploaded_sucessfully'|lang}";
setting.lang["of"] = "{'javascript_config_of'|lang}";
setting.lang["available photos uploaded"] = "{'javascript_config_available_photos_uploaded'|lang}";
setting.lang["Passwords aren't equal"] = "{'javascript_config_passwords_are_not_equal'|lang}";
setting.lang["Emails aren't equal"] = "{'javascript_config_emails_are_not_equal'|lang}";
setting.lang["Email was used earlier"] = "{'javascript_config_emails_was_used_earlier'|lang}";

{literal}
function _t($phrase)
{
   console.warn("Phrase >>>>", $phrase);
   //return setting.lang[$phrase] || $phrase;
   return $phrase;
}

var AppRouter =
{
    rewrites: new Array(),
    addRewriteRule: function(pattern, replacement)
    {
        AppRouter.rewrites.push({"pattern": new RegExp(pattern), replacement: replacement});
    },
    
    getRewrittedUrl: function(url)
    {
    	// Removing http from star prevent ajax access policy problems with OPTIONS requests
        var rewrittedUrl = setting.siteRootUrl.replace(/http:\/\/[^\/]+/gi, '');
        if(!setting.urlRewriting)rewrittedUrl += "/index.php";
         
        for(var i = 0; i < AppRouter.rewrites.length; i++)
        {
            var rewrite = AppRouter.rewrites[i];
            url = url.replace(rewrite.pattern, rewrite.replacement); 
        }
        
        rewrittedUrl += url;
        return rewrittedUrl;
    }
}
    
{/literal}

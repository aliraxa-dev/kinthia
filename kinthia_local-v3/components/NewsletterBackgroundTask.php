<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class NewsletterBackgroundTask extends BackgroundTask
{
    protected $taskId = "newsletter";
    private $mailer;
    private $timeDelay;

    protected function beforeInit()
    {
        $this->data = $this->request->getArray(array("subject", "text", "mailsPerMinute", "newsletterType"));
        $message = $this->customMessage->findByPk("newsletterFooter");
        $this->data['newsletterFooterDescription'] = $message->description; 
    }

    protected function loadItems()
    {
        $emails = array();
        
        if($this->data['newsletterType'] == "admin")
        {
            $emails[] = Mailer::getInstance()->getAdminEmail();
        }
        else
        {
            $c = new Criteria();
            $c->add("role", "user");
            if ($this->data['newsletterType'] != "all") {
                $c->add("newsletterEnabled", 1);
            }
            $emails = array_values($this->user->getArray($c, "email", false));
            
            $c = new Criteria();
            $c->add("active", 1);
            $emails = array_merge($emails, array_values($this->newsletterEmail->getArray($c, "email", false)));
            $emails = array_unique($emails);
        }
         
        $this->items = $emails;         
    }

    protected function beforeParsing()
    {
        $this->mailer = Mailer::getInstance(); 
        $mailsPerMinute = max(1, $this->data['mailsPerMinute']);
        $this->timeDelay = floor(60 / $mailsPerMinute);
    }
    
    protected function parseItem($email)
    {
        $text = $this->data['text'];
        $verification = $this->verification->addVerification(null, "newsletterEmailDel", $email);
        $unsubscribeLink = Config::get("siteRootUrl").AppRouter::getRewrittedUrl("/newsletter/confirmNewsletterEmailDel/".$verification->code, false);
        $text .= str_replace("[unsubscribe link]", $unsubscribeLink, $this->data['newsletterFooterDescription']);
        $this->mailer->sendEmail($email, $this->data['subject'], $text);
        if($this->parsedItems < $this->totalItems)sleep($this->timeDelay);
    }
    
    protected function afterParsing()
    {
        Mailer::getInstance()->sendNewsletterTaskFinished();
    }

}
        
?>
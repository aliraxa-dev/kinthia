<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

class Mailer extends Model
{
    private static $instance = null;
    private $adminEmail;
    private $inboxDebug = true; // true or false
    private $sendRealEmail = true;
    private $charset = "UTF-8";
	private $siteName = "Kinthia.com";
	private $phpMailer;
    
    /**
    * @return Mailer
    */
                                    
    public static function getInstance()
    {
        if(self::$instance === null)
        {
            self::$instance = new self();
        }

        return self::$instance;
    }
    
    function __construct()
    {
        parent::__construct();
        
        $c = new Criteria();
        $c->add("role", "administrator");
        $c->setLimit(1);
        $admin = $this->user->find($c, "email"); 
        $this->adminEmail = $admin->email;
        require realpath(dirname(__FILE__)) . '/PHPMailer/PHPMailerAutoload.php';
        $this->phpMailer = new PHPMailer;
    }
    
    function getAdminEmail()
    {
        return $this->adminEmail;
    }
     
    function sendAdminNotification($item)
    {                 
        $message = $this->customMessage->findByPk("submitItem");
        $this->sendEmailToAdmin($message->title, $this->replaceTags($message->description, $item));
    }
    
    function sendEmailToAdmin($subject, $message, $fromEmail = "")
    {
        return $this->sendEmail($this->adminEmail,
                                $subject,
                                $message,
                                $fromEmail);
    }
    
    function sendEmailConfirmation($messageId, $email, $confirmLink)
    {   
        $message = $this->customMessage->findByPk($messageId);
        $message->description = str_replace("[confirm link]", $confirmLink, $message->description);
        $this->sendEmail($email, $message->title, $message->description);
    }

    function sendEmailReport($email,$sub,$message)
    {   
        
        $this->sendEmail($email,$sub,$message);
    }
    

       function sendEmailSlotBook($email,$sub,$message)
    {   
        
        $this->sendEmail($email,$sub,$message);
    }
    function sendEmailVoyantOnline($email,$sub,$message)
    {   
        
        $this->sendEmail($email,$sub,$message);
    }
    


    
    function sendLostPassword($userEmail, $newPassword)
    {
        $message = $this->customMessage->findByPk("lostPassword");
        $message->description = str_replace("[new password]", $newPassword, $message->description);        
        $this->sendEmail($userEmail, $message->title, $message->description);  
    }

    
    function sendEmailToUserAfterUserBoughtQuestion($orderId)
    {
        $order = $this->getOrderWithDetails($orderId);
        
        switch ($order->paymentMethod) {
            case 'check':
                $messageId = 'payConfirmationCheck';
                break;
            
            default:
                $messageId = 'paymentConfirmation';  
        }
        
        $message = $this->customMessage->findByPk($messageId);
        
        $this->sendEmail($order['user']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            $messageId,
                                            array('order' => $order)));     
    }

    // Email Received By User/Admin When User Bought Timepackss     
    function sendEmailToUserAfterUserBoughtPackage($orderId,$val)   
    {   
        if ($val==0) {  
            $order = $this->getPackageOrderWithDetails($orderId);   
        }   
        // Send Email To User When User Bought Timepack 
        $message = $this->customMessage->findByPk("userbuyTimepack");   
                
        $this->sendEmail($order['user']['email'],   
                         $message->title,   
                         $this->replaceTags($message->description,  
                                            'userbuyTimepack',  
                                            array('order' => $order))); 
        // Send Email To Admin When User Bought Timepack    
        $message = $this->customMessage->findByPk("buypackage");    
                
        $this->sendEmail($this->adminEmail, 
                         $message->title,   
                         $this->replaceTags($message->description,  
                                            'buypackage',   
                                            array('order' => $order))); 
    }
    
    function sendEmailToVoyantAfterUserBoughtQuestion($orderId)
    {
        $message = $this->customMessage->findByPk("newUserQuestion");
        $order = $this->getOrderWithDetails($orderId);
        $this->sendEmail($order['voyant']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            'newUserQuestion',
                                            array('order' => $order)));    
    }
    
    function sendEmailToUserAfterUserChooseCheck($orderId)
    {
        $messageId = 'payByCheckToUser';
        $order = $this->getOrderWithDetails($orderId);
        $message = $this->customMessage->findByPk($messageId);
        
        $this->sendEmail($order['user']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            $messageId,
                                            array('order' => $order)));         
    }
    
    function sendEmailToVoyantAfterUserChooseCheck($orderId)
    {
        $messageId = 'payByCheckToVoyant';
        $message = $this->customMessage->findByPk($messageId);
        $order = $this->getOrderWithDetails($orderId);
        $this->sendEmail($order['voyant']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            $messageId,
                                            array('order' => $order)));        
    }
    
    function sendContactEmailToUser($toUser, $title, $description, $fromUser)
    {
        $values = array('text' => $description);
        
        if ($fromUser->role == 'voyant') {
            $messageId = 'voyantContactUser';
            $values['voyant'] = $fromUser;
        } else {
            $messageId = 'userContactVoyant';
            $values['user'] = $fromUser;
        }
        
        $message = $this->customMessage->findByPk($messageId);
        $this->sendEmail($toUser->email,
                         $title,
                         $this->replaceTags($message->description,
                                            $messageId,
                                            $values),
                         $fromUser->email);
    }
    
    private function getOrderWithDetails($orderId)
    {
        $c = new Criteria();
        $c->add('orderId', $orderId);
        $c->addWithRelation('voyant', array('fields' => 'email, name, firstName, lastName'
                                                        . ', address, zipCode, city'));
        $c->addWithRelation('user', array('fields' => 'email, name, firstName, lastName'));
        $c->addWithRelation('orderItems', array('fields' => 'orderId, itemId, quantity, totalPrice',
                                                'relations' => array(
                                                    'voyantQuestion' => array(
                                                        'fields' => 'questionId, title')
                                                )));
        return $this->order->find($c);
    }
     // Get Timepack Order  
    private function getPackageOrderWithDetails($orderId)   
    {   
        $c = new Criteria();    
        $c->add('orderId', $orderId);   
       $c->addWithRelation('user', array('fields' => 'email, name, firstName, lastName'));  
        // print_r($this->order->find($c));die();   
        return $this->order->find($c);  
    }
    
    function sendRefundEmails($orderId, $text)
    {
        $order = $this->getOrderWithDetails($orderId);
        $message = $this->customMessage->findByPk("refundVoyantEmail");
        $this->sendEmail($order['voyant']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            'refundVoyantEmail',
                                            array('order' => $order,
                                                  'text' => $text)));
        
        $message = $this->customMessage->findByPk("refundUserEmail");
        $this->sendEmail($order['user']['email'],
                         $message->title,
                         $this->replaceTags($message->description,
                                            'refundUserEmail',
                                            array('order' => $order,
                                                  'text' => $text)));  
    }
    
    function replaceQuestionsCallback($match)
    {
        $text = "";
        $template = $match[1];
       if(isset($this->orderItems) && !empty($this->orderItems)){
        foreach ($this->orderItems as $orderItem) {    
            $replacements = array(
                "[question number]" => $orderItem['quantity'],
                "[question title]"  => $orderItem['voyantQuestion']['title']);
                
            $text .= strtr($template, $replacements);
        }
        
        return $text;
       }
        
    }
    
    function replaceTags($text, $emailId, $values)
    {
        $replacements = array();
        
        if (in_array($emailId, array(
                'refundUserEmail', 'refundVoyantEmail', 'paymentConfirmation',
                'newUserQuestion', 'payConfirmationCheck', 'payByCheckToVoyant',
                'payByCheckToUser'))) {
            
            $order = $values['order'];
            $user = $order['user'];
            $voyant = $order['voyant'];
            
            $replacements += array(
                '[voyant pseudo]'      => $voyant['name'],
                '[voyant firstName]'   => $voyant['firstName'],
                '[voyant lastName]'    => $voyant['lastName'],
                '[voyant address]'     => $voyant['address'],
                '[voyant postal code]' => $voyant['zipCode'],
                '[voyant city]'        => $voyant['city'],
                '[voyant email]'       => $voyant['email'],
                '[user pseudo]'        => $user['name'],  
                '[order orderId]'      => $order['orderId'],
                '[order invoiceId]'    => $order['invoiceId'],
                '[user email]'         => $user['email'],
                '[user message]'       => isset($values['text']) ? $values['text'] : '');
                
            $this->orderItems = $order['orderItems'];
            
            $pattern = '#' . preg_quote('{foreach [order questions]}')
                       . '(.*?)'
                       . preg_quote('{/foreach}') . '#si';
                                          
            $text = preg_replace_callback($pattern, array($this, 'replaceQuestionsCallback'), $text); 
        }
        
        if (in_array($emailId, array('userContactVoyant'))) {
            
            $user = $values['user'];        
            $replacements += array(
                '[user email]'       => $user['email'],
                '[user pseudo]'      => $user['name'],
                '[user firstName]'   => $user['firstName'],
                '[user lastName]'    => $user['lastName'],
                '[user message]'     => $values['text']);
                    
        }
        
        if (in_array($emailId, array('voyantContactUser'))) {
            
            $voyant = $values['voyant'];        
            $replacements += array(
                '[voyant email]'       => $voyant['email'],
                '[voyant pseudo]'      => $voyant['name'],
                '[voyant firstName]'   => $voyant['firstName'],
                '[voyant lastName]'    => $voyant['lastName'],
                '[voyant message]'     => $values['text']);
                    
        }
                                  
        $text = strtr($text, $replacements);
        return $text;   
    }

    /**
     * @param $email
     * @param $subject
     * @param $text
     * @param string $fromEmail
     * @return bool
     * @throws phpmailerException
     */
    function sendEmail($email, $subject, $text, $fromEmail = "")
    {
            
          
        if($fromEmail == "")$fromEmail = $this->adminEmail;
        $this->phpMailer->setFrom($fromEmail);
        if (Config::get('SMTP_ENABLE')) {
               
            $this->phpMailer->isSMTP();
            $this->phpMailer->Host = Config::get('SMTP_HOST');
            
            $this->phpMailer->SMTPAuth = true;
           // $this->phpMailer->SMTPDebug = 2;
            $this->phpMailer->Username = Config::get('SMTP_USERNAME');
           
            $this->phpMailer->Password = Config::get('SMTP_PASSWORD');
           
            $this->phpMailer->SMTPSecure = Config::get('SMTP_SECURE');
            $this->phpMailer->Port = Config::get('SMTP_PORT');
            $this->phpMailer->setFrom(Config::get('SMTP_USERNAME'));
        }

        $this->phpMailer->clearAddresses();
        $this->phpMailer->addAddress($email);
        $this->phpMailer->isHTML(true);
        $this->phpMailer->CharSet = "UTF-8";

        $specialChars = array('Ŕ','Á','Â','Ă','Ä','Ĺ','Ć','ŕ','à','á','â','ă','ä','ĺ','ć','Č','É','Ę','Ë','č','è','é','ę','ë','ê','Ě','Í','Î','Ď','ě','í','î','ď','Ň','Ó','Ô','Ő','Ö','Ř','ň','ó','ô','ő','ö','ř','Ů','Ú','Ű','Ü','ů','ú','ű','ü','ß','Ç','ç','Đ','đ','Ń','ń','Ţ','ţ','Ý' );
        $normalChars  = array('A','A','A','A','A','A','A','a','a','a','a','a','a','a','a','E','E','E','E','e','e','e','e','e','e','I','I','I','I','i','i','i','i','O','O','O','O','O','O','o','o','o','o','o','o','U','U','U','U','u','u','u','u','B','C','c','D','d','N','n','P','p','Y' );
            
        $subject = str_replace($specialChars, $normalChars, $subject);
        
        if($this->inboxDebug)
        {
            $customHeaders = json_encode($this->phpMailer->getCustomHeaders());
            $str = "<hr>";
            $str .= "<b>Time</b> ".date("Y-m-d G.i:s")."<br>";  
            $str .= "<b>Email:</b> $email<br>";
            $str .= "<b>Topic:</b> $subject<br>";
            $str .= "<b>Text:</b> " . nl2br($text) . "<br>";
            $str .= "<b>Headers:</b> {$customHeaders}<br>";
            
            $fp = fopen(CODE_ROOT_DIR."inbox.html", "a");
            fwrite($fp, $str);
            fclose($fp);
        }

        $this->phpMailer->Subject = $subject;
        $this->phpMailer->Body = $text;
        $this->phpMailer->AltBody = $text;

        if($this->sendRealEmail)
        {
            if ($this->phpMailer->send()) {
                return true;
            } else {
                $phpMailerError = fopen(CODE_ROOT_DIR."mail_error.html", "a");
                fwrite($phpMailerError, $this->phpMailer->ErrorInfo);
                fclose($phpMailerError);
            }
        }


        return false;
    }
}

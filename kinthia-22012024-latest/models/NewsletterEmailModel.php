<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class NewsletterEmailModel extends Model
{
    protected $primaryKey = "emailId";

    function validate($request)
    {
        if (!preg_match("#^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$#", $request->email)) {
            return "Email must have format login@domain.com";
        }

        $c = new Criteria();
        $c->add("email", $request->email);

        $emailExists = ($this->getCount($c));

        if (!empty($request->addEmail) && $emailExists) {
            return "This email was added earlier";
        }

        if (!empty($request->deleteEmail) && !$emailExists) {
            return "This email do not exists in our db";
        }

        return '';
    }

    function addEmail($email)
    {
        $newsletterEmail = new NewsletterEmailRecord();
        $newsletterEmail->email = $email;
        $newsletterEmail->active = 0;
        $newsletterEmail->save();

        return $newsletterEmail;
    }
}

class NewsletterEmailRecord extends ModelRecord
{

}

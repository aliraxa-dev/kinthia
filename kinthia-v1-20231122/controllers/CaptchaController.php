<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class CaptchaController extends AppController
{
    /**
     * Display captcha html with new captcha image
     */
    public function showAction($newCaptchaLinkClass = null)
    {
        $captcha = new CaptchaCodeRecord();
        $this->set('generatedPublicCode', $captcha->generateCaptchaCodesAndGetPublicOne());
        $this->set('newCaptchaLinkClass', $newCaptchaLinkClass);
    }

    /**
     * Change captcha image to new
     */
    public function changeAction($publicCode)
    {
        $c = new Criteria();
        $c->add('publicCode', $publicCode);

        //remove old captcha
        $this->captchaCode->del($c);

        //create new CaptchaCodeRecord
        $captcha = new CaptchaCodeRecord();
        $this->set('newPublicCode', $captcha->generateCaptchaCodesAndGetPublicOne());
        $this->viewClass = 'JsonView';
    }

    /**
     * Display captcha PNG image
     */
    public function pngAction($publicCode)
    {
        //find captchaCode by public code
        $c = new Criteria();
        $c->add('publicCode', $publicCode);
        $captcha = $this->captchaCode->find($c);

        //display private code as image
        $this->set('code', $captcha->privateCode);
        $this->viewClass = 'CaptchaView';
    }
}

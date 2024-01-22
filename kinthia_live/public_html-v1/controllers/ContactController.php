<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/**
 * Class ContactController
 */
class ContactController extends AppController
{
    /**
     * @param $userId
     */
    public function contactPopupAction($userId)
    {
        $user = $this->user->findByPk($userId);

        if (empty($user)) {
            $this->return404();
        }

        $this->set('user', $user);
    }

    /**
     * sendMessageToUserAction
     */
    public function sendMessageToUserAction()
    {
        $this->viewClass = 'JsonView';
        $toUser = Model::factoryInstance('user')->findByPk($this->request->userId);

        if (!$toUser->userId || !$this->userId) {
            $this->return404();
        }

        $voyantId = 0;
        $userId = 0;
        $fromUser = $this->user->findByPk($this->userId);

        if ($toUser->role == 'voyant') {
            $voyantId = $toUser->userId;
            $userId = $fromUser->userId;
            $toUser = $this->voyant->findByPk($toUser->userId);
            $toUser->role = 'voyant';
        }

        if ($fromUser->role == 'voyant') {
            $voyantId = $fromUser->userId;
            $userId = $toUser->userId;
            $fromUser = $this->voyant->findByPk($fromUser->userId);
            $fromUser->role = 'voyant';
        }

        $c = new Criteria();
        $c->add('userId', $userId);
        $c->add('voyantId', $voyantId);


        if (0 === $this->order->getCount($c)) {
            $this->return404();
        }

        Mailer::getInstance()->sendContactEmailToUser($toUser,
            $this->request->title,
            $this->request->description,
            $fromUser);
        $this->set('status', 'ok');
    }
}

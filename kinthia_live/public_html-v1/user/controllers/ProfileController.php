<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////

/**
 * Class User_ProfileController
 */
class User_ProfileController extends AppController
{
    private $editMode = false;

    private $fields = [
        'firstName',
        'lastName',
        'namePrefix',
        'phone',
        'mobilePhone',
        'birthdayDate',
    ];

    /**
     * Initailize controller set access privileges
     */
    public function init()
    {
        $this->acl->allow('user', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/user'));
        }

        $this->set("action",$this->action);
        //display promo time packs...
        $promoPacks = $this->statistic->promoPacks();
        $this->set('allPromoPackages', $promoPacks);

        $pendingVoyantEmailsIds = $this->statistic->getVoyantEmailIds($this->session->get('userId'));
        $this->set("pendingVoyantEmailsIds",$pendingVoyantEmailsIds);
    }

    public function changePasswordAction()
    {
        if (
            !empty($this->request->password)
            && $this->request->password == $this->request->passwordRepeat
        ) {
            $user = $this->user->findByPk($this->userId);
            $this->viewClass = 'JsonView';
            if (md5($this->request->currentPassword) === $user->password) {
                $this->user->updateByPk(
                    array('password' => md5($this->request->password)
                    ),
                    $this->userId
                );
                $this->set('status', 'ok');
            } else {
                $this->set('status', 'no');
            }
        }
    }

    public function changeEmailAction()
    {
        if (!empty($this->request->email)) {
            $user = $this->user->findByPk($this->userId);
            $this->viewClass = 'JsonView';
            if (md5($this->request->currentPassword) === $user->password) {
                $user->email = $this->request->email;
                $user->save();
                $this->set('status', 'ok');
            } else {
                $this->set('status', 'no');
            }
        }
    }

    public function indexAction()
    {
        $classFields = $this->fields;
        $classFields[] = 'birthdayDate';
        $fields = implode(', ', $classFields) . ', newsletterEnabled';
        $userData = $this->user->findByPk($this->userId, $fields);
        if ($userData->birthdayDate == '0000-00-00') {
            $userData->birthdayDate = null;
        }
        if ($userData->birthdayDate) {
            $userData->birthdayDate = date('d/m/Y', strtotime($userData->birthdayDate));
        }
        $this->set('userJson', JsonView::php2js($userData));
        $this->set('user', $this->user->findByPk($this->userId));
    }

    public function saveAction()
    {
        $this->viewClass = 'JsonView';

        $user = $this->user->findByPk($this->userId);

        $user->fromArray($this->request->getArray($this->fields));

        $user->newsletterEnabled = !empty($this->request->newsletterEnabled) ? '1' : '0';

        if (!empty($this->request->password)) {
            $user->password = md5($this->request->password);
        }

        $user->save();

        $this->set('status', 'ok');
    }

    public function photoAction()
    {
        $c = new Criteria();
        $c->add('itemId', $this->userId);

        $user = $this->user->findByPk($this->userId, 'userId as itemId');
        $this->user->attachPhotos($user);

        $this->set('itemJson', JsonView::php2js($user));
        $this->set('user', $this->user->findByPk($this->userId));
    }
}

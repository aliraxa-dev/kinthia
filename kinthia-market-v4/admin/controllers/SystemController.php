<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


class Admin_SystemController extends AppController
{
    public function init()
    {
        $this->acl->allow('administrator', $this->name, '*');

        if (!$this->acl->isAllowed($this->session->get('role'), $this->name, $this->action)) {
            $this->redirect(AppRouter::getRewrittedUrl('/admin/main/logIn'));
        }
    }

    public function indexAction()
    {
        $this->checkScriptVersion();
    }

    private function checkScriptVersion()
    {
        require (CODE_ROOT_DIR . 'config/version.php');

        $lastVersion = '1.0.0';
        
        $newVersionAvailable = version_compare($lastVersion, $currentVersion, '>');

        $this->set('currentVersion', $currentVersion);
        $this->set('lastVersion', $lastVersion);
        $this->set('newVersionAvailable', $newVersionAvailable);
    }

    public function checkSecurityAction()
    {
        $this->checkScriptVersion();
        $this->set('installDirExists', is_dir(CODE_ROOT_DIR . 'install'));
    }

    public function optimizeAction()
    {
        if (isset($this->request->start)) {
            $this->database->optimize();
        }
    }

    public function saveAction()
    {
        if (empty($this->request->saveMethod)) {
            return;
        }

        $this->database->createBackup($this->request->fileType, $this->request->saveMethod);

        if (strpos($this->request->saveMethod, 'download') !== false) {
            $this->autoRender = false;
        }
    }

    public function restoreAction()
    {
        $backupFile = new UploadedFile('backupFile');
        if (!$backupFile->wasUploaded()) {
            return;
        }

        $gzipMode = ($this->request->fileType == 'gzip');
        $fileName = $backupFile->getTempName();
        $fp = $gzipMode ? gzopen($fileName, 'r') : fopen($fileName, 'r');
        $inString = false;
        $query = '';

        while (!feof($fp)) {
            $line = $gzipMode ? gzgets($fp) : fgets($fp);

            if (!$inString) {
                $isCommentLine = false;

                foreach (array('#', '--') as $commentTag) {
                    if (strpos($line, $commentTag) === 0) {
                        $isCommentLine = true;
                    }
                }

                if ($isCommentLine || trim($line) == '') {
                    continue;
                }
            }

            $deslashedLine = str_replace('\\', '', $line);

            if ((substr_count($deslashedLine, "'") - substr_count($deslashedLine, "\\'")) % 2) {
                $inString = !$inString;
            }

            $query .= $line;

            if (substr_compare(rtrim($line), ';', -1) == 0 && !$inString) {
                $this->database->sqlQuery($query);
                $query = '';
            }
        }
    }
        
    function informationAction()
    {
        $this->set('phpVersion', phpversion());
        $this->set('installDirExists', file_exists(CODE_ROOT_DIR . 'install'));
        $this->set('cacheDirWritable', is_writable(CODE_ROOT_DIR . 'cache'));
        $this->set('saveDirWritable', is_writable(CODE_ROOT_DIR . 'save'));
        $this->set('imagesThumbsDirWritable', is_writable(CODE_ROOT_DIR . 'uploads/images_thumbs'));
        $this->set('imagesCategoriesDirWritable', is_writable(CODE_ROOT_DIR . 'uploads/images_categories'));
    }
}

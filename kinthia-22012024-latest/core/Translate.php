<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class which make text translations
 */
class Translate extends CoreObject
{
    private $translation;

    /**
     * Singleton instances - one per language
     */
    private static $instances = array();

    /**
     * Returns an instance of Translate for specified language
     * @param string $lang Specify destination language of translation
     */
    public static function getInstance($lang)
    {
        if (!isset(self::$instances[$lang])) {
            self::$instances[$lang] = new self($lang);
        }

        return self::$instances[$lang];
    }

    /**
     * Generates the standard translation object
     *
     * @param string $lang Specify destination language of translation
     */
    public function __construct($lang)
    {
        $dictionaryPath = Config::get("LANGUAGES_PATH") . $lang . ".php";

        if (!file_exists($dictionaryPath)) {
            $dictionaryPath = Config::get("LANGUAGES_PATH") . Config::get("DEFAULT_LANGUAGE") . ".php";
        }

        if (file_exists($dictionaryPath)) {
            $this->addDictionary($dictionaryPath);
        }
    }

    /**
     * Add dictionary for translations
     *
     * @param string $path Path to translation file
     */
    public function addDictionary($path)
    {
        include ($path);
        $this->translation = $language;
    }

    /**
     * Translate the given string
     *
     * @param  string $phrase Phrase to translate
     * @return string
     */
    public function getPhrase($phrase)
    {
        if (!isset($this->translation[$phrase])) {
            $this->translation[$phrase] = $phrase;
            return $phrase;
        } else {
            return $this->translation[$phrase];
        }
    }
}

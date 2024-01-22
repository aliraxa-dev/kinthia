<?php
//////////////////////////////////////////////////////////////////////////////////
//    					 copyright (c) Arfooo Annuaire                          //
//   				 by Hocine Guillaume (c) 2007 - 2008                        //
//       					http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////


/**
 * Class which map db table to object
 */
abstract class Model extends CoreObject
{
    protected $dbTable;
    protected $primaryKey = "id";
    protected $name;
    protected $lastInsertId;
    protected $foundRows;
    protected $relations;
    /**
     * @var Database
     */
    protected $db;

    /**
     * Singleton instances - one per language
     */
    private static $instances = array();

    /**
     * Returns an instance of model passed in parameter
     * @param string $model_name Model to return
     * @return mixed
     */
    public static function factoryInstance($className)
    {
        $className = ucfirst($className . "Model");

        if (!isset(self::$instances[$className])) {
            self::$instances[$className] = new $className();
        }

        return self::$instances[$className];
    }

    

    /**
     * Generates the standard Model object
     */
    public function __construct()
    {
        $this->db = Database::getInstance();

        if (!$this->name) {
            $this->name = substr(get_class($this), 0, -5); // "Model" length
        }

        if (!$this->dbTable) {
            $this->dbTable = strtolower($this->name) . "s";
        }
    }

    public function __get($name)
    {
        $this->$name = Model::factoryInstance($name);
        return $this->$name;
    }
    
    public function __call($method, $arguments)
    {
        if(substr_compare("findBy", $method, 0, 6) == 0) {
            $c = new Criteria();
            $field = substr($method, 6);
            $field[0] = strtolower($field[0]);
            $c->add($field, $arguments[0]);
            return $this->find($c);
        } else {
            throw new Exception("Undeclared model method ". $method);
        }
    }

    /**
     * Get primary key for Model table
     * @return string
     */
    public function getPrimaryKey()
    {
        return $this->primaryKey;
    }

    /**
     * Find row in database and return it
     * @param Criteria $criteria Criteria object contain search filters
     * @param string $fields Row fields which will be returned
     * @return ModelRecord
     */
    public function find(Criteria $criteria, $fields = "*")
    {
       
        $fields = Criteria::addPrefixToValueName($fields);

        $sql = $this->prepareCriteriaQuery($criteria, $fields);
        $itemData = $this->db->sqlGetRow($sql);
     
        if (!empty($itemData)) {
            $this->createOneToOneRelations($itemData, $criteria);
            $results = array(&$itemData);
            $this->createOneToManyRelations($results, $criteria);
        }
        
        return $this->populateObject($itemData);
    }
    
    protected function createOneToOneRelations(&$itemData, Criteria $c)
    {
        if (empty($itemData)) {
            return;
        }
        
        $withRelations = $c->getWithRelations();
        $relationPrefix = "relation";
        
        foreach($withRelations as $relationName => $withRelation)
        {
            $relation = $this->relations[$relationName];
            
            switch ($relation['type'])
            {
                case "oneToOne":
            
                    $itemData[$relationName] = array();
                    foreach(preg_split("#\s*,\s*#", $withRelation['fields']) as $fieldName)
                    {
                        $relationFieldName = $relationPrefix . $relationName . $fieldName;
                        $itemData[$relationName][$fieldName] = $itemData[$relationFieldName];
                        unset($itemData[$relationFieldName]); 
                    }
                    
                    break;
            }
        }
    }

    /**
     * Convert association array to ModelRecord object
     * @param array $data array which will be converted
     * @return ModelRecord
     */
    protected function populateObject($data)
    {
        if (empty($data)) {
            return false;
        }
        $cls = $this->name . "record";
        $record = new $cls($data, false);
        return $record;
    }

    /**
     * Find row in database basing on primary key
     * @param int $key Primary Key value
     * @param string $fields Row fields which will be returned
     * @return ModelRecord
     */

 
    public function findByPk($key, $fields = "*")
    {
        $c = new Criteria();
        $c->add($this->primaryKey, $key);
        return $this->find($c, $fields);
    }

    /**
     * Find all rows row in database matching criteria and return it
     * @param Criteria $criteria Criteria object contain search filters
     * @param string $fields Row fields which will be returned
     * @return array
     */
    public function findAll(Criteria $criteria = null, $fields = "*", $returnModelRecords = false)
    {
        $fields = Criteria::addPrefixToValueName($fields);

        if (!$criteria) {
            $criteria = new Criteria();
        }
        $sql = $this->prepareCriteriaQuery($criteria, $fields);

        $results = $this->db->sqlGetAll($sql);


        if ($criteria->getCalcFoundRows()) {
            $this->saveFoundRowsCount();
        }

        if (empty($results)) {
            return array();
        }
      
        foreach ($results as &$data) {
            $this->createOneToOneRelations($data, $criteria);
        }
        
        $this->createOneToManyRelations($results, $criteria);
        
        if (!$returnModelRecords) {
            return $results;
        }

        $modelRecords = array();

        foreach ($results as $key => $record) {
            if ($criteria->keyArray) {
                $pk = $record[$this->getPrimaryKey()];
                $modelRecords[$pk] = $this->populateObject($record);
            } else {
                $modelRecords[] = $this->populateObject($record);
            }
        }
        return $modelRecords;
    }
    
    private function createOneToManyRelations(&$results, $criteria)
    {
        if (empty($results)) {
            return;
        }
        
        foreach ($criteria->getWithRelations() as $relationName => $withRelation) {
             
            $relation = $this->relations[$relationName];
            
            if ($relation['type'] != 'oneToMany') {
                continue;
            } 

            if (isset($relation['localKey'])) {
                $localKey = $relation['localKey'];
            } else {
                $localKey = $relation['foreignKey'];
            }
            
            $foreignKeyIds = array();
            
            foreach ($results as &$row) {
                $foreignKeyIds[] = $row[$localKey];
                $row[$relationName] = array();
            }
                            
            $modelName = trim($relationName, 's');
            $fields = $withRelation['fields'];
            
            if (!empty($withRelation['criteria'])) {
                $c = $withRelation['criteria'];
            } else {
                $c = new Criteria();
            }
            
            $c->add($modelName . 's.' . $relation['foreignKey'], $foreignKeyIds, "IN");
            
            if (!empty($withRelation['relations'])) {                
                foreach($withRelation['relations'] as $childRelationName => $childRelation) {
                    $c->addWithRelation($childRelationName, $childRelation);
                }
            }
             
            $relationRows = Model::factoryInstance($modelName)->findAll($c, $fields);
            $relationsData = array();

            foreach ($relationRows as &$relationRow) {
                $relationsData[$relationRow[$relation['foreignKey']]][] = $relationRow;
            }
            
            foreach ($results as &$row){
                if (!empty($relationsData[$row[$localKey]])) {
                    $row[$relationName] = $relationsData[$row[$localKey]];
                }
            }
        }
    }

    /**
     * Get count of rows which match critera
     * @param Criteria $criteria Filter criteria
     * @return mixed
     */
    public function getCount(Criteria $criteria = null)
    {
        if (!$criteria) {
            $criteria = new Criteria();
        }
        $sql = $this->prepareCriteriaQuery($criteria, "count(*) as cnt");
        return intval($this->db->sqlGet($sql));
    }

    /**
     * Delete row with primary key equal $key
     * @param int $key Primary key of record
     */
    public function delByPk($key)
    {
        $c = new Criteria();
        $c->add($this->primaryKey, $key);
        $this->del($c);
    }

    /**
     * Delete rows which match to criteria
     * @param Criteria $c Criteria filter
     */
    public function del(Criteria $c)
    {
        if (!$c) {
            $c = new Criteria();
        }
        $where = $c->prepareQuery();
         
        $prefix = Config::get("DB_PREFIX");
        $this->db->sqlDelete($prefix . $this->dbTable, $where);
    }

    /**
     * Insert new row to table
     * @param array $data Row data
     */
    public function insert($data)
    {
        $prefix = Config::get("DB_PREFIX");
        $this->db->sqlInsert($prefix . $this->dbTable, $data);
        $this->lastInsertId = $this->db->getLastInsertId();
    }

    /**
     * Updata table row matched Criteria
     * @param array $data Row data
     * @param Criteria $c
     */
    public function update($data, Criteria $c)
    {  

       
        if (empty($c)) {
            $c = new Criteria();
        }
        $where = $c->prepareQuery();
        
        $prefix = Config::get("DB_PREFIX");
           $this->db->sqlUpdate($prefix . $this->dbTable, $data, $where);
           //die(print_r($where));
    }

    /**
     * Update table row which have primary key equal to $key
     * @param array $data Row data
     * @param int|string $key
     */
    public function updateByPk($data, $key)
    {
        $c = new Criteria();
        $c->add($this->primaryKey, $key);
        $this->update($data, $c);
    }

    /**
     * Get field value from row which matched criteria
     * @param string $what Field Name
     * @param Criteria $c
     * @return mixed
     */
    public function get($what, Criteria $c = null)
    {
        if (!$c) {
            $c = new Criteria();
        }
        $where = $c->prepareQuery();
        $prefix = Config::get("DB_PREFIX");
        return $this->db->sqlGet($what, $prefix . $this->dbTable, $where);
    }

    /**
     * Generate association array where keys are primary keys asn values is $field Field
     * @param Criteria $c
     * @param string $field Field name
     */
    public function getArray(Criteria $c = null, $field, $key = null, $wholeRow = false)
    {
        if (!$c) {
            $c = new Criteria();
        }
        if ($key === null) {
            $key = $this->primaryKey;
        }

        $fields = $field;

        if ($fields != "*" && $key) {
            $fields .= ", " . $key;
        }

        $rows = $this->findAll($c, $fields);

        $results = array();

        $key = preg_replace("#.+\.#", "", trim($key, "`"));
        $field = preg_replace("#.+\.#", "", trim($field, "`"));

        foreach ($rows as $row) {
            $value = $wholeRow ? $row : $row[$field];

            if ($key) {
                $results[$row[$key]] = $value;
            } else {
                $results[] = $value;
            }
        }

        return $results;
    }

    /**
     * Convert criteria to SQL representation
     * @param  Criteria $criteria
     * @param  string fields
     * @return string SQL query
     */
    public function prepareCriteriaQuery(Criteria $criteria, $fields = "*")
    {
        $c = new Criteria();
        $c = clone $criteria;
        $c->addColumn($fields);
        $c->addTable($this->dbTable);
        $c->setRelationsConfig(array('dbTable'   => $this->dbTable,
                                     'relations' => $this->relations));

        $sql = $c->prepareQuery();
        return $sql;
    }

    public function getLastInsertId()
    {
        return $this->lastInsertId;
    }

    protected function saveFoundRowsCount()
    {
        $this->foundRows = $this->db->sqlGet("SELECT FOUND_ROWS()");
    }

    public function getFoundRowsCount()
    {
        return $this->foundRows;
    }

    public function truncate()
    {
        $this->db->sqlQuery("TRUNCATE " . Config::get("DB_PREFIX") . $this->dbTable);
    }

}

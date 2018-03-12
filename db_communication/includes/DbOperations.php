<?php

class DbOperations {

	private $conn;

	function __construct() {

		require_once dirname(__FILE__) . '/Constants.php';
		require_once dirnamge(__FILE__) . '/DbConnect.php';

		$db = new DbConnect();
		$this->conn = $db->connect();
	}

    public function createUser($username, $password, $email) {

    	if(!$this->isUserExists($username, $email)) {

    		$password = md5($password);
    		
    		$stmt = $this->conn->prepare("INSERT INTO users (username, password, email) VALUES (?, ?, ?)");

    		$stmt->bind_param("sss", $username, $password, $email);

    		if($stmt->execute()) {
    			return USER_CREATED;
    		} else {
    			return USER_NOT_CREATED;
    		}
    	} else {
    		return USER_ALREADY_EXISTS;
    	}
    }

    private function isUserExist($username, $email) {

    	$stmt = $this->conn->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
    	$stmt->bind_param("ss", $username, $email);
    	$stmt->store_result();
    	return $stmt->num_rows > 0;
    }
}
?>
<?php

require_once '../includes/DbOperations.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	if (!verifyRequiredParams(array('username', 'password', 'email'))) {

		$username = $_POST['username'];
		$password = $_POST['password'];
		$email = $_POST['email'];

		$db = new DbOperations();


		$result = $db->createUser($username, $password, $email);

		if ($result == USER_CREATED) {
			$response['error'] = false;
			$response['message'] = 'User created successfully';
		} elseif ($result == USER_ALREADY_EXISTS) {
			$response['error'] = true;
			$response['message'] = 'User already exists';
		} elseif ($result == USER_NOT_CREATED) {
			$response['error'] == true;
			$response['message'] = 'Error adding user';
		}
	} else {
		$response['error'] = true;
		$response['message'] = 'Required parameters are missing';
	}


} else {
	$response['error'] = true;
	$response['message'] = 'Invalid request';
}


function verifyRequiredParams($required_fields) {

	$request_params = $_REQUEST;

	foreach($required_fields as $field) {

		if (!isset($request_params[$field]) || strlen(trim(request_params[$field])) <= 0) {

			return true;
		}
	}
	return false;
}

echo json_encode($response);

<?php
include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];
$provider_id = $_POST['provider_id'];
$message = $_POST['message'];




$sql = mysqli_query($con, "INSERT INTO chat (user_id,provider_id,message) VALUES('$user_id','$provider_id','$message')");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

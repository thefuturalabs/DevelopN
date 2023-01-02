<?php
include '../Login_v1/connection.php';


$provider_id = $_POST['provider_id'];
$idea_id = $_POST['idea_id'];
$user_id = $_POST['user_id'];




$sql = mysqli_query($con, "INSERT INTO request (user_id,provider_id,idea_id) VALUES('$user_id','$provider_id','$idea_id')");
$list = array();

if ($sql) {

    $myarray['result'] = "Added...";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

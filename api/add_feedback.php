<?php
include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];
$feedback = $_POST['feedback'];




$sql = mysqli_query($con, "INSERT INTO feedback (user_id,feedback) VALUES('$user_id','$feedback')");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

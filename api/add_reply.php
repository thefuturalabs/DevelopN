<?php
include '../Login_v1/connection.php';

$chat_id = $_POST['chat_id'];
$reply = $_POST['reply'];




$sql = mysqli_query($con,"update chat set reply = '$reply' where chat_id='$chat_id'");
$list = array();

if ($sql) {

    $myarray['result'] = "updated";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

<?php
include '../Login_v1/connection.php';


$title = $_POST['title'];
$notification = $_POST['notification'];




$sql = mysqli_query($con, "INSERT INTO notification (title,notification) VALUES('$title','$notification')");
$list = array();

if ($sql) {

    $myarray['result'] = "Added...";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

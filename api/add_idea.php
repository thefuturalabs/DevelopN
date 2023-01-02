<?php
include '../Login_v1/connection.php';

$id = $_POST['provider_id'];
$title = $_POST['title'];
$idea = $_POST['idea'];
$price = $_POST['price'];



$sql = mysqli_query($con, "INSERT INTO idea (provider_id,title,idea,price) VALUES('$id','$title','$idea','$price')");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);

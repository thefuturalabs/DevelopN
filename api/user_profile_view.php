<?php
include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];
$data = mysqli_query($con,"select * from user where login_id = '$user_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['mobile'];
$myarray['qualification'] = $row['qualification'];

echo json_encode($myarray);
?>
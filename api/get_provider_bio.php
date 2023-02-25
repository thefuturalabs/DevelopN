<?php
include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];
$data = mysqli_query($con,"select * from providers where login_id = '$user_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['phn_no'];
$myarray['dp'] = $row['image'];

echo json_encode($myarray);
?>
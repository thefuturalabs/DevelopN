<?php
include '../Login_v1/connection.php';
$provider_id = $_POST['provider_id'];
$data = mysqli_query($con,"select * from providers where provider_id = '$provider_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['phn_no'] = $row['phn_no'];
$myarray['qualification'] = $row['qualification'];
$myarray['gender'] = $row['gender'];
$myarray['work_status'] = $row['work_status'];
$myarray['image'] = $row['image'];

echo json_encode($myarray);
?>
<?php
include '../Login_v1/connection.php';
$req_id = $_POST['req_id'];
mysqli_query($con,"update request set status = '1' where req_id = '$req_id'");

$myarray['message'] = 'updated';
echo json_encode($myarray);
?>
<?php
include '../Login_v1/connection.php';

$provider_id=$_POST['provider_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$qualification = $_POST['qualification'];

$work_status = $_POST['work_status'];

$query1=mysqli_query($con,"UPDATE `providers` SET `name`='$name',`email`='$email',`phn_no`='$phn_no',`qualification`='$qualification',`work_status`='$work_status' WHERE provider_id='$provider_id'");



if($query1)
{
	$myarray['message'] = 'updated';
}

else
{

	$myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>
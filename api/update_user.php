<?php
include '../Login_v1/connection.php';

$user_id=$_POST['user_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];
$qualification = $_POST['qualification'];



$query1=mysqli_query($con,"UPDATE `user` SET `name`='$name',`email`='$email',`mobile`='$mobile',`qualification`='$qualification' WHERE login_id='$user_id'");



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
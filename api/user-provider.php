<?php
include '../Login_v1/connection.php';

$provider_id=$_POST['provider_id'];
$user_id = $_POST['user_id'];
$message = $_POST['message'];


$query1=mysqli_query($con,"insert into chat(provider_id,user_id, message)VALUES('$provider_id','$user_id','$message')");



if($query1)
{
	echo "message send Successfully...";
}

else
{

	echo "Updation Failed!";
}

?>
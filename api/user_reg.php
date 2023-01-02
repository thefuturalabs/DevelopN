<?php

include '../Login_v1/connection.php';


$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$qualification = $_POST['qualification'];
$gender = $_POST['gender'];


$username = $_POST['username'];
$password = $_POST['password'];

  


$query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','user')");
$last_login_id = mysqli_insert_id($con);
// var_dump($last_login_id);exit();
$query1 = mysqli_query($con, "INSERT INTO `user`(`login_id`,`name`,`email`,`mobile`,`qualification`,`gender`) VALUES ('$last_login_id','$name','$email','$phn_no','$qualification','$gender')");
$sql = mysqli_query($con, "select * from user where login_id = '$last_login_id;' ");
if ($sql) {

	$row = mysqli_fetch_assoc($sql);

		$myarray['message'] = 'registration successfull';
		$myarray['user_id'] = $row['login_id'];
	}
 else {


	$myarray['message'] = 'Failed to View';
}
echo json_encode($myarray);

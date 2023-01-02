<?php

include '../Login_v1/connection.php';


$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$qualification = $_POST['qualification'];
$gender = $_POST['gender'];
$work_status = $_POST['work_status'];

$username = $_POST['username'];
$password = $_POST['password'];
$pic = $_FILES['image']['name'];

    if ($pic != "") {
        $filearray = pathinfo($_FILES['image']['name']);

        $file1 = rand();
        $file_ext = $filearray["extension"];




        $filenew = $file1 . "." . $file_ext;
        move_uploaded_file($_FILES['image']['tmp_name'], "../img/" . $filenew);
        // var_dump($filenew);exit();
    } 
    else {
        echo "<script>alert('Please try again...!')</script>";
    }


$query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','provider')");
$last_login_id = mysqli_insert_id($con);
// var_dump($last_login_id);exit();
$query1 = mysqli_query($con, "INSERT INTO `providers`(`login_id`,`name`,`email`,`phn_no`,`qualification`,`gender`,`work_status`,`image`) VALUES ('$last_login_id','$name','$email','$phn_no','$qualification','$gender','$work_status','$filenew')");
$sql = mysqli_query($con, "select * from providers where login_id = '$last_login_id;' ");
if ($sql) {

	$row = mysqli_fetch_assoc($sql);

		$myarray['message'] = 'registration successfull';
		$myarray['reg_id'] = $row['login_id'];
	}
 else {

	$myarray['value'] = 0;
	$myarray['message'] = 'Failed to View';
}
echo json_encode($myarray);

<?php

include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];

$sql = mysqli_query($con, "select * from request join user on user.login_id = request.user_id where provider_id = '$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

$myarray['name'] = $row['name'];
$a=$row['idea_id'];
$abc = mysqli_query($con,"select * from idea where idea_id = '$a'");
$aa = mysqli_fetch_assoc($abc);


// echo $a;
    $myarray['status'] = $row['status'];
    $myarray['req_id'] = $row['req_id'];
    $myarray['title'] = $aa['title'];
    $myarray['name'] = $row['name'];
   

    array_push($list, $myarray);
   
  }
} else {


  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

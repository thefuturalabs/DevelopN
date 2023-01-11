<?php

include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];

$sql = mysqli_query($con, "select * from request join idea on request.idea_id = idea.idea_id where user_id = '$user_id'");
$list = array();

if ($sql->num_rows > 0) {
$row=mysqli_fetch_assoc($sql);


// echo $a;
    $myarray['idea_id'] = $row['idea_id'];
    $myarray['req_id'] = $row['req_id'];
    $myarray['title'] = $row['title'];
   

    array_push($list, $myarray);
   
  
} else {


  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

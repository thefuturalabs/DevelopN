<?php

include '../Login_v1/connection.php';

$provider_id = $_POST['provider_id'];

$sql = mysqli_query($con, "SELECT * FROM chat join user on chat.user_id = user.login_id where provider_id='$provider_id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    
    $myarray['user_id'] = $row['user_id'];
    $myarray['user'] = $row['name'];


    array_push($list, $myarray);
   
  }
} else {

 
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

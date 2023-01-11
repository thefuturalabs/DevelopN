<?php

include '../Login_v1/connection.php';

$user_id = $_POST['user_id'];
$provider_id = $_POST['provider_id'];

$sql = mysqli_query($con, "SELECT * FROM chat WHERE user_id='$user_id' and provider_id='$provider_id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['message'] = $row['message'];
    $myarray['reply'] = $row['reply'];
    $myarray['user_id'] = $row['user_id'];
    $myarray['chat_id'] = $row['chat_id'];


    array_push($list, $myarray);
   
  }
} else {

 
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

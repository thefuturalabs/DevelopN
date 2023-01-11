<?php

include '../Login_v1/connection.php';

$sql = mysqli_query($con, "SELECT * FROM feedback join user on user.login_id =feedback.user_id");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['user'] = $row['name'];
    $myarray['feedback'] = $row['feedback'];
   


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

<?php

include '../Login_v1/connection.php';

$id = $_POST['user_id'];

$sql = mysqli_query($con, "SELECT * FROM request join idea on request.idea_id=idea.idea_id WHERE request.user_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['title'] = $row['title'];
    $myarray['idea_id'] = $row['idea_id'];
    $myarray['idea'] = $row['idea'];
    $myarray['price'] = $row['price'];
    $myarray['provider_id'] = $row['provider_id'];
    $myarray['category'] = $row['category'];
    $myarray['status'] = $row['status'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['value'] = 0;
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

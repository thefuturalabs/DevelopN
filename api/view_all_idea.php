<?php

include '../Login_v1/connection.php';


$sql = mysqli_query($con, "SELECT * FROM idea ");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['title'] = $row['title'];
    $myarray['provider_id'] = $row['provider_id'];
    $myarray['idea'] = $row['idea'];
    $myarray['idea_id'] = $row['idea_id'];
    $myarray['price'] = $row['price'];
    $myarray['category'] = $row['category'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);

<?php

include '../Login_v1/connection.php';


$sql = mysqli_query($con, "SELECT * FROM idea ");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['title'] = $row['title'];
    $myarray['idea'] = $row['idea'];
    $myarray['price'] = $row['price'];



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
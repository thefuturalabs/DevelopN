<?php
include 'Login_v1/connection.php';
$id=$_GET['id'];
mysqli_query($con,"update providers set status='1' where provider_id = '$id'");
header("location:approve.php");

?>
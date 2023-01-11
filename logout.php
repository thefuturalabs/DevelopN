<?php
include 'Login_v1/connection.php';
session_start();
session_destroy();
header("location:index.php");
?>
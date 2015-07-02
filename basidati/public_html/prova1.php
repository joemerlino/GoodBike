 
<?php
require("Library.php");

page_start("Home");
session_start();  
if(isset($_SESSION['user'])) {
  echo "user presente ".$_SESSION['user'];
}
else {
  $_SESSION['user'] = "miki";
  echo "ho aggiunto miki";
}
page_end();
?>
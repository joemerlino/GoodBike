 
<?php
require("Library.php");

page_start("Home");

session_start();

if(isset($_SESSION['user'])) {
  echo "rimosso ".$_SESSION['user'];
  unset($_SESSION['user']);
  //session_destroy();
}
else {
  $_SESSION['user'] = "miki";
  echo "ho aggiunto miki";
}
page_end();
?>
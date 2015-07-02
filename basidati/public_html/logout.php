<?php
require("library.php");

if(check_session())
  logout();
redirect("index.php",0);
?>
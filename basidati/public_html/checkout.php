<?php
require("library.php");
$tessera = check_session();
if(!$tessera){
	redirect("index.php",0);
	exit;
}
page_start("Checkout - BiciRent");
if($_POST){
	
}
else{
	redirect("utente.php",0);
	exit;
}
page_end();
?>
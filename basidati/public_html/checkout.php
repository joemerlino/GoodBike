<?php
require("library.php");
$tessera = check_session();
if(!$tessera){
	redirect("index.php",0);
	exit;
}
page_start("Checkout - BiciRent");
if($_POST){
	if(isset($_POST['noleggia'])){
		echo "NOLEGGIO ".$_POST['col'];
	}
	else if(isset($_POST['segnala'])){
		echo "SEGNALA ROTTURA ".$_POST['col'];
	}
	else if(isset($_POST['deposita'])){
		echo "DEPOSITA ".$_POST['col'];
	}
	else{
		echo "SEGNALA MANCANZA";
	}
}
else{
	redirect("utente.php",0);
	exit;
}
page_end();
?>
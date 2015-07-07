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
	  if($_SESSION["noleggioInCorso"]) echo "errore, noleggio già in corso";
	  else {
	    echo "NOLEGGIO ".$_POST['col'];
	    }
	}
	else if(isset($_POST['segnala'])){
		echo "SEGNALA ROTTURA ".$_POST['col'];
	}
	else if(isset($_POST['deposita'])){
	  if($_SESSION["noleggioInCorso"]){
		echo "DEPOSITA ".$_POST['col'];
		}
	  else echo "errore, noleggio già in corso";
	}
	else{
		echo "SEGNALA MANCANZA ".$_POST['stazione'];
	}
}
else{
	redirect("utente.php",0);
	exit;
}
page_end();
?>
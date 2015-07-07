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
	    addOperazione('Prelievo',$colonnina,'0',$tessera);
	    $_SESSION["noleggioInCorso"] = true;
	    echo "operazione di noleggio riuscita";
	    }
	}
	else if(isset($_POST['segnala'])){
		echo "SEGNALA ROTTURA ".$_POST['col'];
	}
	else if(isset($_POST['deposita'])){
	  if($_SESSION["noleggioInCorso"]){
	      addOperazione('Deposito',$colonnina,$_SESSION["Bicicletta"],$tessera);
	      $_SESSION["noleggioInCorso"] = false;
	      echo "operazione di deposito riuscita";
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
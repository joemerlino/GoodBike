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
	    addOperazione('Prelievo',$_POST['col'],'0',$tessera);
	    $_SESSION["noleggioInCorso"] = true;
	    $queryBic = "SELECT Operazione.Bicicletta FROM Operazione WHERE Operazione.IdTessera = '$tessera' ORDER BY Operazione.Orario DESC LIMIT 1";
	    $_SESSION["Bicicletta"] = mysql_query($queryBic,$conn);
	    echo "operazione di noleggio riuscita";
	    }
	}
	else if(isset($_POST['segnala'])){
	  addRottura($tessera,$_POST['col']);
	  echo "aggiunta segnalazione rottura";
	}
	else if(isset($_POST['deposita'])){
	  if($_SESSION["noleggioInCorso"]){
	      addOperazione('Deposito',$_POST['col'],$_SESSION["Bicicletta"],$tessera);
	      $_SESSION["noleggioInCorso"] = false;
	      echo "operazione di deposito riuscita";
		}
	  else echo "errore, noleggio già in corso";
	}
	else{
	  addMancanza($tessera,$_POST['staz']);
	  echo "aggiunta segnalazione mancanza";
	}
}
else{
	redirect("utente.php",0);
	exit;
}
page_end();
?>
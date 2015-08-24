<?php
require("library.php");
$tessera = check_session();
if(!$tessera){
	redirect("index.php",0);
	exit;
}
page_start("Checkout - BiciRent");
if($_POST){
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
	if(isset($_POST['noleggia'])){
	  if($_SESSION["noleggioInCorso"]) echo "errore, noleggio già in corso";
	  else {
	    if(add_operazione('Prelievo',$_POST['col'],'0',$tessera)) {
	      $_SESSION["noleggioInCorso"] = TRUE;
	      $queryBic = "SELECT Operazione.Bicicletta FROM Operazione WHERE Operazione.IdTessera = '$tessera' ORDER BY Operazione.Orario DESC LIMIT 1";
	      $_SESSION["Bicicletta"] = fetch_singolo(mysql_query($queryBic,$conn));
	      echo "inserimento operazione di noleggio riuscita";
	    }
	    else echo "inserimento operazione di noleggio non riuscita";
	  }
	}
	else if(isset($_POST['segnala'])){
	  if(add_rottura($tessera,$_POST['col'])) echo "aggiunta segnalazione rottura";
	  else echo "aggiunta segnalazione rottura non riuscita";
	}
	else if(isset($_POST['deposita'])){
	  if($_SESSION["noleggioInCorso"]){
	      if(add_operazione('Deposito',$_POST['col'],$_SESSION["Bicicletta"],$tessera)) {
		$_SESSION["noleggioInCorso"] = FALSE;
		echo "operazione di deposito riuscita";
	      }
	      else echo "operazione di deposito non riuscita";
	  }
	  else echo "errore, noleggio già in corso";
	}
	else{
	  if(add_mancanza($_POST['stazione'],$tessera)) echo "aggiunta segnalazione mancanza";
	  else echo "aggiunta segnalazione mancanza non riuscita";
	}
}
else{
	redirect("utente.php",0);
	exit;
}
echo '</br>'.page_link("LogOut","logout.php");
echo '</br>'.page_link("Torna all'area utente","utente.php");
page_end();
?>
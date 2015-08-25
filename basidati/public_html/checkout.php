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
	    if(add_operazione('Prelievo',$_POST['col'],NULL,$tessera)) {
	      $_SESSION["noleggioInCorso"] = TRUE;
	      $queryBic = 'SELECT Operazione.Bicicletta FROM Operazione WHERE Operazione.IdTessera = '.$tessera.' ORDER BY Operazione.Orario DESC LIMIT 1';
	      $_SESSION["Bicicletta"] = fetch_singolo(mysql_query($queryBic,$conn));
	      echo "Inserimento operazione di noleggio riuscita";
	    }
	    else echo "Inserimento operazione di noleggio non riuscita";
	  }
	}
	else if(isset($_POST['segnala'])){
		$query = "SELECT * FROM SegnalazioneRottura WHERE IdTessera = '$tessera' AND Colonnina = $_POST[col]";  
		$res = fetch_singolo(mysql_query($query,$conn));
		if($res==NULL){
			if(add_rottura($tessera,$_POST['col'])) echo "Aggiunta segnalazione rottura";
			else echo "Aggiunta segnalazione rottura non riuscita";
		}
		else echo "Segnalazione non inviata poichè già segnalata dalla sua tessera.";
	}
	else if(isset($_POST['deposita'])){
	  if($_SESSION["noleggioInCorso"]){
	      if(add_operazione('Deposito',$_POST['col'],$_SESSION["Bicicletta"],$tessera)) {
		$_SESSION["noleggioInCorso"] = FALSE;
		echo "Operazione di deposito riuscita";
	      }
	      else echo "Operazione di deposito non riuscita";
	  }
	  else echo "Errore, noleggio già in corso";
	}
	else{
		$query = "SELECT * FROM SegnalazioneMancanza WHERE IdTessera = '$tessera' AND NomeStazione = '$_POST[stazione]'";  
		$result=fetch_singolo(mysql_query($query,$conn));
		if($result==NULL){
		  if(add_mancanza($_POST['stazione'],$tessera)) echo "Aggiunta segnalazione mancanza";
		  else echo "Aggiunta segnalazione mancanza non riuscita";
		 }
		else echo "Segnalazione non inviata poichè già segnalata dalla sua tessera.";
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
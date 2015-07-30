<?php
require("connect.php");

// connect to db server
function connectDbServer() {
  return dbConnect();
}

//select database
function selectDatabase($connect) {
  $dbname = "mviolett-PR";
  return mysql_select_db($dbname,$connect);
}

// inizio html
function page_start($title) {
  $urlcss = 'all.css';
  echo<<<START
<!--? xml version="1.0" encoding="utf8" ?-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="it" lang="it">
<head>
<title>$title</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="author" content="Giuseppe Merlino, Miki Violetto"/>
<meta name="language" content="italian it"/>
<link href="stylesheet/$urlcss" rel="stylesheet" type="text/css" media="all">
</head>
<body>
<p><h1>BiciRent</h1></p>
START;
//<meta name="title" content="Login"/>
//<meta name="viewport" content="width=device-width, user-scalable=no"/>
//<meta http-equiv="Content-Script-Type" content="text/javascript"/>
//<link rel="icon" href="imgs/favicon.png" type="image/ico"/>
//<link href="stylesheet/style.css" rel="stylesheet" type="text/css" media="screen"/>
};

//fa redirect a dove
function redirect($dove,$secondi) {
header("location: $dove");
}

// fine html
function page_end() {
  page_foot();
  echo '</body></html>';
};

// link html
function page_link($descr, $url) {
  return '<a href="'.$url.'">$descr</a>';
};

// link html aperto su una nuova pagina
function new_page_link($descr,$url) {
  return '<a href="'.$url.'" target="_blank">'.$descr.'</a>';
};

// foot html
function page_foot() {
  echo "<div id='foot'>Copyright &#xA9; 2014 - All Rights Reserved. Giuseppe Merlino, Miki Violetto</div>";
};

//controlla se sono loggato e nel caso ritorna id_tessera
function check_session() {
  session_start();
  if(isset($_SESSION['id_tessera']))
    return $_SESSION['id_tessera'];
  return FALSE;
}

//fa il logout
function logout() { //devo avere già controllato session
  if(isset($_SESSION['id_tessera'])) {
    unset($_SESSION['id_tessera']);
    session_destroy();
  }
}

//inserisco un'operazione : nel caso di deposito o aggiunta ho la bici, nel caso di prelievo o rimozione non ho la bici e me la ricavo dalla colonnina
function add_operazione($motivazione,$colonnina,$bicicletta,$tessera) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  if($bicicletta == '0') {
    $queryBic = "SELECT Colonnina.Bicicletta FROM Colonnina WHERE Colonnina.CodiceMateriale = '$colonnina'";
    $bicicletta = fetch_singolo(mysql_query($queryBic,$conn));
  }
  $queryOp = "INSERT INTO Operazione(Colonnina,Bicicletta,Motivazione,IdTessera) VALUES ('$colonnina','$bicicletta','$motivazione','$tessera')";
  return mysql_query($queryOp,$conn); 
}

//addOperazione per i tecnici
function add_operazione_tecnico($motivazione,$colonnina,$bicicletta) {
  return addOperazione($motivazione,$colonnina,$bicicletta,'NULL');
}

//inserisco una manutenzione
function add_manutenzione($materiale,$descrizione) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  $queryOp = "INSERT INTO Manutenzione(DescrizioneDanno, CodiceMateriale) VALUES ('$descrizione','$materiale')";
  return mysql_query($queryOp,$conn); 
}

//inserisco una SegnalazioneRottura
function add_rottura($tessera,$colonnina) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  $queryRo = "INSERT INTO SegnalazioneRottura (Colonnina, IdTessera) VALUES ('$colonnina','$tessera')";
  return mysql_query($queryRo,$conn); 
}

//inserisco una SegnalazioneMancanza
function add_mancanza($tessera,$stazione) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  $queryRo = "INSERT INTO SegnalazioneMancanza (NomeStazione, IdTessera) VALUES ('$stazione','$tessera')";
  return mysql_query($queryRo,$conn); 
}

//funzione che fa il fetch della risorsa e ritorna il primo elemento della prima riga
function fetch_singolo($risorsa) {
  $row = mysql_fetch_array($risorsa);
  return $row[0];
}

?>
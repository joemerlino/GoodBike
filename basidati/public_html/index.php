<?php
require("library.php");

$tessera = check_session();


if($tessera){
  redirect('utente.php',0);
  exit;
}

$errore = FALSE;

if($_POST and $_POST['login'] == 'Entra') {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  $query = "SELECT * FROM Tessera WHERE IdTessera = '".$_POST['idtes']."'";
  $utente = mysql_query($query,$conn);
  if(mysql_num_rows($utente) == 1) {
    $row = mysql_fetch_assoc($utente);
    $_SESSION["id_tessera"] = $row["IdTessera"];
      
    $query2 = "SELECT Operazione.Motivazone FROM Tessera LEFT JOIN Operazione ON Tessera.IdTessera = Operazione.IdTessera WHERE Tessera.IdTessera = '$tessera' ORDER BY Operazione.Orario DESC LIMIT 1;";
    $noleggioInCorso = fetch_singolo(mysql_query($query2,$conn));
    if($noleggioInCorso and $noleggioInCorso == '0') $_SESSION["noleggioInCorso"] = TRUE;
      else $_SESSION["noleggioInCorso"] = FALSE;
    redirect("utente.php",0);
    exit;
  }
  else
    $errore = TRUE;
}

page_start('Home - BiciRent');
echo '<div id="container"><div>';
if($errore)
  echo "<p>Errore, IdTessera errato, inserisci l'id esatto della tua tessera per iniziare</p>";
else
  echo "<p>Benvenuto nel sistema, inserisci l'id della tua tessera per iniziare</p>";
echo "<form action='index.php' method='POST'><p>Inserisci IdTessera: <input type='text' name='idtes' ";
if($errore)
  echo "value='".$_POST['idtes']."' ";
echo "/></p><p><input type='submit' name='login' value='Entra'></p></form></div>";  
echo "<div><p>".page_link("Area tecnico","tecnico.php")."</p></div>";
echo "<div><p>".page_link("Area trasportatori","trasporto.php")."</p></div>";
echo "<div><p>".page_link("Amministrazione","admin.php")."</p></div>";
echo "</div>";

page_end();
?>
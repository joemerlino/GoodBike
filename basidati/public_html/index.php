<?php
require("library.php");

$tessera = check_session();

page_start("Home - BiciRent");
if($tessera){
  redirect("utente.php",0);
  exit;
}
else {
  if($_POST and $_POST["submit"] = "Entra") {
    $conn = connectDbServer();
    $connect = selectDatabase($conn);
    $query = "SELECT * FROM Tessera WHERE IdTessera = '".$_POST['idtes']."'";
    $utente = mysql_query($query,$conn);
    if(mysql_num_rows($utente) == 1) {
      $row = mysql_fetch_assoc($utente);
      $_SESSION["id_tessera"] = $row["IdTessera"];
      
      $queryOp = "SELECT IdOperazione FROM Operazione WHERE Operazione.IdTessera = '$tessera' LIMIT 1;";
      if(mysql_query($queryOp,$conn)) {
            $query2 = "SELECT Operazione.Motivazone FROM Tessera JOIN Operazione ON Tessera.IdTessera = Operazione.IdTessera WHERE Tessera.IdTessera = '$tessera' ORDER BY Operazione.Orario DESC LIMIT 1;";
      if(mysql_query($query2,$conn) == '0') $_SESSION["noleggioInCorso"] = true;
      else $_SESSION["noleggioInCorso"] = false;
      }
      else $_SESSION["noleggioInCorso"] = false;
      
      redirect("utente.php",0);
    }
    else {
      echo "<p>Errore, IdTessera errato, inserisci l'id esatto della tua tessera per iniziare</p>";
      echo "<form action='index.php' method='POST'>";
      echo "<p>Inserisci IdTessera: <input type='text' name='idtes' value='".$_POST['idtes']."'/></p>";
      echo "<p><input type='submit' value='Entra'></p></form>";
    }
  }
  else {
    echo<<<ENDFORM
<p>Benvenuto nel sistema, inserisci l'id della tua tessera per iniziare</p>
<form action='index.php' method='POST'>
<p>Inserisci IdTessera: <input type='text' name='idtes' /></p>
<p><input type='submit' value='Entra'></p>
</form>
ENDFORM;
  }
}
page_end();
?>
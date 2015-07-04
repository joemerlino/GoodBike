<?php
require("library.php");

$tessera = check_session();

page_start("Home - BiciRent");
if($tessera)
  echo "Benvenuto nel sistema $tessera";
else {
  if($_POST and $_POST["submit"] = "Entra") {
    $conn = connectDbServer();
    $connect = selectDatabase($conn);
    $query = "SELECT * FROM Tessera WHERE IdTessera = '".$_POST['idtes']."'";
    $utente = mysql_query($query,$conn));
    if(mysql_num_rows($utente) == 1) {
      $row = mysql_fetch_assoc($utente);
      $tessera = $row["IdTessera"];
      $_SESSION["id_tessera"] = $tessera;
      echo "Benvenuto nel sistema $tessera";
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

echo "<div><p>pulsante admin</p></div>";

page_end();
?>

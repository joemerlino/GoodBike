<?php
require("library.php");

$tessera = check_session();

page_start("Home - BiciRent");
if($tessera)
  echo "Benvenuto nel sistema $tessera";
else {
  if(check_post_login()) {
    $loggato = login_session();
    if($loggato) {
      echo "Benvenuto nel sistema ".$_SESSION['id_tessera'];
    }
    else {
      echo "<p>Errore, IdTessera errato, inserisci l'id esatto della tua tessera per iniziare</p>";
      echo "<form action='index.php' method='POST'>";
      echo "<p>Inserisci IdTessera: <input type='text' name='idtes' value='".$_POST['idtes']."/></p>";
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

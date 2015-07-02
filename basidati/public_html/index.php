<?php
require("library.php");

$tessera = get_id_tessera();

page_start("Home - BiciRent");
if($tessera)
  echo "Benvenuto nel sistema $tessera";
else {
  echo<<<ENDFORM
Benvenuto nel sistema, inserisci l'id della tua tessera per iniziare
<form action='index.php' method='POST'>
<p>Inserisci IdTessera: <input type='text' name='idtes' /></p>
<p><input type='submit' value='Entra'></p>
</form>
ENDFORM;
}
page_end();
?>
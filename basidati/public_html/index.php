<?php
require("Library.php");

page_start("Home - BiciRent");
echo "Benvenuto nel sistema, inserisci l'id della tua tessera per iniziare";
echo "<form action='index.php' method='POST'>
 <p>Inserisci IdTessera: <input type='text' name='idtes' /></p>
 <p><input type='submit' value='Entra'></p>
</form>";
page_end();
?>
<?php
require("library.php");
page_start("Tecnico - BiciRent");
$connect=connectDbServer();
$db=selectDatabase($connect);
echo page_link("Torna ad home page","index.php");
if($_POST){
	if(add_manutenzione($_POST['col'],$_POST['descrizione'])) echo " Messaggio dal sistema: Riparazione rottura inserita!";
	  else echo " Messaggio dal sistema: Inserimento riparazione rottura non riuscito";
}
$query=mysql_query("SELECT CodiceMateriale,NomeStazione,COUNT(CodiceMateriale) FROM Colonnina RIGHT JOIN SegnalazioneRottura ON Colonnina.CodiceMateriale=SegnalazioneRottura.Colonnina GROUP BY CodiceMateriale ORDER BY COUNT(CodiceMateriale) DESC",$connect);
echo "<div id='container'><h2>Monitoraggio segnalazioni manutenzione</h2><form action='tecnico.php' method='POST'><table><thead><tr><th>Seleziona</th><th>Colonnina</th><th>Stazione</th><th>Priorità</th></tr></thead>";
while($row=mysql_fetch_row($query)){

	echo "<tr bgcolor='".dechex(16775492-4000*$row[2])."'><td><input type='radio' name='col' value='$row[0]'></td><td>".$row[0]."</td><td>".$row[1]."</td><td>".$row[2]."</td>";
	}
echo "</table><textarea name='descrizione' maxlength='100' placeholder='Inserisci descrizione manutenzione eseguita' rows='5' cols='53'></textarea></br><input type='submit' name='riparazione' value='Riparazione Rottura'></form></div>";
page_end();
?>
<?php
require("library.php");
page_start("Trasporto - BiciRent");
echo "<script>
var status;
function set(valore){
	if(valore)	document.getElementById('magazz').style.visibility = 'visible';
	else document.getElementById('magazz').style.visibility = 'hidden';
}
</script>
";
$connect=connectDbServer();
$db=selectDatabase($connect);
echo page_link("Torna ad home page","index.php");
if($_POST){
	if(!empty($_POST['stazione'])){
		if($_POST['arrivo']!='Magazzino'){
			foreach($_POST['stazione'] as $selected){
				add_operazione_tecnico('Rimozione',NULL,$selected);
				$query = "SELECT CodiceMateriale FROM Colonnina WHERE NomeStazione = $_POST[arrivo] AND Bicicletta IS NULL";
				$Colonnina = fetch_singolo(mysql_query($query,$connect));
				if($Colonnina != NULL)
					add_operazione_tecnico('Aggiunta',$Colonnina,$selected);
				else echo "Errore: Non ho aggiunto la bicicletta ".$selected." poichè sono finite le colonnine libere alla stazione desiderata.</br>";
			}
		}
		else{
			foreach($_POST['stazione'] as $selected){
				add_operazione_tecnico('Rimozione',NULL,$selected);
			}
		}
	}
	if(!empty($_POST['magazzino'])){
			foreach($_POST['magazzino'] as $selected){
				$query = "SELECT CodiceMateriale FROM Colonnina WHERE NomeStazione = $_POST[arrivo] AND Bicicletta IS NULL";
				$Colonnina = fetch_singolo(mysql_query($query,$connect));
				if($Colonnina != NULL)
					add_operazione_tecnico('Aggiunta',$Colonnina,$selected);
				else echo "Errore: Non ho aggiunto la bicicletta ".$selected." poichè sono finite le colonnine libere alla stazione desiderata.</br>";
			}
		}
}
$query=mysql_query("SELECT Stazione.NomeStazione, COUNT(SegnalazioneMancanza.NomeStazione) FROM Stazione LEFT JOIN SegnalazioneMancanza ON Stazione.NomeStazione = SegnalazioneMancanza.NomeStazione GROUP BY SegnalazioneMancanza.NomeStazione ORDER BY COUNT(SegnalazioneMancanza.NomeStazione) DESC",$connect);
echo "</br><form action='trasporto.php' method='POST'><div class='manutenzione'><h2>Monitoraggio segnalazioni mancanze</h2><table><thead><tr><th>Seleziona</th><th>Nome stazione</th><th>Priorità</th></tr></thead>";
while($row=mysql_fetch_row($query)){
	echo "<tr bgcolor='".dechex(16775492-4000*$row[1])."'><td><input type='radio' name='arrivo' value='$row[0]' onclick='set(true)'></td><td>".$row[0]."</td><td>".$row[1]."</td>";
	}
	echo "<tr bgcolor='".dechex(16775492)."'><td><input type='radio' name='arrivo' value='Magazzino' onclick='set(false)'></td><td>Magazzino</td><td>-</td>";
echo "</table></div><div class='manutenzione'><h2>Riepilogo stazioni</h2><table><thead><tr><th>Seleziona</th><th>Codice Bicicletta</th><th>Stazione</th></tr></thead>";
$query=mysql_query("SELECT Bicicletta, NomeStazione FROM Colonnina WHERE Bicicletta IS NOT NULL",$connect);
while($row=mysql_fetch_row($query)){
	echo "<tr><td><input type='checkbox' name='stazione[]' value='$row[0]'></td><td>".$row[0]."</td><td>".$row[1]."</td>";
	}
echo "</table></div><div class='manutenzione' id='magazz'><h2>Riepilogo Magazzino</h2><table>";
$query=mysql_query("SELECT Bicicletta.CodiceMateriale FROM Bicicletta LEFT JOIN Materiale ON Bicicletta.CodiceMateriale = Materiale.CodiceMateriale WHERE Stato = 'InMagazzino' AND Danneggiato = FALSE",$connect);
$conta=0;
while($row=mysql_fetch_row($query)){
	if($conta%5==0)
			echo "<tr>";
		$conta++;
		echo "<td><input type='checkbox' name='magazzino[]' value='$row[0]'>".$row[0]."</td>";
	if($conta%5==0){
			echo "</tr>";
		}
	}
	echo "</table></div><input type='submit' name='riparazione' value='Riparazione Rottura'></form>";
page_end();
?>
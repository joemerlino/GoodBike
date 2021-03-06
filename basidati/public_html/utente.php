<?php
require("library.php");
$tessera = check_session();
if(!$tessera){
	redirect("index.php",0);
	exit;
}
$noleggio = $_SESSION["noleggioInCorso"];
page_start("Noleggio - BiciRent");
echo "<script>
var status;
function setButtons(occupato,danneggiato){
	document.getElementById('segnala').disabled = false;
	if(status=='true'){
		if(occupato && !danneggiato){
			document.getElementById('noleggia').disabled = false;
		}
		else{
			document.getElementById('noleggia').disabled = true;
		}
	}
	else{
		if(occupato || danneggiato){
			document.getElementById('deposita').disabled = true;
		}
		else{
			document.getElementById('deposita').disabled = false;
		}
	}
}
</script>";
$connect=connectDbServer();
$db=selectDatabase($connect);
$query=mysql_query("SELECT Nome,Cognome FROM Utente JOIN Tessera ON Utente.IdTessera=$tessera",$connect);
$row=mysql_fetch_assoc($query);
echo "<div id='container'><p>Benvenuto ".$row["Nome"]." ".$row["Cognome"]."!&#09;".page_link("logout","logout.php").'</p>';
if($noleggio) echo '<p>Attualmente stai noleggiando la bicicletta'.$_SESSION['Bicicletta'].'</p>';
else echo '<p>non stai noleggiando nessuna bicicletta</p>';
$query=mysql_query("SELECT NomeStazione FROM Stazione",$connect);
echo "</br>Seleziona stazione: <form action='utente.php' method='POST'><select name='staz' onchange='this.form.submit()'><option value='' disabled selected>Seleziona...</option>";
while($row=mysql_fetch_row($query)){
	if($_POST and $_POST['staz'])
		$selectOption = $_POST['staz'];
	if($selectOption==$row[0])
		echo "<option value='$row[0]' selected>$row[0]</option>";
	else
		echo "<option value='$row[0]'>$row[0]</option>";
};
echo "</select></form></div>";
if($_POST and $_POST['staz']){
	$query=mysql_query("SELECT Colonnina.CodiceMateriale,Bicicletta,Danneggiato FROM Colonnina JOIN Materiale ON Colonnina.CodiceMateriale=Materiale.CodiceMateriale WHERE NomeStazione='$selectOption'",$connect);
	echo "<form action='checkout.php' method='POST'><input type='hidden' name='stazione' value='".$_POST['staz']."'><table>";
	$conta=0;
	$occ=0;
	$free=0;
	while($row=mysql_fetch_row($query)){
		if($conta%5==0)
			echo "<tr>";
		$conta++;
		if($row[2]==true){
			echo "<td class='dis' name='$row[0]'>$row[0]<input type='radio' name='col' value='$row[0]' onclick='setButtons(true,$row[2])'></td>";
			if(!$_SESSION["noleggioInCorso"]) $free++;
			else $occ++;
		}
		else if($row[1]!=NULL){
			echo "<td class='occ' name='$row[0]'>$row[0]<input type='radio' name='col' value='$row[0]' onclick='setButtons(true,$row[2])'></td>";
			$occ++;
		}
		else{	
			echo "<td class='free' name='$row[0]'>$row[0]<input type='radio' name='col' value='$row[0]' onclick='setButtons(false,$row[2])'></td>";
			$free++;
		}
		if($conta%5==0){
			echo "</tr>";
		}	
	};
	echo "</table>";
	echo "<div id='buttons'>";
	
	//se non ha noleggi in corso il bottone si attiva se tutto libero mentre se ha noleggi si attiva se tutto occupato
	if(!$_SESSION["noleggioInCorso"]){
		echo "<script>status=true;</script>";
		echo "Ora seleziona la colonnina per il noleggio o la segnalazione.<br>";
		if($free==$conta){
			echo "<input type='submit' name='mancanza' value='Segnalazione Mancanza'>";
		}
		else{
			echo "<input type='submit' name='mancanza' value='Segnalazione Mancanza' disabled>";
		}
		echo "<input type='submit' name='noleggia' id='noleggia' value='Noleggia' disabled>";
	}
	else{
		echo "<script>status=false;</script>";
		echo "Ora seleziona la colonnina per il deposito o la segnalazione.<br>";
		if($occ==$conta){
			echo "<input type='submit' name='mancanza' value='Segnalazione Mancanza' disabled>";
		}
		else{
			echo "<input type='submit' name='mancanza' value='Segnalazione Mancanza' disabled>";
		}
		echo "<input type='submit' name='deposita' id='deposita' value='Deposita' disabled>";
	}
	echo "<input type='submit' name='segnala' id='segnala' value='Segnala rottura' disabled>";
	echo "</div></form>";
}
page_end();
?>
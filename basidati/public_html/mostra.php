<?php
require('library.php');

page_start('Visualizzazione - BiciRent');

if($_GET) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  
  if($_GET['action'] == 'utente') {
    $query = 'SELECT * FROM Tessera LEFT JOIN Utente ON Tessera.IdTessera = Utente.IdTessera';
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Id Tessera</td><td>Data Attivazione</td><td>Nome</td><td>Cognome</td><td>Data Nascita</td><td>Luogo Nascita</td><td>Residenza</td><td>Indirizzo</td><td>Email</td><td>Tipo</td><td>Codice</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>'.$row[1].'</td><td>'.$row[2].'</td><td>'.$row[3].'</td><td>'.$row[4].'</td><td>'.$row[5].'</td><td>'.$row[6].'</td><td>'.$row[7].'</td><td>'.$row[8].'</td><td>'.$row[9].'</td>';
      if($row[9] == 'Studente') {
	if($row[11] != '0')
	  echo ' Matricola: '.$row[10];
	else
	  echo ' IoStudio: '.$row[10];
      }
      echo '</td></tr>';
    }
    echo '</table></div>';
  }
  if($_GET['action'] == 'tessera') {
    $query = "SELECT * FROM Tessera";
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Id</td><td>Attivazione</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>'.$row[1].'</td></tr>';
    }
    echo '</table></div>';
  }
  if($_GET['action'] == 'stazione') {
    $query = 'SELECT * FROM Stazione';
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Nome Stazione</td><td>Via</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>'.$row[1].'</td></tr>';
    }
    echo '</table></div>';
  }
  if($_GET['action'] == 'bicicletta') {
    $query = 'SELECT * FROM Bicicletta';
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Codice Materiale</td><td>Elettrica</td><td>Stato</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>';
      if($row[1])
	echo 'Si';
      else
	echo 'No';
      echo '</td><td>'.$row[2].'</td></tr>';
    }
    echo '</table></div>';
  }
  if($_GET['action'] == 'colonnina') {
    $query = 'SELECT * FROM Colonnina';
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Codice Materiale</td><td>Nome Stazione</td><td>Bicicletta</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>'.$row[2].'</td><td>';
      if($row[1])
	echo $row[1];
      else
	echo 'Assente';
      echo '</td></tr>';
    }
    echo '</table></div>';
  }
  if($_GET['action'] == 'materiale') {
    $query = 'SELECT * FROM Materiale LEFT JOIN Bicicletta ON Materiale.CodiceMateriale = Bicicletta.CodiceMateriale';
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo '<tr><td>Codice Materiale</td><td>Danneggiato</td><td>Tipo</td></tr>';
    while($row=mysql_fetch_row($resource)){
      echo '<tr><td>'.$row[0].'</td><td>';
      if($row[1] == '0')
	echo 'No';
      else
	echo 'Si';
      echo '</td><td>';
      if($row[2] == 'NULL')
	echo 'Colonnina';
      else
	echo 'Bicicletta';
      echo '</td></tr>';
    }
    echo '</table></div>';
  }
}
else
  echo '<p>Nessuna tabella selezionata</p>';

page_end();

?>
<?php
require('library.php');

page_start('Visualizzazione - BiciRent');

if($_GET) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
  
  if($_GET['action'] == 'utente') {
  }
  if($_GET['action'] == 'tessera') {
    $query = "SELECT * FROM Tessera";
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo "<tr><td>Id</td><td>Scadenza</td></tr>";
    while($row=mysql_fetch_row($resource)){
      echo "<tr><td>".$row[0]."</td><td>".$row[1]."</td></tr>";
    }
    echo "</table></div>";
  }
  if($_GET['action'] == 'stazione') {
    $query = "SELECT * FROM Stazione";
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo "<tr><td>Nome Stazione</td><td>Via</td></tr>";
    while($row=mysql_fetch_row($resource)){
      echo "<tr><td>".$row[0]."</td><td>".$row[1]."</td></tr>";
    }
    echo "</table></div>";
  }
  if($_GET['action'] == 'bicicletta') {
    $query = "SELECT * FROM Bicicletta";
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo "<tr><td>Codice Materiale</td><td>Elettrica</td><td>Stato</td></tr>";
    while($row=mysql_fetch_row($resource)){
      echo "<tr><td>".$row[0]."</td><td>";
      if($row[1])
	echo "Si";
      else
	echo "No";
      echo "</td><td>".$row[2]."</td></tr>";
    }
    echo "</table></div>";
  }
  if($_GET['action'] == 'colonnina') {
    $query = "SELECT * FROM Colonnina";
    $resource = mysql_query($query,$conn);
    echo "<div class='mostra'><table>";
    echo "<tr><td>Codice Materiale</td><td>Nome Stazione</td><td>Bicicletta</td></tr>";
    while($row=mysql_fetch_row($resource)){
      echo "<tr><td>".$row[0]."</td><td>".$row[2]."</td><td>";
      if($row[1])
	echo $row[1];
      else
	echo "Assente";
      echo "</td></tr>";
    }
    echo "</table></div>";
  }
  if($_GET['action'] == 'materiale') {
  }
}
else
  echo "<p>Nessuna tabella selezionata</p>";

page_end();

?>
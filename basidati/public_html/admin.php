<?php
require('library.php');

if($_GET) {
  $conn = connectDbServer();
  $connect = selectDatabase($conn);
}

if($_GET and $_POST) {
  if($_GET['action'] == 'aggiungi utente' and $_POST['submit'] == 'aggiungi utente') {
    if($_POST['Tipo'] == 'Studente')
      $query = "INSERT INTO Utente(Nome, Cognome, DataNascita, LuogoNascita, Residenza,Indirizzo, Email, Tipo, CodiceStudente, IoStudio) VALUES ('$_POST[Nome]','$_POST[Cognome]','$_POST[DataNascita]','$_POST[LuogoNascita]','$_POST[Residenza]','$_POST[Indirizzo]','$_POST[Email]','Studente','$_POST[CodiceStudente]','$_POST[IoStudio]')";
    else
      $query = "INSERT INTO Utente(Nome, Cognome, DataNascita, LuogoNascita, Residenza,Indirizzo, Email, Tipo, CodiceStudente, IoStudio) VALUES ('".$_POST['Nome']."','".$_POST['Cognome']."','".$_POST['DataNascita']."','".$_POST['LuogoNascita']."','".$_POST['Residenza']."','".$_POST['Indirizzo']."','".$_POST['Email']."','".$_POST['Tipo']."','NULL','NULL')";

    if(mysql_query($query,$conn))
      redirect("admin.php?action=aggiungi+utente&error=false",0);
    else
      redirect("admin.php?action=aggiungi+utente&error=true",0);
    exit;
  }
  if($_GET['action'] == 'elimina tessera' and $_POST['submit'] == 'elimina tessera') {
    $query = "DELETE FROM Tessera WHERE Tessera.IdTessera = ".$_POST['IdTessera'];
    if(mysql_query($query,$conn))
      redirect("admin.php?action=elimina+tessera&error=false",0);
    else
      redirect("admin.php?action=elimina+tessera&error=true",0);
    exit;
  }
  if($_GET['action'] == 'aggiungi stazione' and $_POST['submit'] == 'aggiungi stazione') {
    $query = "INSERT INTO Stazione(NomeStazione,Via) VALUES ('".$_POST['NomeStazione']."','".$_POST['Via']."')";
    if(mysql_query($query,$conn))
      redirect("admin.php?action=aggiungi+stazione&error=false",0);
    else
      redirect("admin.php?action=aggiungi+stazione&error=true",0);
    exit;
  }
  if($_GET['action'] == 'elimina stazione' and $_POST['submit'] == 'elimina stazione') {
    $query = "DELETE FROM Stazione WHERE Stazione.NomeStazione = ".$_POST['NomeStazione'];
    if(mysql_query($query,$conn))
      redirect("admin.php?action=elimina+stazione&error=false",0);
    else
      redirect("admin.php?action=elimina+stazione&error=true",0);
    exit;
  }
  if($_GET['action'] == 'aggiungi bicicletta' and $_POST['submit'] == 'aggiungi bicicletta') {
    if($_POST['Elettrica'] == 'true')
      $_POST['Elettrica'] = 1;
    else
      $_POST['Elettrica'] = 0;
    $query = "INSERT INTO Bicicletta (Elettrica) VALUES ('".$_POST['Elettrica']."')";
    if(mysql_query($query,$conn))
      redirect("admin.php?action=aggiungi+bicicletta&error=false",0);
    else
      redirect("admin.php?action=aggiungi+bicicletta&error=true",0);
    exit;
  }
  if($_GET['action'] == 'aggiungi colonnina' and $_POST['submit'] == 'aggiungi colonnina') {
    $query = "INSERT INTO Colonnina (NomeStazione) VALUES ('".$_POST['Stazione']."')";
    if(mysql_query($query,$conn))
      redirect("admin.php?action=aggiungi+colonnina&error=false",0);
    else
      redirect("admin.php?action=aggiungi+colonnina&error=true",0);
    exit;
  }
  if($_GET['action'] == 'elimina materiale' and $_POST['submit'] == 'elimina materiale') {
    $query = "DELETE FROM Materiale WHERE Materiale.CodiceMateriale = ".$_POST['CodiceMateriale'];
    if(mysql_query($query,$conn))
      redirect("admin.php?action=elimina+materiale&error=false",0);
    else
      redirect("admin.php?action=elimina+materiale&error=true",0);
    exit;
  }
}

page_start('Amministrazione - BiciRent');
echo page_link("Torna ad home page","index.php");
if($_GET) {
  if($_GET['action'] == 'aggiungi utente') {
    echo "<p>".new_page_link('lista utenti','mostra.php?action=utente')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>utente aggiunto</p>";
      else
	echo "<p>aggiunta non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=aggiungi+utente' method='POST'>";
    echo "<p>Nome: <input type='text' name='Nome'/></p>";
    echo "<p>Cognome: <input type='text' name='Cognome'/></p>";
    echo "<p>Data di nascita: <input type='text' name='DataNascita' placeholder='aaaa-mm-gg'/></p>";
    echo "<p>Luogo di nascita: <input type='text' name='LuogoNascita'/></p>";
    echo "<p>Residenza: <input type='text' name='Residenza'/></p>";
    echo "<p>Indirizzo: <input type='text' name='Indirizzo'/></p>";
    echo "<p>Email: <input type='text' name='Email'/></p>";
    echo "<p>Tipo :</p>";
    echo "<p><input type='radio' name='Tipo' value='Utente'/>Nessuno</p>";
    echo "<p><input type='radio' name='Tipo' value='Turista'/>Turista</p>";
    echo "<p><input type='radio' name='Tipo' value='Studente'/>Studente</p>";
    echo "<p> Solo per studente</p>";
    echo "<p>Codice studente: <input type='text' name='CodiceStudente'/></p>";
    echo "<p><input type='radio' name='IoStudio' value='0' checked/>Matricola</p>";
    echo "<p><input type='radio' name='IoStudio' value='1'/>Carta Iostudio</p>";
    echo "<p><input type='submit' name='submit' value='aggiungi utente'></p></form></div>";
  }
  if($_GET['action'] == 'elimina tessera') {
    echo "<p>".new_page_link('lista tessere','mostra.php?action=tessera')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>tessera eliminata</p>";
      else
	echo "<p>eliminazione non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=elimina+tessera' method='POST'>";
    echo "<p>IdTessera: <input type='text' name='IdTessera'/></p>";
    echo "<p><input type='submit' name='submit' value='elimina tessera'></p></form></div>";
  }
  if($_GET['action'] == 'aggiungi stazione') {
    echo "<p>".new_page_link('lista stazioni','mostra.php?action=stazione')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>stazione aggiunta</p>";
      else
	echo "<p>aggiunta non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=aggiungi+stazione' method='POST'>";
    echo "<p>Nome Stazione: <input type='text' name='NomeStazione'/></p>";
    echo "<p>Via: <input type='text' name='Via'/></p>";
    echo "<p><input type='submit' name='submit' value='aggiungi stazione'></p></form></div>";
  }
  if($_GET['action'] == 'elimina stazione') {
    echo "<p>".new_page_link('lista stazioni','mostra.php?action=stazione')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>stazione eliminata</p>";
      else
	echo "<p>eliminazione non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=elimina+stazione' method='POST'>";
    echo "<p>Nome Stazione: <input type='text' name='NomeStazione'/></p>";
    echo "<p><input type='submit' name='submit' value='elimina stazione'></p></form></div>";
  }
  if($_GET['action'] == 'aggiungi bicicletta') {
    echo "<p>".new_page_link('lista biciclette','mostra.php?action=bicicletta')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>bicicletta aggiunta</p>";
      else
	echo "<p>aggiunta non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=aggiungi+bicicletta' method='POST'>";
    echo "<p>Elettrica: <input type='checkbox' name='Elettrica' value='true'/></p>";
    echo "<p><input type='submit' name='submit' value='aggiungi bicicletta'></p></form></div>";
  }
  if($_GET['action'] == 'aggiungi colonnina') {
    echo "<p>".new_page_link('lista colonnine','mostra.php?action=colonnina')."</p>";
    echo "<p>".new_page_link('lista stazioni','mostra.php?action=stazione')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>colonnina aggiunta</p>";
      else
	echo "<p>aggiunta non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=aggiungi+colonnina' method='POST'>";
    echo "<p>Nome Stazione: <input type='text' name='Stazione'/></p>";
    echo "<p><input type='submit' name='submit' value='aggiungi colonnina'></p></form></div>";
  }
  if($_GET['action'] == 'elimina materiale') {
    echo "<p>".new_page_link('lista materiale','mostra.php?action=materiale')."</p>";
    if(isset($_GET['error'])) {
      if($_GET['error'] == 'false')
	echo "<p>materiale eliminato</p>";
      else
	echo "<p>eliminazione non riuscita</p>";
    }
    echo "<div class='form'>";
    echo "<form action='admin.php?action=elimina+materiale' method='POST'>";
    echo "<p>Codice Materiale: <input type='text' name='CodiceMateriale'/></p>";
    echo "<p><input type='submit' name='submit' value='elimina materiale'></p></form></div>";
  }
}

echo "<div class='link'>";
echo "<form action='admin.php' method='GET'>";
if(!$_GET or $_GET['action'] <> 'aggiungi utente')
  echo "<p><input type='submit' name='action' value='aggiungi utente'></p>";
if(!$_GET or $_GET['action'] <> 'elimina tessera')
  echo "<p><input type='submit' name='action' value='elimina tessera'></p>";
if(!$_GET or $_GET['action'] <> 'aggiungi stazione')
  echo "<p><input type='submit' name='action' value='aggiungi stazione'></p>";
if(!$_GET or $_GET['action'] <> 'elimina stazione')
  echo "<p><input type='submit' name='action' value='elimina stazione'></p>";
if(!$_GET or $_GET['action'] <> 'aggiungi bicicletta')
  echo "<p><input type='submit' name='action' value='aggiungi bicicletta'></p>";
if(!$_GET or $_GET['action'] <> 'aggiungi colonnina')
  echo "<p><input type='submit' name='action' value='aggiungi colonnina'></p>";
if(!$_GET or $_GET['action'] <> 'elimina materiale')
  echo "<p><input type='submit' name='action' value='elimina materiale'></p>";
echo "</form></div>";

page_end();

?>
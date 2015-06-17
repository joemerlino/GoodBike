<?php

// inizio html
function page_start($title) {
  $urlcss = "all.css";
  echo<<<END
<!--? xml version="1.0" encoding="utf8" ?-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="it" lang="it">
<head>
<title>$title</title>
<link href="$urlcss" rel="stylesheet" type="text/css" media="all">
</head>
<body >
END;
};

// fine html
function page_end() {
  echo "</body></html>";
};

// link html
function page_link($descr, $url) {
  return "<a href=\"$url\">$descr   </a>";
};

// foot html
function page_foot() {
  echo "<div class='foot'><p>Giuseppe Merlino, Miki Violetto</p></div>";
};

// Si connette e seleziona il database
function dbConnect() {  // da sostituire 'login', 'password'
  $server = "basidati";
  $username = "login";
  $password = "password";
  $dbname = "login-PR";
  
  $conn = mysql_connect($server,$username,$password)
    or die("Impossibile connettersi!");
    
  mysql_select_db($dbname,$conn);
  
  return $conn;
}

?>
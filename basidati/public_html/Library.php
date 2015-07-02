<?php
require("connect.php");

// connect to db server
function connectDbServer() {
  return dbConnect();
}

//select database
function selectDatabase($connect) {
  $dbname = "mviolett-PR";
  return mysql_select_db($dbname,$connect);
}

// inizio html
function page_start($title) {
  $urlcss = "all.css";
  echo<<<START
<!--? xml version="1.0" encoding="utf8" ?-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="it" lang="it">
<head>
<title>$title</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="author" content="Giuseppe Merlino, Miki Violetto"/>
<meta name="language" content="italian it"/>
<link href="stylesheet/$urlcss" rel="stylesheet" type="text/css" media="all">
</head>
<body>
<h1>BiciRent</h1>
START;
//<meta http-equiv="refresh" content="3; url=$prev_page">
//<meta name="title" content="Login"/>
//<meta name="viewport" content="width=device-width, user-scalable=no"/>
//<meta http-equiv="Content-Script-Type" content="text/javascript"/>
//<link rel="icon" href="imgs/favicon.png" type="image/ico"/>
//<link href="stylesheet/style.css" rel="stylesheet" type="text/css" media="screen"/>
};

// fine html
function page_end() {
  page_foot();
  echo "</body></html>";
};

// link html
function page_link($descr, $url) {
  return "<a href=\"$url\">$descr   </a>";
};

// foot html
function page_foot() {
  echo<<<FOOT
<div id="foot">
<p>Copyright &#xA9; 2014 - All Rights Reserved.</p>
<p>Giuseppe Merlino, Miki Violetto</p>
</div>
FOOT;
};

?>
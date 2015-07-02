<?php
require("library.php");

page_start("Home");
$connect=connectDbServer();
$db=selectDatabase($connect);
$query=mysql_query("SELECT * FROM Tessera",$connect);
while($row=mysql_fetch_row($query)){
	$id=$row[0];
	$scad=$row[1];
	$nol=$row[2];
	echo "$id - $scad - 	$nol <br />";
};
page_end();

?>
<?php

class connectionParams {}
$param = new connectionParams;

// 'host' for the PostgreSQL server
$param->host = "localhost";

// default port for PostgreSQL is "5432"
$param->port = 5432;

// set the database name for the connection
$param->dbname = "demo";

// set the username for PostgreSQL database
$param->user = "postgres";

// password for the PostgreSQL database
$param->password = "30127800";

// declare a new string for the pgconnect method
$hostString = "";

// use an iterator to concatenate a string to connect to PostgreSQL
foreach ($param as $key => $value) {

    // concatenate the connect params with each iteration
    $hostString = $hostString . $key . "=" . $value . " ";
}

// use the pg_connect() to create a connection
$conn = pg_connect($hostString);
 
// Check connection
if($conn === false){
    die("ERROR: Could not connect. " . pg_connect_error());
}
?>


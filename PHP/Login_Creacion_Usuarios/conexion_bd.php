<?php

$host_db = "localhost:3306";
$user_db = "root";
$pass_db = "123456";
$db_name = "hash_pruebas";
$table_name = "cuentas";

$conexion = new mysqli($host_db, $user_db, $pass_db, $db_name);

if($conexion->connect_error) {
    die("Error de conexion: " . $conexion->connect_error);
}

#$conexion->close();

?>

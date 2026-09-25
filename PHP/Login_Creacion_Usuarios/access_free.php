<?php

session_start();
$_SESSION['usuario'] = "Usuario"; // usuario generico
$_SESSION['connected'] = 1; // Indica que se inicio sesion
header("location: ./pagina_principal.php");
exit();

?>
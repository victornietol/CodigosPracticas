<?php

session_start();
session_unset(); // Eliminar variables de sesion
session_destroy(); // Destriur sesion
setcookie('remember_ejemplo1', "", time() - 1); // Borrar cookie para cerrar sesion
header("location: ./index.php");
exit();

?>
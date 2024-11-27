<?php

session_start();
include "conexion_bd.php";
$usuario = $_POST['txtUsuario'];
$password = $_POST['txtPassword'];
$tabla_bd = "cuentas";
$remember = isset($_POST['check_remember']);

$q = "SELECT * FROM $tabla_bd WHERE usuario = '$usuario'";
$consulta = mysqli_query($conexion, $q); # $conexion esta en conexion_bd.php


if($consulta) { # Verifiando si se realiza la consulta
    # Si la consulta devolvio resultados o no
    if(mysqli_num_rows($consulta) > 0) {
        $resultado_consulta = mysqli_fetch_array($consulta, MYSQLI_ASSOC);
        $hash_passw = $resultado_consulta['passw'];

        # Verificando si el hash corresponde a la contrasenia
        if(password_verify($password, $hash_passw)) {
            $_SESSION['usuario'] = $usuario;
            $_SESSION['connected'] = 1; // Indica que se inicio sesion

            if($remember) {
                // Asignando cookie
                setcookie('remember_ejemplo1', $_SESSION['usuario'], time() + (86400 * 30)); // segundos * dias
            }

            header("location: ./pagina_principal.php");

        } else { // Si el password es incorrecto
            $mensaje_verificacion = "El password es incorrecto";
            $_SESSION['mensaje_verificacion'] = $mensaje_verificacion;
            header("location: ./index.php");
        }

    } else { # No existe el usuario
        $mensaje_verificacion = "El usuario no existe";
        $_SESSION['mensaje_verificacion'] = $mensaje_verificacion;
        header("location: ./index.php");
    }

} else {
    echo "Error en la consulta: " . mysqli_error($conexion);
}
$conexion->close();
exit();
?>
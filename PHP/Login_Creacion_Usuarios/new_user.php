<?php
// Creacion de nuevo usuario

session_start();

// Datos nuevo usuario
$new_user = $_POST['txtUsuario'];
$passw = $_POST['txtPassword'];
$passw_confirm = $_POST['txtPassword_confirm'];

// Verificar que el usuario y el password no contenga espacios en blanco o esten vacios
if(strpos($new_user, " ")) {
    $_SESSION['mensaje_verificacion'] = "Error: El usuario contiene espacios en blanco";
    $_SESSION['usuario'] = $new_user;
    $_SESSION['passw'] = $passw;
    header("location: ./register.php");
    exit();
} else if ($new_user == "") {
    $_SESSION['mensaje_verificacion'] = "Error: Campo usuario vacio";
    $_SESSION['passw'] = $passw;
    header("location: ./register.php");
    exit();
} else if (strpos($passw, " ")) {
    $_SESSION['mensaje_verificacion'] = "Error: El password contiene espacios en blanco";
    $_SESSION['usuario'] = $new_user;
    $_SESSION['passw'] = $passw;
    header("location: ./register.php");
    exit();
} else if ($passw == "") {
    $_SESSION['mensaje_verificacion'] = "Error: Campo password vacio";
    $_SESSION['usuario'] = $new_user;
    header("location: ./register.php");
    exit();
}

// Verificar que el nuevo password coincida
if($passw != $passw_confirm) {
    $_SESSION['mensaje_verificacion'] = "Error: El password introducido no coincide";
    $_SESSION['usuario'] = $new_user;
    header("location: ./register.php");
    exit();
}

// Conexion BD y verificando que el usuario no exista
include "./conexion_bd.php"; // Conexion con la BD
$tbl_name = "cuentas";
$q = "SELECT * FROM $tbl_name WHERE usuario = '$new_user'";
$consulta = mysqli_query($conexion, $q);

if($consulta) {
    if(mysqli_num_rows($consulta) > 0) { // Si se encontro usuario, es decir, el usuario ya existe
        $_SESSION['mensaje_verificacion'] = "Error: El usuario ya existe";
        $_SESSION['usuario'] = $new_user;
        $_SESSION['passw'] = $passw;
        $conexion->close();
        header("location: ./register.php");
        exit();

    } else {
        // Generando hash
        $hash = password_hash($passw, PASSWORD_BCRYPT);

        // Insertando nuevo usuario
        try {
            // Utilizando sentencia preparada
            $stmt = $conexion->prepare("INSERT INTO $tbl_name (usuario, passw) VALUES (?, ?)");
            $stmt->bind_param("ss", $new_user, $hash); // "ss" indica dos strings
            if($stmt->execute()) {
                session_unset(); // Eliminar variables de sesion
                session_destroy(); // Destruir sesion
                header("location: ./newUser_successful.php");
            }
        } catch (Exception $e) {
            echo "Ocurrion una excepcion: " . $e->getMessage();
        } finally {
            $stmt->close();
            $conexion->close();
            exit();
        } 
    }
    
} else {
    echo "Error en la consulta: " . mysqli_error($conexion);
}
$conexion->close();
?>
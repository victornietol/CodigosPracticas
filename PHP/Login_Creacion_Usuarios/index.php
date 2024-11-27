<?php

session_start();

// Mensaje de usuario
/*
$mensaje_verificacion = isset($_GET['mensaje_verificacion']) ? $_GET['mensaje_verificacion'] : 
    (isset($_SESSION['mensaje_verificacion']) ? $_SESSION['mensaje_verificacion'] : '');
*/

if(isset($_SESSION['mensaje_verificacion'])) {
    $mensaje_verificacion = $_SESSION['mensaje_verificacion']; // Asignar el mensaje a variable local
    unset($_SESSION['mensaje_verificacion']); // Eliminando mensaje de verificacion de la variable de sesion
} else { 
    $mensaje_verificacion = ""; // Si no hay mensaje de verificacion
}


// Verificar que no haya sesion iniciada o que exista cookie
if(isset($_SESSION['connected'])) {
    header("location: ./pagina_principal.php"); // Si hay sesion
    exit();
} else if (isset($_COOKIE['remember_ejemplo1'])) {
    $_SESSION['connected'] = 1;
    $_SESSION['usuario'] = $_COOKIE['remember_ejemplo1'];
    header("location: ./pagina_principal.php"); // Si hay cookie
    exit();
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesion</title>
    <link rel="stylesheet" href="./styles/styles.css">
</head>
<body>
    
    <div class="wrapper">
        <form action="./login.php" method="post">
            <h2>Bienvenido</h2>
            <div class="input-field">
                <input type="text" name="txtUsuario" required>
                <label>Ingresa tu usuario</label>
            </div>
    
            <div class="input-field">
                <input type="password" name="txtPassword" required>
                <label>Ingresa tu password</label>
            </div>

            <div>
                <label>
                    <?php // Mensaje de error al iniciar sesion
                        echo htmlspecialchars($mensaje_verificacion);
                    ?>
                </label>
            </div>
    
            <div class="forget">
                <label for="remember">
                    <input type="checkbox" id="remember" name="check_remember">
                    <p>Recuerdame</p>
                </label>
                <a href="#">Olvide mi password</a>
            </div>
    
            <button type="submit">Ingresar</button>
    
            <div class="register">
                <p>
                    No tengo cuenta
                    <?php  
                        session_unset(); // Eliminar variables de sesion
                        session_destroy(); // Destriur sesion
                    ?>
                    <a href="./register.php">Registrarse</a>
                </p>
            </div>
    
        </form>
    </div>

</body>
</html>

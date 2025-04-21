<?php

session_start();

// Verificar que no haya sesion iniciada
if(isset($_SESSION['connected'])) {
    header("location: ./pagina_principal.php"); // Si hay sesion
    exit();
}

if(isset($_SESSION['mensaje_verificacion'])) {
    $mensaje_verificacion = $_SESSION['mensaje_verificacion']; // Asignar el mensaje a variable local
    unset($_SESSION['mensaje_verificacion']); // Eliminando mensaje de verificacion de la variable de sesion
} else { 
    $mensaje_verificacion = ""; // Si no hay mensaje de verificacion
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
    <link rel="icon" type="image/png" sizes="32x32" href="./img/icono.png">
    <link rel="icon" type="image/png" sizes="16x16" href="./img/icono.png">
    <link rel="stylesheet" href="./styles/styles.css">
</head>
<body>
    
    <div class="wrapper">
        <form action="./new_user.php" method="post">
            <h2>Nuevo Usuario</h2>
            <div class="input-field">
                <input 
                    type="text" 
                    name="txtUsuario" 
                    required 
                    value="<?php echo isset($_SESSION['usuario']) ? htmlspecialchars($_SESSION['usuario']) : ''; ?>"
                >
                <label>Ingresa tu nuevo usuario</label>
            </div>
    
            <div class="input-field">
                <input 
                    type="password" 
                    name="txtPassword" 
                    required 
                    value="<?php echo isset($_SESSION['passw']) ? htmlspecialchars($_SESSION['passw']) : ''; ?>"
                >
                <label>Ingresa tu password</label>
            </div>

            <div class="input-field">
                <input type="password" name="txtPassword_confirm" required>
                <label>Confirma tu password</label>
            </div>

            <div>
                <label>
                    <?php // Mensaje de error al iniciar sesion
                        echo htmlspecialchars($mensaje_verificacion);
                    ?>
                </label>
            </div>
    
            <button type="submit" id="btn_register">Crear Usuario</button>
    
            <div class="register">
                <p>
                    Ya tengo cuenta
                    <a href="./index.php">Iniciar Sesion</a>
                </p>
            </div>
    
        </form>
    </div>

</body>
</html>

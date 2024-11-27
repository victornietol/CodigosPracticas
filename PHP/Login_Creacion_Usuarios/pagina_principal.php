<?php

session_start();

// Verificar que haya sesion activa para evitar ingresos sin sesion
if(!isset($_SESSION['connected'])) {
    header("location: ./index.php"); // Si no hay sesion
    exit();
} else {
    $usuario = $_SESSION['usuario']; // Si hay sesion
}

// Desactivar cache
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1
header("Pragma: no-cache"); // HTTP 1.0
header("Expires: 0"); // Proxy

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="./styles/styles2.css">
</head>

<header>
    <div class="header-elementos">
        <span id="header_usuario">
            <?php
                echo htmlspecialchars($usuario);
            ?>
        </span>
        <button id="btn_logout" onclick="location.href='./logout.php'">
            Cerrar Sesion
        </button>
    </div>
</header>

<body>

    <h1 id="titulo_principal">
        <?php
            echo "Bienvenido " . htmlspecialchars($usuario);
        ?>
    </h1>
    
</body>
</html>
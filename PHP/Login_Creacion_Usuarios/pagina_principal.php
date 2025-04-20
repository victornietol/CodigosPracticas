<?php

session_start();

// Verificar que haya sesion activa para evitar ingresos sin sesion
if(!isset($_SESSION['connected'])) {
    header("location: ./index.php"); // Si no hay sesion
    exit();
} else {
    $usuario = $_SESSION['usuario']; // Si hay sesion
    if(isset($_SESSION['texto_plano'])) {
        $texto_plano = $_SESSION['texto_plano'];  // mensaje
        unset($_SESSION['texto_plano']);
    }
    if(isset($_SESSION['texto_cifrado'])) {
        $texto_cifrado = $_SESSION['texto_cifrado'];  // mensaje
        unset($_SESSION['texto_cifrado']);
    }
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
<body>
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
    <main>
        <h1 id="titulo_principal">
            <?php
                echo "Bienvenido " . htmlspecialchars($usuario);
            ?>
        </h1>
        <div style="margin-top: 30px;">
            <h2>Texto plano</h2>
            <form action="./cifrado_cesar.php" id="form_cifrar" method="post">
                <div>
                    <textarea class="caja-texto" name="texto_plano" id="texto_plano" placeholder="Ingresa tu mensaje a cifrar" value=""><?php 
                    if(isset($texto_plano)) {
                        echo htmlspecialchars($texto_plano);  // mensaje
                    }?></textarea>
                </div>
                <div class="botones-caja-texto">
                    <button class="btn-general" onclick="obtenerLlave('cifrar')" type="button">Cifrar</button>
                    <button class="btn-general" type="reset">Limpiar</button>
                </div>
                <input type="hidden" name="llave_cifrado" id="llave_cifrado">
            </form>
        </div>
        <div style="margin-top: 30px">
            <h2>Texto cifrado</h2>
            <form action="./cifrado_cesar.php" id="form_descifrar" method="post">
                <div>
                    <textarea class="caja-texto" name="texto_cifrado" id="texto_cifrado" placeholder="Mensaje cifrado" value=""><?php 
                    if(isset($texto_cifrado)) {
                        echo htmlspecialchars($texto_cifrado);  // mensaje
                    }?></textarea>
                </div>
                <div class="botones-caja-texto">
                    <button class="btn-general" onclick="obtenerLlave('descifrar')" type="button">Descifrar</button>
                    <button class="btn-general" type="reset">Limpiar</button>
                </div>
                <input type="hidden" name="llave_descifrado" id="llave_descifrado">
            </form>
        </div>
    </main>
    
    <footer>

    </footer>
    <script src="./js/script.js"></script>
</body>
</html>
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
    <title>Cifrado y descifrado</title>
    <link rel="icon" type="image/png" sizes="32x32" href="./img/icono.png">
    <link rel="icon" type="image/png" sizes="16x16" href="./img/icono.png">
    <link rel="stylesheet" href="./styles/styles2.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
                <i class="bi bi-box-arrow-right"></i>
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
                    <button class="btn-general" onclick="obtenerLlave('cifrar')" type="button">
                        <i class="bi bi-lock-fill"></i>
                        Cifrar
                    </button>
                    <button class="btn-general" onclick="limpiarTexto('plano')" type="button">
                        <i class="bi bi-arrow-repeat"></i>
                        Limpiar
                    </button>
                    <button class="btn-general" onclick="copiarTexto('plano')" id="boton_copiar_plano" title="Copiar" type="button">
                        <i id="icono_copiar_plano" class="bi bi-check-lg"></i>
                        <i class="bi bi-clipboard-fill"></i>
                        Copiar
                    </button>
                </div>
                <input type="hidden" name="llave_cifrado" id="llave_cifrado">
            </form>
        </div>
        <div style="margin-top: 30px; margin-bottom: 30px;">
            <h2>Texto cifrado</h2>
            <form action="./cifrado_cesar.php" id="form_descifrar" method="post">
                <div>
                    <textarea class="caja-texto" name="texto_cifrado" id="texto_cifrado" placeholder="Mensaje cifrado" value=""><?php 
                    if(isset($texto_cifrado)) {
                        echo htmlspecialchars($texto_cifrado);  // mensaje
                    }?></textarea>
                </div>
                <div class="botones-caja-texto">
                    <button class="btn-general" onclick="obtenerLlave('descifrar')" type="button">
                        <i class="bi bi-unlock-fill"></i>
                        Descifrar
                    </button>
                    <button class="btn-general" onclick="limpiarTexto('cifrado')" type="button">
                        <i class="bi bi-arrow-repeat"></i>    
                        Limpiar
                    </button>
                    <button class="btn-general" onclick="copiarTexto('cifrado')" id="boton_copiar_cifrado" title="Copiar" type="button">
                        <i id="icono_copiar_cifrado" class="bi bi-check-lg"></i>
                        <i class="bi bi-clipboard-fill"></i>
                        Copiar
                    </button>
                </div>
                <input type="hidden" name="llave_descifrado" id="llave_descifrado">
            </form>
        </div>
    </main>
    
    <?php include('./footer.php') ?>
    
    <script src="./js/script.js"></script>
</body>
</html>
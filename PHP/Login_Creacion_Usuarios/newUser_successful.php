<?php
// Verificar que no haya sesion iniciada

session_start();
if(isset($_SESSION['connected'])) {
    header("location: ./pagina_principal.php"); // Si hay sesion
    exit();
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuario creado</title>
    <link rel="stylesheet" href="./styles/styles.css">
</head>
<body>
    
    <div class="wrapper">
        <h2>Registro exitoso</h2>
        <button type="submit" id="btn_register_successful" onclick="location.href='./index.php'">
            Aceptar
        </button>
    </div>

</body>
</html>

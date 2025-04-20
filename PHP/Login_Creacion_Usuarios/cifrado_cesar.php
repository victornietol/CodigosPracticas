<?php
session_start();

// Obtener llave

// Aplicar cifrado
if($_SERVER["REQUEST_METHOD"]=="POST" && isset($_POST["texto_plano"])) {
    $texto_plano = $_POST["texto_plano"];
    $llave = (int)$_POST["llave_cifrado"];
    $texto_cifrado = '';
    
    for($c=0; $c<mb_strlen($texto_plano, 'UTF-8'); $c++) {
        $caracter = mb_substr($texto_plano, $c, 1, 'UTF-8'); // obtener caracter
        $c_ascii = IntlChar::ord($caracter);
        $ascii_cifrado = ($c_ascii+$llave) % 1114111 ;
        $texto_cifrado .= IntlChar::chr($ascii_cifrado);
    }

    $_SESSION["texto_cifrado"] = $texto_cifrado;
    header("location: ./pagina_principal.php");


} else if ($_SERVER["REQUEST_METHOD"]=="POST" && isset($_POST["texto_cifrado"])) {
    $texto_cifrado = $_POST["texto_cifrado"];
    $llave = (int)$_POST["llave_descifrado"];
    $texto_plano = '';

    for($c=0; $c<mb_strlen($texto_cifrado); $c++) {
        $caracter = mb_substr($texto_cifrado, $c, 1, 'UTF-8'); // obtener caracter
        $c_ascii = IntlChar::ord($caracter);
        $ascii_plano = ($c_ascii-($llave)) % 1114111 ;
        $texto_plano .= IntlChar::chr($ascii_plano);
    }

    $_SESSION["texto_plano"] = $texto_plano;
    header("location: ./pagina_principal.php");
}

exit();
?>
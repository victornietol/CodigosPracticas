<?php
session_start();

// Obtener llave
function generarLlaveNueva($llave_plana) {
    $llave_nueva = 0;
    for($i=0; $i<strlen($llave_plana); $i++) {
        $caracter = $llave_plana[$i];
        $c_ascii = ord($caracter); // obtener ascii
        $c_binario = decbin($c_ascii); // obtener binario
        $c_binario = str_pad($c_binario, 8, "0", STR_PAD_LEFT); // construir los 8 bits por caracter
        $llave_nueva += bindec($c_binario); // binario a decimal y se va sumando por caracter
    }
    return $llave_nueva;
}

// Aplicar cifrado
if($_SERVER["REQUEST_METHOD"]=="POST" && isset($_POST["texto_plano"])) {
    $texto_plano = $_POST["texto_plano"];
    $llave_nueva = generarLlaveNueva($_POST["llave_cifrado"]);
    $texto_cifrado = '';
    
    for($c=0; $c<mb_strlen($texto_plano, 'UTF-8'); $c++) {
        $caracter = mb_substr($texto_plano, $c, 1, 'UTF-8'); // obtener caracter
        $c_ascii = IntlChar::ord($caracter);
        $ascii_cifrado = ($c_ascii+$llave_nueva) % 1114111 ;
        $texto_cifrado .= IntlChar::chr($ascii_cifrado);
    }

    $_SESSION["texto_cifrado"] = $texto_cifrado;
    header("location: ./pagina_principal.php");


} else if ($_SERVER["REQUEST_METHOD"]=="POST" && isset($_POST["texto_cifrado"])) {
    $texto_cifrado = $_POST["texto_cifrado"];
    $llave_nueva = generarLlaveNueva($_POST["llave_descifrado"]);
    $texto_plano = '';

    for($c=0; $c<mb_strlen($texto_cifrado); $c++) {
        $caracter = mb_substr($texto_cifrado, $c, 1, 'UTF-8'); // obtener caracter
        $c_ascii = IntlChar::ord($caracter);
        $ascii_plano = ($c_ascii-($llave_nueva)) % 1114111 ;
        $texto_plano .= IntlChar::chr($ascii_plano);
    }

    $_SESSION["texto_plano"] = $texto_plano;
    header("location: ./pagina_principal.php");
}

exit();
?>
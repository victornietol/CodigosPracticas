<?php
session_start();

// Obtener llave
function generarLlaveNueva($llave_plana) {
    $sumatoria_parcial = 0;
    $bloque_bits = '';
    $bloques_bits = [];

    for($i=0; $i<strlen($llave_plana); $i++) {
        $caracter = $llave_plana[$i];
        $c_ascii = ord($caracter); // obtener ascii
        $c_binario = decbin($c_ascii); // obtener binario
        $c_binario = str_pad($c_binario, 8, "0", STR_PAD_LEFT); // construir los 8 bits por
        $sumatoria_parcial += bindec($c_binario); // sumar el valor decimal
        $bloque_bits .= $c_binario; // construyendo el bloque de bits mayor
    }

    // separar en bloques de 4 bits (nibble) el bloque grande
    for($i=0; $i<strlen($bloque_bits); $i+=4) {
        $bloques_bits[] = substr($bloque_bits, $i, 4);
    }

    // intercalar bloques generados
    $num_bloques = strlen($bloque_bits)/4; // numero de bloques en el que se dividio
    for($i=0; $i<$num_bloques; $i+=2) {
        $aux = $bloques_bits[$i];
        $bloques_bits[$i] = $bloques_bits[$i+1]; 
        $bloques_bits[$i+1] = $aux;
    }

    // uniendo los bloques de nuevo
    $bloque_bits = implode("", $bloques_bits);

    // invirtiendo el valor de los bits
    $bloque_bits = str_split($bloque_bits); // convertir el string en arreglo
    for($i=0; $i<count($bloque_bits); $i++) {
        $bloque_bits[$i] = $bloque_bits=="1" ? "0" : "1";
    }
    $bloque_bits = implode("", $bloque_bits); // volviendo a convertir el array a string

    // separando el bloque grande de bits en bloques de 8 (byte) y sumando su valor en decimal a la sumatoria parcial
    $byte = '';
    for($i=0; $i<strlen($bloque_bits); $i+=8) {
        $byte = substr($bloque_bits, $i, 8); // obteniendo segmento
        $sumatoria_parcial += bindec($byte); // sumando valor decimal
    }

    return $sumatoria_parcial;
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
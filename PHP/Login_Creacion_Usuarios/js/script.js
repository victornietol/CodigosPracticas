function obtenerLlave(tipo) {
    const llave = prompt("Ingresa la llave (debe ser un valor númerico):");
    if(llave === null) {
        alert("No se ingreso ningún valor para la llave.");
        return;
    }
    if(isNaN(llave) || llave.trim()==="") {
        // Si no es numero o esta vacio
        alert("Valor incorrecto, se debe ingresar un número.");
        return;
    } else {
        if(tipo==="cifrar") {
            document.getElementById("llave_cifrado").value = llave;
            document.getElementById("form_cifrar").submit();
        } else if (tipo=="descifrar") {
            document.getElementById("llave_descifrado").value = llave;
            document.getElementById("form_descifrar").submit();
        }
    }
}
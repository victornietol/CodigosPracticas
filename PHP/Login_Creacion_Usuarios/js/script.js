// Validacion de la cadena
function obtenerLlave(tipo) {
    const llave = prompt("Ingresa una llave de máximo 12 carácteres (solo letras a-z sin considerar 'ñ', números del 0 al 9, y carácteres como: '-', '_', '@', '*'):");
    const regex = /^[a-zA-Z0-9@*_-]{1,12}$/;
    if(llave === null) {
        alert("No se ingresó ningún valor para la llave.");
        return;
    }
    if(!regex.test(llave)) {
        alert("La llave no es válida. Ingresa otra.");
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


// Limpiar cajas de texto
function limpiarTexto(tipo) {
    if(tipo==="plano") {
        document.getElementById("texto_plano").value = "";
    } else if(tipo==="cifrado") {
        document.getElementById("texto_cifrado").value = "";
    }
}


// Copiar el texto de la caja
function copiarTexto(tipo) {
    if(tipo==="plano") {
        // Copiar texto
        const textArea = document.getElementById("texto_plano");
        textArea.select();
        textArea.setSelectionRange(0,99999);
        document.execCommand("copy");

        // Cambiar icono del boton para indicar que se copio
        const icono = document.getElementById("icono_copiar_plano");
        const boton = document.getElementById("boton_copiar_plano");
        icono.style.display = "inline-block";
        setTimeout(function() {
            icono.style.display = "none"; // Ocultar
        }, 4000); // miliseg

    } else if(tipo==="cifrado") {
        const textArea = document.getElementById("texto_cifrado");
        textArea.select();
        textArea.setSelectionRange(0,99999);
        document.execCommand("copy");

        // Cambiar icono del boton para indicar que se copio
        const icono = document.getElementById("icono_copiar_cifrado");
        const boton = document.getElementById("boton_copiar_cifrado");
        icono.style.display = "inline-block";
        setTimeout(function() {
            icono.style.display = "none"; // Ocultar
        }, 4000); // miliseg
    }
}
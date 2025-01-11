console.log("Mensaje consola 1");

// Obtener el valor de un elemento definido en el archivo HTML
let subTitulo = document.getElementById("h2-primero"); // se recupera todo el elemento (no solo texto)
console.log(`Valor del elemento h2= ${subTitulo.innerHTML}`);

// Modificar el valor del h1 con un boton
function cambiarTexto() {
    subTitulo.innerHTML = "Nuevo texto del elemento."; // Asignando nuevo valor al elemento
}

// Modificar todos los elementos de un mismo tipo
function cambiarParrafos() {
    let parrafos = document.getElementsByTagName("p");
    for (let i=0; i<parrafos.length; i++) {
        parrafos[i].innerHTML = `Parrafo ${i+1}<br>Nuevo texto de prueba generico para este parrafo.`;
    }

    // tambien se puede recorrer asi
    for(let elemento of parrafos) {
        console.log("Elemento: "+elemento.innerHTML);
    }
}
// Funciones index.html
function sumar() {
    const formulario = document.getElementById("formulario");
    let numero1 = parseFloat(formulario["numero1"].value);
    let numero2 = parseFloat(formulario["numero2"].value);

    if(isNaN(numero1)) {
        alert("El primer numero no es valido.");
        return;
    } else if(isNaN(numero2)) {
        alert("El segundo numero no es valido.");
        return;
    } else {
        resultado = numero1 + numero2;
        let mensaje = `Resultado: <b>${resultado}</b>`;
        document.getElementById("resultado").innerHTML = mensaje;
    }
}

function restar() {
    const formulario = document.getElementById("formulario");
    let numero1 = parseFloat(formulario["numero1"].value);
    let numero2 = parseFloat(formulario["numero2"].value);

    if(isNaN(numero1)) {
        alert("El primer numero no es valido.");
        return;
    } else if(isNaN(numero2)) {
        alert("El segundo numero no es valido.");
        return;
    } else {
        resultado = numero1 - numero2;
        let mensaje = `Resultado: <b>${resultado}</b>`;
        document.getElementById("resultado").innerHTML = mensaje;
    }
}

function dividir() {
    const formulario = document.getElementById("formulario");
    let numero1 = parseFloat(formulario["numero1"].value);
    let numero2 = parseFloat(formulario["numero2"].value);

    if(isNaN(numero1)) {
        alert("El primer numero no es valido.");
        return;
    } else if(isNaN(numero2)) {
        alert("El segundo numero no es valido.");
        return;
    } else {
        resultado = numero1 / numero2;
        let mensaje = `Resultado: <b>${resultado}</b>`;
        document.getElementById("resultado").innerHTML = mensaje;
    }
}




// Funciones listaPersonas.html
const personas = [
    new Persona("DAVID","JUAREZ"),
    new Persona("OSCAR","JIMENEZ")
];

function mostrarPersonas() {
    let listaPersonas = document.getElementById("personas"); // Elemento donde se muestran las personas (<ul>)
    let contenido = "";
    for(per of personas) { // Iterando mi lista de personas (arreglo)
        /*
        // Otra forma
        const nuevoElemento = document.createElement("li");
        nuevoElemento.textContent = `${per.nombre} ${per.apellido}`;
        listaPersonas.appendChild(nuevoElemento);
        */
        
        contenido += `<li>${per.nombre} ${per.apellido}</li>`; // Contenido del <ul>
    }
    listaPersonas.innerHTML = contenido;
}

function agregarPersona() {
    const formulario = document.getElementById("formulario");
    let nombre = formulario["nombre"].value;
    let apellido = formulario["apellido"].value;
    
    if(nombre=="" || nombre==" ") {
        alert("Valor del campo 'Nombre' vacio.");
        return;
    } else if (apellido=="" || nombre==" ") {
        console.log("Valor del campo 'Apellido' vacio.");
        return;
    } else {
        personas.push(new Persona(nombre,apellido)); // Agregar persona al arreglo
        mostrarPersonas();
    }
}

function mayusculas() {
    document.getElementById("nombre").value = document.getElementById("nombre").value.toUpperCase();
    document.getElementById("apellido").value = document.getElementById("apellido").value.toUpperCase();
}


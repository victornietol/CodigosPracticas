const edad = 15;
const nombre = "Javier";
let conteo = 0;

const boton = document.getElementById("boton1");
const botonReinicio = document.getElementById("botonReinicio");
const texto = document.getElementById("textoInicial");

// Mensaje con los datos de las variables nombre y edad
var mensaje = `Nombre: <b>${nombre}</b><br>Edad: <b>${edad}</b>`;
document.getElementById("datos1").innerHTML = mensaje;


// Logica de los botones (sin implementar function)
boton.addEventListener("click", () => {
    texto.textContent = "Boton presionado. Veces presionado = "+(++conteo);
});

botonReinicio.addEventListener("click", () => {
    texto.textContent = "Boton presionado. Veces presionado = "+(conteo=0);
});


// Funciones de los botones (con function)
function sumarNumeros() {
    const numero1 = parseFloat(document.getElementById("numero1").value);
    const numero2 = parseFloat(document.getElementById("numero2").value);
    let resultado;

    if(isNaN(numero1)) {
        alert(`Numero introducido no valido: ${numero1}`);
        return;
    } else if (isNaN(numero2)) {
        alert(`Numero introducido no valido: ${numero2}`);
        return;
    } else {
        resultado = numero1+numero2;
        document.getElementById("resultadoOperacion").textContent = `Resultado = ${resultado}`;
    }
}

function restarNumeros() {
    const numero1 = parseFloat(document.getElementById("numero1").value);
    const numero2 = parseFloat(document.getElementById("numero2").value);
    let resultado;

    if(isNaN(numero1)) {
        alert(`Numero introducido no valido: ${numero1}`);
        return;
    } else if (isNaN(numero2)) {
        alert(`Numero introducido no valido: ${numero2}`);
        return;
    } else {
        resultado = numero1-numero2;
        document.getElementById("resultadoOperacion").textContent = `Resultado = ${resultado}`;
    }
}

function dividirNumeros() {
    const numero1 = parseFloat(document.getElementById("numero1").value);
    const numero2 = parseFloat(document.getElementById("numero2").value);
    let resultado;

    if(isNaN(numero1)) {
        alert(`Numero introducido no valido: ${numero1}`);
        return;
    } else if (isNaN(numero2)) {
        alert(`Numero introducido no valido: ${numero2}`);
        return;
    } else {
        resultado = numero1/numero2;
        document.getElementById("resultadoOperacion").textContent = `Resultado = ${resultado}`;
    }
}

// funcion del tipo expresion
let sumarE = function(a,b) {return a+b};
console.log("Suma="+sumarE(5,3) );

// otra forma
let sumarB = (a,b) => a+b;
console.log("Suma="+sumarB(10,5));


// funcion que se llama a si misma (solo se ejecuta una vez y no se puede mandar a llamar por otra)
(function() { // puede utilizar argumentos, se declaran en function(numero1,numero2)
    console.log("Ejecutando funcion");
}) (); // los argumentos se asignan aqui. Ejemplo (9,9)

console.log(nombre);
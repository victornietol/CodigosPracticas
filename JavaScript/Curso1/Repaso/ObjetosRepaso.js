// Crear Objeto (manera principal)
let persona = {
    nombre : "Juan", // atributos
    apellido : "Perez",
    correo : "perez_j@email.com",
    edad : 22,
    // funcion
    nombreCompleto : function() {
        return this.nombre+" "+this.apellido;
    }
}
console.log(persona.nombreCompleto());
console.log(persona["correo"]); //tambien se puede acceder como si fuera un diccionario en python
for(nombrePropiedad in persona) {
    console.log(nombrePropiedad);
    console.log(persona[nombrePropiedad]);
}

persona.tel = "5533448899";
console.log(persona.tel);

//borrar propiedad
delete persona.tel;

// obtener valor de elementos
let contenidoPersona = Object.values(persona); 
console.log(contenidoPersona);
contenidoPersona.forEach(elemento => {
    console.log(elemento)
});





//Otra forma de objeto
let persona2 = new Object();
persona2.nombre = "Sergio";
persona2.telefono = "5533442299";



class Persona {
    static variable = "Texto de clase";

    // Simular una constante
    static get MAX_NUMERO() {
        return 10;
    }

    constructor(nombre, apellido) {
        this._nombre = nombre,
        this._apellido = apellido
    }

    get nombre() {
        return this._nombre;
    }

    get apellido() {
        return this._apellido;
    }

    set nombre(nombre) {
        this._nombre = nombre;
    }

    set apellido(apellido) {
        this._apellido = apellido;
    }

    nombreCompleto () {
        return this._nombre+" "+this._apellido;
    }
}


// Herencia
class Empleado extends Persona {
    constructor(nombre, apellido, departamento) {
        super(nombre, apellido);
        this._departamento = departamento;
    }

    get departamento() {
        return this._departamento;
    }

    set departamento(departamento) {
        this._departamento = departamento;
    }
}

console.log(Persona.variable);
console.log(Persona.MAX_NUMERO);
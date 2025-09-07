package com.example.spring_patrones_disenio.creational.factory;

public class EmpleadoFactory {

    public Empleado getEmpleado(EmpleadoType type) {
        switch (type) {
            case MECANICO:
                return new Mecanico();
            case PROGRAMADOR:
                return new Programador();
            default:
                throw new IllegalArgumentException("Tipo de emplaedo no existe " + type);
        }
    }
}

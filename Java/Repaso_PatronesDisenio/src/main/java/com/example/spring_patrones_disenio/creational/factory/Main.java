package com.example.spring_patrones_disenio.creational.factory;

public class Main {
    public static void main(String[] args) {

        EmpleadoType[] types = EmpleadoType.values();

        EmpleadoFactory factory = new EmpleadoFactory();

        Empleado prog1 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado prog2 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado prog3 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado mecanico1 = factory.getEmpleado(EmpleadoType.MECANICO);
        Empleado mecanico2 = factory.getEmpleado(EmpleadoType.MECANICO);

    }
}

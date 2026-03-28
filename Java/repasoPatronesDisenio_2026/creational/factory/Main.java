package org.example.estructurasDatos.repasoPatronesDisenio_2026.creational.factory;

public class Main {
    public static void main(String[] args) {

        EmpleadoFactory factory = new EmpleadoFactory();

        Empleado prog1 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado prog2 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado prog3 = factory.getEmpleado(EmpleadoType.PROGRAMADOR);
        Empleado mecanico1 = factory.getEmpleado(EmpleadoType.MECANICO);
        Empleado mecanico2 = factory.getEmpleado(EmpleadoType.MECANICO);
    }
}

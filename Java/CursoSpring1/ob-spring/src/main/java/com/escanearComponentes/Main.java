package com.escanearComponentes;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {
    public static void main(String[] args) {

        // Contenedor de beans
        ApplicationContext context = new ClassPathXmlApplicationContext("beansScan.xml");

        // Ejemplo 1
        // Obtener bean
        Calculator calculadora = (Calculator) context.getBean("calculator");
        String textoPrueba = calculadora.ejemplo();
        System.out.println(textoPrueba);

        // Ejemplo 2, cargar bean dentro de otro bean
        GestorFacturas gestor = (GestorFacturas) context.getBean("gestorFacturas");
        System.out.println(gestor.calculator.ejemplo()+" ejemplo 2");

        /* Dependiendo del scope declarado en el bean se creara solo una vez (singleton)
        o cada vez que se obtenga el bean (prototype). Por defecto se asigna
        scope=singleton */
    }
}

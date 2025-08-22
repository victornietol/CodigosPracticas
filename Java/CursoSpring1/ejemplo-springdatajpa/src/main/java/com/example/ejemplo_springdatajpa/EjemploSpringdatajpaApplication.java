package com.example.ejemplo_springdatajpa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class EjemploSpringdatajpaApplication {

	public static void main(String[] args) {
		// Como se inicia normalmente
		// SpringApplication.run(EjemploSpringdatajpaApplication.class, args);

		// Ejecucion para el ejemplo
		ApplicationContext context = SpringApplication.run(EjemploSpringdatajpaApplication.class, args);
		CarRepository repository = context.getBean(CarRepository.class);
		System.out.println("Num de coches en BD: "+ repository.count());

		// Crear y almacenar un coche en BD
		CarModel toyota = new CarModel(null, "Toyota", "Prius", 2010);
		repository.save(toyota);
		System.out.println("Num de coches en BD: "+ repository.count());

		// Recuperar todos
		System.out.println(repository.findAll());
	}

}

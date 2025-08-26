package com.example.springboot1;

import com.example.springboot1.domain.BookModel;
import com.example.springboot1.repository.BookRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.time.LocalDate;

@SpringBootApplication
public class Springboot1Application {

	public static void main(String[] args) {
		// Solo creando de esta manera para poder ingresar datos de prueba al inicio
		ApplicationContext context = SpringApplication.run(Springboot1Application.class, args);

		BookRepository repository = context.getBean(BookRepository.class);

		BookModel book1 = new BookModel(null, "Titulo 1", "Autor 1", 410, 400.50, LocalDate.of(2018, 9, 10), true);
		BookModel book2 = new BookModel(null, "Titulo 2", "Autor 2", 200, 300.50, LocalDate.of(2019, 11, 10), true);
		BookModel book3 = new BookModel(null, "Titulo 3", "Autor 3", 520, 320.50, LocalDate.of(2019, 11, 10), true);

		repository.save(book1);
		repository.save(book2);
		repository.save(book3);
	}

}

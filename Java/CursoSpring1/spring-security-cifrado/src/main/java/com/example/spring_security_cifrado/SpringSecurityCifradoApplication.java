package com.example.spring_security_cifrado;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class SpringSecurityCifradoApplication {

	// Este bean deberia ir en su clase, pero por practicidad se crea aqui
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	public static void main(String[] args) {

		ApplicationContext context = SpringApplication.run(SpringSecurityCifradoApplication.class, args);
		UserRepository repository = context.getBean(UserRepository.class);

		PasswordEncoder encoder = context.getBean(PasswordEncoder.class);

		UserModel user = new UserModel(null, "admin", encoder.encode("admin"));
		repository.save(user);
	}

}

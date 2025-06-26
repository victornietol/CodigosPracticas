package com.example.ejercicio3.repository;

import com.example.ejercicio3.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Integer> { // Indica la clase (tabla) y su PK
    //Book getBookById(int id);
}

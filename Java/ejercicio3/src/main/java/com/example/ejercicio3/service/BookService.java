package com.example.ejercicio3.service;

import com.example.ejercicio3.model.Book;

import java.util.List;

public interface BookService {

    Book save(Book book);
    Book update(Integer id, Book book);
    List<Book> findAll();
    Book findById(Integer id);
    void delete(Integer id);

    //Book validAndReturn (int id);
}

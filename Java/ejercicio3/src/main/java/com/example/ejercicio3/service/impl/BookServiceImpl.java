package com.example.ejercicio3.service.impl;

import com.example.ejercicio3.model.Book;
import com.example.ejercicio3.model.Category;
import com.example.ejercicio3.repository.BookRepository;
import com.example.ejercicio3.repository.BookRepositoryImpl;
import com.example.ejercicio3.service.BookService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {


    private BookRepository repo;

    // Inyeccion de dependencias por constructor
    public BookServiceImpl(BookRepository repo) {
        this.repo = repo;
    }

    @Override
    public Book save(Book book) {
        return repo.save(book);
    }

    @Override
    public Book update(Integer id, Book book) {
        book.setIdBook(id); // id que se indico en la URL
        return repo.save(book);
    }

    @Override
    public List<Book> findAll() {
        return repo.findAll();
    }

    @Override
    public Book findById(Integer id) {
        return repo.findById(id).orElse(new Book(999,"Defaut", new Category(999,"no category"), false));
    }

    @Override
    public void delete(Integer id) {
        repo.deleteById(id);
    }

    /*
    @Override
    public Book validAndReturn(int id) {
        //repo = new BookRepositoryImpl();
        if(id>0) {
            return repo.getBookById(id);
        } else {
            return new Book(0,"No title", true);
        }
    }
     */
}

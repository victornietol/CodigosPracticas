package com.example.ejercicio3.controller;

import com.example.ejercicio3.model.Book;
import com.example.ejercicio3.service.BookService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.swing.text.html.parser.Entity;
import java.util.List;

@RestController
@RequestMapping("/v1/books")
public class BookController {

    private BookService service;

    // Inyeccion por constructor
    public BookController(BookService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        List<Book> list = service.findAll();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Book> getBook(@PathVariable("id") Integer id) {
        Book book = service.findById(id);
        return ResponseEntity.ok(book);
    }

    @PostMapping
    public ResponseEntity<Book> saveBook(@RequestBody Book book) {
        Book newBook = service.save(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(newBook);
    }

    @PutMapping
    public ResponseEntity<Book> updateBook(@RequestBody Book book) {
        Book newBook = service.save(book);
        return ResponseEntity.ok(newBook);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Book> deleteBook(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    /*
    @GetMapping
    public Book getBook() {
        //service = new BookServiceImpl();
        return service.validAndReturn(1);
    }
     */
}

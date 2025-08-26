package com.example.springboot1.controller;

import com.example.springboot1.domain.BookModel;
import com.example.springboot1.repository.BookRepository;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private BookRepository bookRepository;

    public BookController(BookRepository bookRepository) { // Inyeccion de dependencias
        this.bookRepository = bookRepository;
    }

    @GetMapping
    public List<BookModel> findAll() {
        return bookRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookModel> findOneById(@PathVariable Long id) {
        Optional<BookModel> bookModelOp = bookRepository.findById(id);
        // Opcion 1
        //return bookModelOp.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());

        return bookModelOp.isPresent() ? ResponseEntity.ok(bookModelOp.get())
                                        : ResponseEntity.notFound().build();

        // Opcion 2
        //return bookModelOp.orElse(null);
    }

    @PostMapping
    public ResponseEntity<BookModel> create(@RequestBody BookModel book, @RequestHeader HttpHeaders headers) {
        // Prueba para obtener los headers
        System.out.println(headers.get("User-Agent"));

        BookModel newBook = bookRepository.save(book);
        return newBook.getId()!=null ? ResponseEntity.ok(book) : ResponseEntity.badRequest().build();
    }
}

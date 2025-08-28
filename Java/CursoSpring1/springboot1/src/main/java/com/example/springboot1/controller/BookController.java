package com.example.springboot1.controller;

import com.example.springboot1.ErrorResponse;
import com.example.springboot1.domain.BookModel;
import com.example.springboot1.repository.BookRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.awt.print.Book;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final Logger log = LoggerFactory.getLogger(BookController.class);
    private BookRepository bookRepository;

    public BookController(BookRepository bookRepository) { // Inyeccion de dependencias
        this.bookRepository = bookRepository;
    }

    /**
     * Mostrar todos los libros
     * @return
     */
    @GetMapping
    public List<BookModel> findAll() {
        return bookRepository.findAll();
    }

    /**
     * Encontrar un libro por Id
     * @param id
     * @return
     */
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

    /**
     * Guardar un libro
     * @param book
     * @param headers
     * @return
     */
    @PostMapping
    public ResponseEntity<?> create(@RequestBody BookModel book, @RequestHeader HttpHeaders headers) {
        // Prueba para obtener los headers
        System.out.println(headers.get("User-Agent"));

        if(book.getId()!=null){
            log.warn("Tratando de crear un libro indicando id"); // Crear un log
            ErrorResponse error = new ErrorResponse("El libro ya existe", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        }
        BookModel newBook = bookRepository.save(book);
        return newBook.getId()!=null ? ResponseEntity.status(HttpStatus.CREATED).body(book): ResponseEntity.badRequest().build();
    }

    /**
     * Actualizar un libro existente
     * @param newBook
     * @return
     */
    @PutMapping
    public ResponseEntity<?> update(@RequestBody BookModel newBook) {
        // Toda esta logica deberia ir en una clase aparte con un bean @Service, pero por practicidad del ejemplo se implementa aqui
        ResponseEntity<?> response;
        if(newBook.getId()==null) {
            // Ejemplo de usar DTO para la respuesta de error
            ErrorResponse error = new ErrorResponse("No se envio id", HttpStatus.BAD_REQUEST.value());
            response = ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        } else {
            Optional<BookModel> oldBookOp = bookRepository.findById(newBook.getId());
            if(oldBookOp.isPresent()) {
                BookModel oldBook = oldBookOp.get();
                if(newBook.getTitle()==null){
                    newBook.setTitle(oldBook.getTitle());
                }
                if(newBook.getAuthor()==null) {
                    newBook.setAuthor(oldBook.getAuthor());
                }
                if(newBook.getPages()==null) {
                    newBook.setPages(oldBook.getPages());
                }
                if(newBook.getPrice()==null){
                    newBook.setPrice(oldBook.getPrice());
                }
                if(newBook.getReleaseDate()==null){
                    newBook.setReleaseDate(oldBook.getReleaseDate());
                }
                if(newBook.getOnline()==null) {
                    newBook.setOnline(oldBook.getOnline());
                }
                BookModel saved = bookRepository.save(newBook);
                response = ResponseEntity.ok(saved);
            } else {
                ErrorResponse error = new ErrorResponse("Libro no existente", HttpStatus.NOT_FOUND.value());
                response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
            }
        }
        return response;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id){
         if(bookRepository.existsById(id)) {
             bookRepository.deleteById(id);
             return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
         }
         ErrorResponse error = new ErrorResponse("Libro no existente", HttpStatus.NOT_FOUND.value());
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }
}

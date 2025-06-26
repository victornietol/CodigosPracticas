package com.example.ejercicio3.controller;

import com.example.ejercicio3.model.Category;
import com.example.ejercicio3.service.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/categories")
public class CategoryController {

    private CategoryService service;

    // Inyeccion por constructor
    public CategoryController(CategoryService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Category>> getAllCategorys() {
        List<Category> list = service.findAll();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Category> getCategory(@PathVariable("id") Integer id) {
        Category category = service.findById(id);
        return ResponseEntity.ok(category);
    }

    @PostMapping
    public ResponseEntity<Category> saveCategory(@RequestBody Category category) {
        Category newCategory = service.save(category);
        return ResponseEntity.status(HttpStatus.CREATED).body(newCategory);
    }

    @PutMapping
    public ResponseEntity<Category> updateCategory(@RequestBody Category category) {
        Category newCategory = service.save(category);
        return ResponseEntity.ok(newCategory);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Category> deleteCategory(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

}

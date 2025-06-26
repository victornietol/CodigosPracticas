package com.example.ejercicio3.repository;

import com.example.ejercicio3.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Integer> { // Indica la clase (tabla) y su PK

}

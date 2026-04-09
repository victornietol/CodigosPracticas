package com.example.repaso_SpringBoot_JWT.repository;

import com.example.repaso_SpringBoot_JWT.model.Autor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AutorRepository extends JpaRepository<Autor, Long> {
}

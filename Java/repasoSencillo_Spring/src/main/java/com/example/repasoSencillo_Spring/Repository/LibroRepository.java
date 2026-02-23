package com.example.repasoSencillo_Spring.Repository;

import com.example.repasoSencillo_Spring.Entity.LibroEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LibroRepository extends JpaRepository<LibroEntity, Long> {
}

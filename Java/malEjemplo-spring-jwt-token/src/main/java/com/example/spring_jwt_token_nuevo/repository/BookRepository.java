package com.example.spring_jwt_token_nuevo.repository;

import com.example.spring_jwt_token_nuevo.domain.BookModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<BookModel, Long> {
}

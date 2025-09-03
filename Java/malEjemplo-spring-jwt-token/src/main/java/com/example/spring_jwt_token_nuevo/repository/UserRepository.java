package com.example.spring_jwt_token_nuevo.repository;

import com.example.spring_jwt_token_nuevo.domain.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserModel, Long> {
    UserModel findByUsername(String username);
    boolean existsByUsername(String username);
    void deleteByUsername(String username);
}

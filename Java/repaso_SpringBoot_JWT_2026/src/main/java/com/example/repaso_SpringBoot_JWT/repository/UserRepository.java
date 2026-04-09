package com.example.repaso_SpringBoot_JWT.repository;

import com.example.repaso_SpringBoot_JWT.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    public Optional<User> findByUsername(String username);
}

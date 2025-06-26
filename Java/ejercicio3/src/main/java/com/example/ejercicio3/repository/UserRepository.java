package com.example.ejercicio3.repository;

import com.example.ejercicio3.model.UserInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserInfo, Integer> {
    UserInfo findByUsername(String username);
}

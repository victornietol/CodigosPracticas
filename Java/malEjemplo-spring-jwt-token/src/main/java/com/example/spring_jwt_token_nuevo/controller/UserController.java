package com.example.spring_jwt_token_nuevo.controller;

import com.example.spring_jwt_token_nuevo.domain.UserModel;
import com.example.spring_jwt_token_nuevo.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<?> getUsers() {
        List<UserModel> users = userService.list();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{username}")
    public ResponseEntity<?> getUserByUsername(@RequestParam String username) {
        System.out.println(username);
        UserModel user = userService.findByUsername(username);
        if (user==null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok(user);
    }

    @PutMapping
    public ResponseEntity<?> create(@RequestBody UserModel user) {
        HashMap<String, Object> response = userService.create(user);
        if((boolean) response.get("saved")) {
            UserModel userSaved = (UserModel) response.get("user");
            return ResponseEntity.status(HttpStatus.CREATED).body(userSaved);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response.get("error"));
    }
}

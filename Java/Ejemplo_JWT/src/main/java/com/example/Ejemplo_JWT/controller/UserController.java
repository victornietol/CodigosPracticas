package com.example.Ejemplo_JWT.controller;

import com.example.Ejemplo_JWT.entity.AuthRequest;
import com.example.Ejemplo_JWT.entity.UserInfo;
import com.example.Ejemplo_JWT.service.JwtService;
import com.example.Ejemplo_JWT.service.UserInfoService;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

// Peticiones para verificar credenciales
@RestController
@RequestMapping("/auth")
public class UserController {

    private final UserInfoService service;

    private final JwtService jwtService;

    private final AuthenticationManager authenticationManager;

    public UserController(UserInfoService service, JwtService jwtService, AuthenticationManager authenticationManager) {
        this.service = service;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
    }

    @GetMapping("/welcome")
    public String welcome() {
        return "Endpoint sin autenticacion";
    }

    @GetMapping("/user/userProfile")
    public String userProfile() {
        return "UserProfile";
    }

    @GetMapping("/admin/adminProfile")
    public String adminProfile() {
        return "AdminProfile";
    }

    @GetMapping("/users")
    public ResponseEntity<?> users() {
        return ResponseEntity.ok().body(service.getUsers());
    }

    @PostMapping("/addNewUser")
    public ResponseEntity<?> addNewUser(@RequestBody UserInfo userInfo) {
        return service.addUser(userInfo) ?
                ResponseEntity.status(HttpStatus.CREATED).body("Usuario creado exitosamente") :
                ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error al crear usuario");
    }

    @PostMapping("/generateToken")
    public String authenticateAndGetToken(@RequestBody AuthRequest authRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword())
        );

        if (authentication.isAuthenticated()) {
            return jwtService.generateToken(authRequest.getUsername());
        } else {
            throw new UsernameNotFoundException("Credenciales invalidas.");
        }
    }
}

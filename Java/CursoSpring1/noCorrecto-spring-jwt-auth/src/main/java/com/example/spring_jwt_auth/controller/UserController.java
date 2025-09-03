package com.example.spring_jwt_auth.controller;

import com.example.spring_jwt_auth.model.AuthRequest;
import com.example.spring_jwt_auth.model.UserInfo;
import com.example.spring_jwt_auth.service.JwtService;
import com.example.spring_jwt_auth.service.UserInfoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class UserController {

    private UserInfoService userInfoService;
    private JwtService jwtService;
    private AuthenticationManager authenticationManager;

    @GetMapping("/public")
    public ResponseEntity<?> free() {
        return ResponseEntity.ok("Endopoint publico.");
    }

    @PostMapping("/signin")
    public ResponseEntity<?> signin(@RequestBody UserInfo userInfo) {
        UserInfo newUser = userInfoService.addUser(userInfo);
        return ResponseEntity.status(HttpStatus.CREATED).body(newUser);
    }

    // Autentica y genera un token
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest authRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        authRequest.getUsername(),
                        authRequest.getPassword()
                )
        );

        if(authentication.isAuthenticated()) {
            String token = jwtService.generateToken(authRequest.getUsername()); // Se utiliza el username en lugar del email
            return ResponseEntity.ok(Map.of("token", token));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Credenciales incorrectas."));
        }
    }
}

package com.example.spring_security_cifrado;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;
import org.springframework.security.crypto.scrypt.SCryptPasswordEncoder;

import java.util.HashMap;
import java.util.Map;

public class EncryptionTest {

    /**
     * Genera un salt de 16 bytes
     */
    @Test
    void bcryptTest() {
        String plainPassw = "admin";
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String hashedpassw = passwordEncoder.encode(plainPassw);
        System.out.println(hashedpassw);

        Boolean res = passwordEncoder.matches("admin1", hashedpassw);
        System.out.println(res);
    }

    /**
     * Comparar la crecion de distintos hash con el mismo texto
     */
    @Test
    void bcryptCheckMultiplePasswords() {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        for (int i=0; i<30; i++) {
            System.out.println(passwordEncoder.encode("admin"));
        }
    }

    @Test
    void pbkdf2() {
        Pbkdf2PasswordEncoder passwordEncoder = new Pbkdf2PasswordEncoder(
                "secretPersonal",
                10,
                185000,
                Pbkdf2PasswordEncoder.SecretKeyFactoryAlgorithm.PBKDF2WithHmacSHA256
        );
        for (int i=0; i<30; i++) {
            System.out.println(passwordEncoder.encode("admin"));
            System.out.println();
        }
    }

    @Test
    void argon2() {
        Argon2PasswordEncoder passwordEncoder = new Argon2PasswordEncoder(
                16,
                32,
                1,
                1<<12,
                3
        );
        for (int i=0; i<30; i++) {
            System.out.println(passwordEncoder.encode("admin"));
            System.out.println();
        }
    }

    @Test
    void scrypt() {
        SCryptPasswordEncoder passwordEncoder = new SCryptPasswordEncoder(
            16384,
                8,
                1,
                32,
                16
        );
        for (int i=0; i<30; i++) {
            System.out.println(passwordEncoder.encode("admin"));
            System.out.println();
        }
    }

    @Test
    void springPasswordEncoders() {
        Map<String, PasswordEncoder> encoders = new HashMap<>();
        encoders.put("bcrypt", new BCryptPasswordEncoder());
        encoders.put("argon2", new Argon2PasswordEncoder(
                16,
                32,
                1,
                1<<12,
                3
        ));
        encoders.put("pbkd2", new Pbkdf2PasswordEncoder(
                "secretPersonal",
                10,
                185000,
                Pbkdf2PasswordEncoder.SecretKeyFactoryAlgorithm.PBKDF2WithHmacSHA256
        ));
        encoders.put("scrypt", new SCryptPasswordEncoder(
                16384,
                8,
                1,
                32,
                16
        ));

        PasswordEncoder passwordEncoder = new DelegatingPasswordEncoder("bcrypt", encoders);
        String hashedPassw = passwordEncoder.encode("admin");
        System.out.println(hashedPassw);
    }
}

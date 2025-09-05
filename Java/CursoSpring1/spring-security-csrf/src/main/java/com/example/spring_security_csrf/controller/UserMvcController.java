package com.example.spring_security_csrf.controller;

import com.example.spring_security_csrf.dto.UserDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserMvcController {

    // Obtiene el formulario
    @GetMapping("/")
    public String getForm(Model model) {
        model.addAttribute("user", new UserDTO());
        return "user-form"; // Nombre del template
    }

    // Recibir el formulario con los datos ingresados
    @PostMapping("/users")
    public String save(@ModelAttribute("user") UserDTO user) {
        System.out.println(user);
        return "next";
    }
}

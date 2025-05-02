package cursoSpringBoot.controllers;


import cursoSpringBoot.domain.Customer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class CustomerController {

    // Los datos de la sig lista deben estar en una BD, pero por el momento se asignan aqui como ejemplo
    private List<Customer> customers = new ArrayList<>(Arrays.asList(
            new Customer("javier01", 1, "javier", "123456"),
            new Customer("david010", 2, "david", "passw1"),
            new Customer("eduardo111", 3, "eduardo", "contra"),
            new Customer("omar011p", 4, "omar", "pass1234")
    ));


    // REGRESA LA LISTA DE CLIENTES
    @GetMapping("/clientes")
    public List<Customer> getCustomers() {
        return customers;
    }

    @GetMapping("/clientes/{username}")
    public Customer getCliente(@PathVariable String username) {
        for(Customer c: customers) {
            if(c.getUsername().equalsIgnoreCase(username)) {
                return c;
            }
        }
        return null; // No se debe retornar null, pero  por el momento se deja asi
    }

}

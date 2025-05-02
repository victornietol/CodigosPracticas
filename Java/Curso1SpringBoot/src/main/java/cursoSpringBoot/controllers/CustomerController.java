package cursoSpringBoot.controllers;


import cursoSpringBoot.domain.Customer;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/clientes") // unificacion de rutas, con esta notacion solo se declara una sola vez la ruta (siempre que se declare a nivel de clase)
public class CustomerController {

    // Los datos de la sig lista deben estar en una BD, pero por el momento se asignan aqui como ejemplo
    private List<Customer> customers = new ArrayList<>(Arrays.asList(
            new Customer("javier01", 1, "javier", "123456"),
            new Customer("david010", 2, "david", "passw1"),
            new Customer("eduardo111", 3, "eduardo", "contra"),
            new Customer("omar011p", 4, "omar", "pass1234")
    ));


    // REGRESA LA LISTA DE CLIENTES
    // @GetMapping("/clientes")  --> si no se usa RequestMapping se debe declarar la ruta aqui
    // @GetMapping --> Asi se declara si se usa RequestMapping a nivel de clase
    @RequestMapping(method = RequestMethod.GET) // Asi se declara usando RequestMapping a nivel de metodo
    public List<Customer> getCustomers() {
        return customers;
    }

    // un cliente en especifico
    // @GetMapping("/clientes/{username}") --> si no se usa RequestMapping se debe declarar la ruta aqui
    // @GetMapping("/{username}") // --> RequestMapping a nivel de clase
    @RequestMapping(value = "/{username}", method = RequestMethod.GET) // RequestMapping a nivel de metodo
    public Customer getCliente(@PathVariable String username) {
        for(Customer c: customers) {
            if(c.getUsername().equalsIgnoreCase(username)) {
                return c;
            }
        }
        return null; // No se debe retornar null, pero  por el momento se deja asi
    }

    // permite agregar un nuevo cliente
    // @PostMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PostMapping // --> RequestMapping
    public Customer postCliente(@RequestBody Customer customer) { // recibe valores json y los transforma al objeto objetivo
        customers.add(customer);
        return customer;
    }

    // modificar un objeto completo
    // @PutMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PutMapping // --> RequestMapping
    public Customer putCliente(@RequestBody Customer customer) {
        for(Customer c: customers) {
            if(c.getId() == customer.getId()) {
                c.setNombre(customer.getNombre());
                c.setUsername((customer.getUsername()));
                c.setPassword(customer.getPassword());
                return c;
            }
        }
        return null; // No debe mandarse null, debe manejarse el error
    }

    // eliminar un objeto completo
    // @DeleteMapping("/clientes/{id}") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @DeleteMapping("/{id}")
    public Customer deleteCliente(@PathVariable int id) {
        for (Customer c: customers) {
            if(c.getId()==id) {
                customers.remove(c);
                return c;
            }
        }
        return null; // No debe mandarse null, debe manejarse el error
    }

    // modificar parcialmente un objeto
    // @PatchMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PatchMapping
    public Customer patch(@RequestBody Customer customer) {
        for(Customer c: customers) {
            if(c.getId()==customer.getId()) {
                if (customer.getNombre()!=null) {
                    c.setNombre(customer.getNombre());
                }
                if (customer.getUsername()!=null) {
                    c.setUsername(customer.getUsername());
                }
                if (customer.getPassword()!=null) {
                    c.setPassword(customer.getPassword());
                }
                return c; // Se realizo la operacion
            }
        }
        return null; // No debe mandarse null, debe manejarse el error
    }

}

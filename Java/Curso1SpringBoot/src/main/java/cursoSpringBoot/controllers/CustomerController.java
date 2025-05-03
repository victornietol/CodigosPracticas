package cursoSpringBoot.controllers;


import cursoSpringBoot.domain.Customer;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
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
    public ResponseEntity<List<Customer>> getCustomers() {
        return ResponseEntity.ok(customers);
    }

    // un cliente en especifico
    // @GetMapping("/clientes/{username}") --> si no se usa RequestMapping se debe declarar la ruta aqui
    // @GetMapping("/{username}") // --> RequestMapping a nivel de clase
    @RequestMapping(value = "/{username}", method = RequestMethod.GET) // RequestMapping a nivel de metodo
    public ResponseEntity<?> getCliente(@PathVariable String username) { // <?> indica que la respuesta puede variar entre distintos tipos
        for(Customer c: customers) {
            if(c.getUsername().equalsIgnoreCase(username)) {
                return ResponseEntity.ok(c);
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente no encontrado con username: "+username);
    }

    // permite agregar un nuevo cliente
    // @PostMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PostMapping // --> RequestMapping
    public ResponseEntity<?> postCliente(@RequestBody Customer customer) { // recibe valores json y los transforma al objeto objetivo
        customers.add(customer);

        URI location = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{username}")
                .buildAndExpand(customer.getUsername())
                .toUri(); // URI del recurso, se debe indicar el mismo parametro que el GET para obtener un solo recurso, ademas en builAndExpand debe ir el parametro que se indica en path

        // return ResponseEntity.created(location).body(customer); // --> Asi se regresa tambien el recurso creado, el codigo de estado y la URI
        return ResponseEntity.created(location).build(); // En este caso solo se regresa el codigo de respuesta y la URI
    }

    // modificar un objeto completo
    // @PutMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PutMapping // --> RequestMapping
    public ResponseEntity<?> putCliente(@RequestBody Customer customer) {
        for(Customer c: customers) {
            if(c.getId() == customer.getId()) {
                c.setNombre(customer.getNombre());
                c.setUsername((customer.getUsername()));
                c.setPassword(customer.getPassword());
                return ResponseEntity.noContent().build(); // Codigo http tipo 204
            }
        }
        // return ResponseEntity.notFound().build(); // Lo mismo que la sig linea, pero sin mensaje personalizado
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente no encontrado con id: "+customer.getId());
    }

    // eliminar un objeto completo
    // @DeleteMapping("/clientes/{id}") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCliente(@PathVariable int id) {
        for (Customer c: customers) {
            if(c.getId()==id) {
                customers.remove(c);
                return ResponseEntity.noContent().build();
            }
        }
        return ResponseEntity.notFound().build();
    }

    // modificar parcialmente un objeto
    // @PatchMapping("/clientes") --> si no se usa RequestMapping se debe declarar la ruta aqui
    @PatchMapping
    public ResponseEntity<?> patch(@RequestBody Customer customer) {
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
                return ResponseEntity.ok("Cliente modificado correctamente con id: "+customer.getId()); // Se realizo la operacion
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente no encontrado con id: "+customer.getId());
    }

}

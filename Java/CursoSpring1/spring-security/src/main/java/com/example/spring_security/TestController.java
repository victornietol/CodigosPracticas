package com.example.spring_security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    //@Value("${app.varexample}") // Obtener el valor de una variable establecida en el archivo de configuraciones
    //String message;

    @GetMapping("/test1")
    public String test1() {
        //System.out.println(message);
        return "Test1";
    }

    @GetMapping("/admin/test1")
    public String test1Admin() {
        return "Test1 ADMIN";
    }

    @GetMapping("/public/test1")
    public String test1Public() {
        return "Test1 RUTA PUBLICA";
    }

    @GetMapping("/bootstrap")
    public String bootstrap() {
        return """
                <!doctype html>
                <html lang="en">
                  <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <title>Bootstrap demo</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
                  </head>
                  <body>
                    <h1>Hello, world!</h1>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
                  </body>
                </html>
                
                """;
    }
}

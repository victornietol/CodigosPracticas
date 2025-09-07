package com.example.spring_patrones_disenio.behavioral.template;

public class HtmlHome extends HtmlTemplate {

    @Override
    public String head() {
        return """
                <!doctype html>
                <html lang="en" xmlns:th="http://www.thymeleaf.org">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <title>Document</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
                </head>
                """;
    }

    @Override
    public String body() {
        return """
                <body>
                    <h1>Este es el body</h1>
                    <div class="container text-center">
                        <div class="row">
                            <div class="col-2">
                            </div>
                
                            <div class="col-8">
                                <form method="POST"">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="title"">
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="text" class="form-control" id="email">
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password">
                                    </div>
                                    <button type="submit" class="mt-5 btn btn-success">Guardar</button>
                                </form>
                            </div>
                
                            <div class="col-2">
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
                </body>
                """;
    }
}

package com.example.spring_patrones_disenio.behavioral.template;

public class HtmlAbout extends HtmlTemplate {

    @Override
    public String head() {
        return """
                <!doctype html>
                <html lang="en" xmlns:th="http://www.thymeleaf.org">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <title>Acerca de</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
                </head>
                """;
    }

    @Override
    public String body() {
        return """
                <body>
                    <h1>Este es el body de About</h1>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
                </body>
                """;
    }
}

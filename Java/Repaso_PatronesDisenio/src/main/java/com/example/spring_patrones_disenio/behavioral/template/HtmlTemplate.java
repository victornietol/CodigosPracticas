package com.example.spring_patrones_disenio.behavioral.template;

public abstract class HtmlTemplate {

    public abstract String head();
    public abstract String body();

    public String footer() {
        return """
                <footer>
                    <p>Copyright 2025</p>
                </footer>
                </html>
                """;
    }

    public String render() {
        //return head() + body() + footer();
        return String.format("""
                %s
                %s
                %s
                """, head(), body(), footer());
    }
}

package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.template.example1;

public class Main {
    public static void main(String[] args) {
        HtmlHome home = new HtmlHome();
        System.out.println(home.render());

        HtmlAbout about = new HtmlAbout();
        System.out.println(about.render());
    }
}

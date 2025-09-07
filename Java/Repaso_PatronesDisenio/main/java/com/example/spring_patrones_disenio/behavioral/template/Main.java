package com.example.spring_patrones_disenio.behavioral.template;

public class Main {
    public static void main(String[] args) {

        HtmlHome home = new HtmlHome();
        System.out.println(home.render());

        HtmlAbout about = new HtmlAbout();
        System.out.println(about.render());
    }
}

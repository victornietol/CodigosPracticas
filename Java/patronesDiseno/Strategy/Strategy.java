package org.example.patronesDiseno.Strategy;

public class Strategy {
    public static void main(String[] args) {

        // Sin patron Strategy
        // Esta clase internamente tiene muchos if y es mas confuso
        Commuter commterPlano = new Commuter();
        commterPlano.goToWork("bus");
        commterPlano.goToWork("car");

        // Con patron se divide mejor el comportamiento en la clase BetterCommuter
        BetterCommuter commuterStrategy = new BetterCommuter();
        commuterStrategy.setStrategy(new BusStrategy()); // Se asigna el objeto dinamicamente, y cada clase tiene su implementado su propio comportamiento
        commuterStrategy.goToWork();
        commuterStrategy.setStrategy(new CarStrategy());
        commuterStrategy.goToWork();
    }
}

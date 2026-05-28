package org.example.estructurasDatos.ejercicios.repaso_estructuras;

public class Stack {

    private DoubleLinkedList elements;

    public Stack() {
        elements = new DoubleLinkedList();
    }

    public void push(Object object) {
        elements.addFirst(object);
    }

    public Object pop() {
        return elements.returnHead();
    }

    public void seeElements() {
        elements.seeAll();
    }
}

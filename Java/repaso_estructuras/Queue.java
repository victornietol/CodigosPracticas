package org.example.estructurasDatos.ejercicios.repaso_estructuras;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Queue {

    private DoubleLinkedList elements;

    public Queue() {
        elements = new DoubleLinkedList();
    }

    public void enqueue(Object object) {
        elements.addLast(object);
    }

    public Object dequeue() {
        return elements.returnHead();
    }

    public void peek() {
        elements.seeFirst();
    }

    public void seeElements() {
        elements.seeAll();
    }
}

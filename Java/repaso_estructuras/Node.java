package org.example.estructurasDatos.ejercicios.repaso_estructuras;

public class Node {

    private Object object;
    private Node prev;
    private Node next;

    public Node(Object object, Node prev, Node next) {
        this.prev = prev;
        this.object = object;
        this.next = next;
    }

    public Node getNext() {
        return next;
    }

    public void setNext(Node next) {
        this.next = next;
    }

    public Node getPrev() {
        return prev;
    }

    public void setPrev(Node prev) {
        this.prev = prev;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    @Override
    public String toString() {
        return "Node{" +
                "object=" + object +
                ", prev=" + (prev!=null ? prev.object : "null") +
                ", next=" + (next!=null ? next.object : "null") +
                '}';
    }
}

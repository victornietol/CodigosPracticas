package org.example.estructurasDatos.Nodo;

public class Node<T> {

    private T content;
    private Node<T> next;

    public Node(T content) {
        this.content = content;
    }

    public Node<T> getNext() {
        return next;
    }

    public void setNext(Node<T> next) {
        this.next = next;
    }

    public T getContent() {
        return content;
    }

    public void setContent(T content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Node{" +
                "content=" + content +
                ", next=" + next +
                '}';
    }
}

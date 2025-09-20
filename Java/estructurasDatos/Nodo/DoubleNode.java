package org.example.estructurasDatos.Nodo;

public class DoubleNode<T> {

    private DoubleNode<T> prev;
    private DoubleNode<T> next;
    private T content;


    public DoubleNode(T content) {
        this.content = content;
    }

    public DoubleNode<T> getPrev() {
        return prev;
    }

    public void setPrev(DoubleNode<T> prev) {
        this.prev = prev;
    }

    public DoubleNode<T> getNext() {
        return next;
    }

    public void setNext(DoubleNode<T> next) {
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
        return "DoubleNode{" +
                "prev=" + prev.getContent() +
                ", content=" + content +
                ", next=" + next.getContent() +
                '}';
    }
}

package org.example.estructurasDatos;

import org.example.estructurasDatos.Nodo.Node;

public class SimpleLinkedList<T> implements Insert, Delete {

    private Node<T> head;

    public SimpleLinkedList(T element) {
        this.head = new Node<>(element);
    }


    @Override
    public boolean deleteLast() {
        Node currNode = this.head;
        boolean deleted = false;
        while (!deleted) {
            if(currNode.getNext()==null) {
                break;
            }
            if(currNode.getNext().getNext()==null) {
                currNode.setNext(null);
                deleted = true;
            }
            currNode = currNode.getNext();
        }
        return deleted;
    }

    @Override
    public boolean deleteFirst() {
        if(this.head.getNext()==null){
            this.head = null;
            return true;
        }
        if(this.head.getNext()!=null) {
            this.head = this.head.getNext();
            return true;
        }
        return false;
    }

    @Override
    public boolean deletePosition(int position) {
        if (position==0)
            return deleteFirst();
        if(position>0) {
            Node currNode = this.head;
            for (int i=0; i<=position; i++) {
                if(i+1 == position) {
                    if (currNode.getNext()!=null) {
                        currNode.setNext(currNode.getNext().getNext());
                        return true;
                    } else {
                        return false;
                    }
                }
                currNode = currNode.getNext();
            }
        }
        return false;
    }

    @Override
    public boolean deleteElement(Object element) {
        boolean deleted = false;
        Node currNode = this.head;
        while(!deleted) {

            if (element instanceof Node) { // Si se ingresa un Node
                if (this.head.equals(element)) {
                    this.head = currNode.getNext();
                    deleted = true;
                }
                if (currNode.getNext().equals(element)) {
                    currNode.setNext(currNode.getNext().getNext());
                    deleted = true;
                }
                if (currNode.getNext()==null) {
                    break;
                }

            } else { // Si se ingresa un valor o content del nodo a borrar
                if (currNode.getContent().equals(element)) {// primer elemento
                    this.head = currNode.getNext();
                    deleted = true;
                }
                if (currNode.getNext() != null && currNode.getNext().getContent().equals(element)) {
                    currNode.setNext(currNode.getNext().getNext());
                    deleted = true;
                }
                if (currNode.getNext() == null) { // no se encontró, y no se borró
                    break;
                }
            }

            currNode = currNode.getNext();
        }
        return deleted;
    }

    @Override
    public Object insertFist(Object node) {
        if (node instanceof Node) {
            Node<T> nodeC = (Node<T>) node;
            nodeC.setNext(this.head);
            this.head = nodeC;
            return node;
        } else {
            Node nodeI = new Node<>(node);
            nodeI.setNext(this.head);
            this.head = nodeI;
            return nodeI;
        }
        //return null;
    }

    @Override
    public Object insertLast(Object node) {
        if (node instanceof Node) {
            if(this.head==null){
                this.head = (Node<T>) node;
                return node;
            }

            Node<T> nodeC = (Node<T>) node;
            boolean inserted = false;
            Node currNode = this.head;
            while(!inserted) {
                if(currNode.getNext()==null) {
                    currNode.setNext(nodeC);
                    inserted = true;
                }
                currNode = currNode.getNext();
            }
            return node;

        } else {
            boolean inserted = false;
            Node currNode = this.head;
            while (!inserted) {
                if (currNode.getNext()==null) {
                    currNode.setNext(new Node<>(node));
                    inserted = true;
                }
                currNode = currNode.getNext();
            }
            return node;
        }

        //return null;
    }

    @Override
    public Object insertInPosition(int position, Object node) {
        if (position>=0) {

            Node nodeC = node instanceof Node ? (Node<T>) node : new Node<>(node);

            if (position==0 || this.head==null) {
                insertFist(nodeC);
                return 0;
            }

            Node currNode = this.head;
            for (int i=0; i<=position; i++) {
                if (i+1 == position) {
                    nodeC.setNext(currNode.getNext());
                    currNode.setNext(nodeC);
                    return position;
                }
                if (i!=position && currNode.getNext()==null){
                    currNode.setNext(nodeC);
                    return i+1;
                }

                currNode = currNode.getNext();
            }

        }
        return null;
    }

    @Override
    public String toString() {
        return "SimpleLinkedList{" +
                "head=" + head +
                '}';
    }
}

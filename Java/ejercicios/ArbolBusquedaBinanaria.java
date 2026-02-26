package org.example.estructurasDatos.ejercicios;

public class ArbolBusquedaBinanaria {
    public static void main(String[] args) {
        Node root = new Node(4);
        Node node1 = new Node(2);
        Node node2 = new Node(7);
        Node node3 = new Node(1);
        Node node4 = new Node(3);

        BinarySearchTree bst = new BinarySearchTree(root);
        bst.insert(node1);
        bst.insert(node2);
        bst.insert(node3);
        bst.insert(node4);

        System.out.println(bst);
        System.out.println(bst.search(root, 2));
    }
}

class Node {
    public Integer value;
    public Node left;
    public Node right;

    public Node (Integer value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Node{" +
                "value=" + value +
                ", left=" + left +
                ", right=" + right +
                '}';
    }
}

class BinarySearchTree {
    public Node root;

    public BinarySearchTree(Node root) {
        this.root = root;
    }

    public void insert(Node node) {
        boolean inserted = false;
        Node curr_node = this.root;
        while(!inserted) {
            if (curr_node.value < node.value) {
                if (curr_node.right == null) {
                    curr_node.right = node;
                    inserted=true;
                } else {
                    curr_node = curr_node.right;
                }
            } else {
                if (curr_node.left == null) {
                    curr_node.left = node;
                    inserted =true;
                } else {
                    curr_node = curr_node.left;
                }
            }
        }
    }

    public Node search(Node currNode, Integer value) {
        if (currNode == null) return null;

        if (currNode.value == value) {
            return currNode;
        } else if (currNode.value > value) {
            currNode = search(currNode.left, value);
        } else {
            currNode = search(currNode.right, value);
        }
        return currNode;
    }

    @Override
    public String toString() {
        return "root = " + this.root;
    }
}

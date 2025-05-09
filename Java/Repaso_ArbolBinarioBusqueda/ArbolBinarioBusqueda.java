package org.example;

public class ArbolBinarioBusqueda {
    private Nodo raiz;

    public ArbolBinarioBusqueda() {
    }

    public ArbolBinarioBusqueda(Nodo raiz) {
        this.raiz = raiz;
    }

    public Nodo insertar(Nodo nodoInsertar) {
        if(this.raiz==null) {
            this.raiz = nodoInsertar;
            return this.raiz;
        } else {
            return insertarNodo(this.raiz, nodoInsertar);
        }
    }

    private Nodo insertarNodo(Nodo nodoActual, Nodo nodoInsertar) {
        // Indicar en que lado se intentara insertar
        if(nodoInsertar.getValor() <= nodoActual.getValor()) {
            // Nodo izquierda
            if(nodoActual.getIzq()==null) {
                // Insertar
                nodoActual.setIzq(nodoInsertar);
                return nodoInsertar;
            } else {
                // Visitar el siguiente nodo
                return insertarNodo(nodoActual.getIzq(), nodoInsertar);
            }
        } else {
            // Nodo derecha
            if(nodoActual.getDer()==null) {
                // Insertar
                nodoActual.setDer(nodoInsertar);
                return nodoInsertar;
            } else {
                // Visitar el siguiente nodo
                return insertarNodo(nodoActual.getDer(), nodoInsertar);
            }
        }
    }

    public Nodo buscarNodoPorValor(int nodoValor) {
        return buscarNodo(this.raiz, nodoValor);
    }

    private Nodo buscarNodo(Nodo nodoActual, int nodoValorBuscar) {
        if(nodoActual.getValor()==nodoValorBuscar) {
            return nodoActual; // Regresar nodo
        } else {
            // Determinar lado de la busqueda
            if(nodoValorBuscar < nodoActual.getValor()) {
                // Buscar izquierda
                if(nodoActual.getIzq() != null) {
                    return buscarNodo(nodoActual.getIzq(), nodoValorBuscar); // Seguir buscando
                } else {
                    return null; // No existe el nodo con el valor
                }
            } else {
                // Buscar derecha
                if(nodoActual.getDer() != null) {
                    return buscarNodo(nodoActual.getDer(), nodoValorBuscar); // Seguir buscando
                } else {
                    return null; // No existe el nodo con el valor
                }
            }
        }
    }

    @Override
    public String toString() {
        return "ArbolBinarioBusqueda{" +
                "raiz=" + raiz +
                '}';
    }
}

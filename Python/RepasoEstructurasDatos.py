# LISTAS
class Nodo:
    def __init__(self, valor, sig=None):
        self._valor = valor
        self._sig = sig

    def get_valor(self):
        return self._valor
    
    def set_valor(self, valor):
        self._valor = valor

    def get_sig(self):
        return self._sig
    
    def set_sig(self, sig):
        self._sig = sig

    def __str__(self):
        return f"Nodo [valor={self._valor}, sig={self._sig}]"

class ListaLigada:
    def __init__(self):
        self._nodo_inicial = None
        self._num_elementos = 0
        self._nodo_final = None

    def insertar_inicio(self, nodo: Nodo):
        self._num_elementos += 1
        nodo_inicial_pasado = self._nodo_inicial
        self._nodo_inicial = nodo
        self._nodo_inicial.set_sig(nodo_inicial_pasado)

        # Ajustando el nodo final
        if self._num_elementos == 1:
            self._nodo_final = self._nodo_inicial

    def insertar_final(self, nodo: Nodo):
        # Verificando si hay mas de un elemento
        if self._num_elementos == 0:
            self.insertar_inicio(nodo)
        else:
            self._num_elementos +=1
            self._nodo_final.set_sig(nodo)
            self._nodo_final = nodo

    def insertar_intermedio(self, nodo: Nodo, indice_insercion: int):
        if indice_insercion == 0:
            # Insertar al inicio
            self.insertar_inicio(nodo)
            return 0
        elif indice_insercion == (self._num_elementos):
            # Insertar al final
            self.insertar_final(nodo)
            return indice_insercion
        elif (indice_insercion < 0) or  (indice_insercion > (self._num_elementos-1)):
            # No existe el indice
            return None
        else:
            # Insertar
            self.__index = 1
            def insertar(nodo_anterior: Nodo, nodo_actual: Nodo):
                if self.__index == indice_insercion:
                    # Se inserta al encontrar llegar al indice y se regresa el indice
                    nodo_anterior.set_sig(nodo)
                    nodo.set_sig(nodo_actual)
                    return self.__index
                else:
                    # Seguir buscando
                    self.__index +=1
                    return insertar(nodo_actual, nodo_actual.get_sig())
            return insertar(self._nodo_inicial, self._nodo_inicial.get_sig()) # Inicia la busqueda en el segundo nodo


    def recorrer_lista(self, nodo: Nodo):
        if nodo.get_sig() == None:
            return f"{nodo.get_valor()} -> None"
        else:
            return f"{nodo.get_valor()} -> {self.recorrer_lista(nodo.get_sig())}"
        
    def eliminar_elemento(self, valor_elemento):
        def encontrar(nodo_anterior: Nodo, nodo_actual: Nodo):
            if nodo_actual.get_valor() == valor_elemento: # Se encontro
                # Reajustando lista
                self._num_elementos -=1
                nodo_siguiente = nodo_actual.get_sig() if nodo_actual.get_sig()!=None else None # Determinar si hay nodo siguiente
                if nodo_anterior==None and nodo_siguiente==None:
                    # Es elemento unico
                    self._nodo_inicial = None
                    self._nodo_final = None
                elif nodo_anterior==None:
                    # Si el eliminado es el primer elemento
                    self._nodo_inicial = nodo_siguiente
                elif nodo_siguiente==None:
                    # Si el eliminado es el ultimo elemento
                    nodo_anterior.set_sig(None) # Elimina el nodo actual
                    self._nodo_final = nodo_anterior
                else:
                    # Cualquier otro elemento
                    nodo_anterior.set_sig(nodo_siguiente)
                return nodo_actual # Nodo/elemento que se elimino
            
            elif nodo_actual.get_sig() != None:
                # Seguir buscando
                return encontrar(nodo_actual, nodo_actual.get_sig())
            
            elif nodo_actual.get_sig() == None:
                return None
        
        return encontrar(None, self._nodo_inicial)
    
    def buscar_primer_coincidencia(self, valor_elemento):
        self.__index = 0
        def encontrar(nodo: Nodo):
            if nodo.get_valor() == valor_elemento:
                # Se encontro
                return self.__index
            elif nodo.get_sig() == None:
                # No se encontro el elemento
                return None
            else:
                # Sigue buscando
                self.__index +=1
                return encontrar(nodo.get_sig())
            
        return encontrar(self._nodo_inicial)
    
    def buscar_por_indice(self, indice: int):
        self.__index = 0
        def encontrar(nodo: Nodo):
            if self.__index == indice:
                # Se encontro
                return nodo
            elif nodo.get_sig() == None:
                # No se encontro
                return None
            else:
                # Seguir buscando
                self.__index +=1
                return encontrar(nodo.get_sig())
        return encontrar(self._nodo_inicial)

    def get_nodo_inicial(self) -> Nodo:
        return self._nodo_inicial

    def __str__(self):
        return f"ListaLigada [nodo_inicial={self._nodo_inicial}, nodo_final={self._nodo_final}, elementos={self._num_elementos}]"
    

        

print("Creacion lista y nodos".center(50,"-"))
n1 = Nodo(1)
n2 = Nodo(2)
n3 = Nodo(3)
n4 = Nodo(4)
listaLigada = ListaLigada()
print(listaLigada)
listaLigada.insertar_final(n1)
listaLigada.insertar_final(n2)
listaLigada.insertar_final(n3)
listaLigada.insertar_inicio(n4)

print("Recorrer lista e imprimir objeto".center(50,"-"))
print(listaLigada)
lista_recorrido = listaLigada.recorrer_lista(listaLigada.get_nodo_inicial())
print(lista_recorrido)

print("Eliminar elemento".center(50,"-"))
eliminado = listaLigada.eliminar_elemento(2)
lista_recorrido = listaLigada.recorrer_lista(listaLigada.get_nodo_inicial())
print("Eliminado: ",eliminado)
print(lista_recorrido)
print(listaLigada)

print("Encontrar primer coincidencia".center(50,"-"))
valor_elemento = 3
id = listaLigada.buscar_primer_coincidencia(valor_elemento)
print(f"Indice de elemento {valor_elemento}: {id}")
lista_recorrido = listaLigada.recorrer_lista(listaLigada.get_nodo_inicial())
print(lista_recorrido)

print("Encontrar elemento por indice".center(50,"-"))
indice = 2
elemento = listaLigada.buscar_por_indice(indice)
print(f"Elemento con indice {indice}: {elemento}")
lista_recorrido = listaLigada.recorrer_lista(listaLigada.get_nodo_inicial())
print(lista_recorrido)

print("Insertar intermedio".center(50,"-"))
n5 = Nodo(5)
indice_insertado = listaLigada.insertar_intermedio(n5, 2)
print(f"Elemento insertado en el indice: {indice_insertado}")
lista_recorrido = listaLigada.recorrer_lista(listaLigada.get_nodo_inicial())
print(lista_recorrido)
print(listaLigada)
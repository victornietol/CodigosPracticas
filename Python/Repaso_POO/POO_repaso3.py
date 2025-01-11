class Producto:
    contador_producto = 0

    def __init__(self, nombre: str, precio: float):
        Producto.contador_producto += 1
        self.__id_producto = Producto.contador_producto
        self.__nombre = nombre
        self.__precio = precio

    @property
    def id_producto(self) -> int:
        return self.__id_producto
    
    @property
    def nombre(self) -> int:
        return self.__nombre
    
    @property
    def precio(self) -> int:
        return self.__precio
    
    @precio.setter
    def precio(self, precio: float) -> None:
        if(isinstance(precio, float)):
            self.__precio = precio
        else:
            print("El precio debe ser un valor flotante")

    def __str__(self):
        return f"Producto[id:{self.__id_producto}, nombre:{self.__nombre}, precio:{self.__precio}]"
    


class Orden:
    contador_orden = 0

    def __init__(self, productos: list):
        Orden.contador_orden += 1
        self.__id_orden = Orden.contador_orden
        self.__productos = list(productos) # Verificar que sea una lista

    @property
    def id_orden(self) -> int:
        return self.__id_orden


    def agregar_producto(self, producto):
        self.__productos.append(producto)

    def calcular_total(self):
        total = 0
        for producto in self.__productos:
            total += producto.precio
        return total
    
    def __str__(self):
        productos_str = ""
        for producto in self.__productos:
            productos_str += producto.__str__() + " | "
        return f"Orden:{self.__id_orden}, \nProductos: {productos_str}"
    


if __name__ == "__main__":
    prod1 = Producto("Camisa", 150.00)
    prod2 = Producto("Pantalon", 350.00)
    prod3 = Producto("Playera", 99.00)
    prod4 = Producto("Calcetines", 50.00)

    lista1 = [prod1,prod2,prod3]
    lista2 = [prod2,prod3]

    orden1 = Orden(lista1)
    orden2 = Orden(lista2)

    print(orden2.__str__())
    print(orden2.calcular_total())
    orden2.agregar_producto(prod4)
    print(orden2.__str__())
    print(orden2.calcular_total())
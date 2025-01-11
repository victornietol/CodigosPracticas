class DispositivoEntrada:
    def __init__(self, tipo_entrada: str, marca: str):
        self._tipo_entrada = tipo_entrada
        self._marca = marca

    @property
    def tipo_entrada(self) -> str:
        return self._tipo_entrada
        
    @property
    def marca(self) -> str:
        return self._marca
    
    @tipo_entrada.setter
    def tipo_entrada(self, tipo_entrada: str) -> None:
        if(isinstance(tipo_entrada, str)):
            self._tipo_entrada = tipo_entrada
        else:
            print("No es un valor valido") 

    @marca.setter
    def marca(self, marca: str) -> None:
        if(isinstance(marca, str)):
            self._marca = marca
        else:
            print("No es un valor valido") 

    def __str__(self):
        return f"Dispositivo Entrada [tipo_entrada:{self._tipo_entrada}, marca:{self._marca}]"
    

class Raton(DispositivoEntrada):
    contador_ratones = 0

    def __init__(self, tipo_entrada, marca):
        Raton.contador_ratones += 1
        self.__id_raton = Raton.contador_ratones
        super().__init__(tipo_entrada, marca)

    @property
    def id_raton(self) -> int:
        return self.__id_raton

    def __str__(self):
        return f"Raton [id:{self.__id_raton}, {super().__str__()}]"
    

class Teclado(DispositivoEntrada):
    contador_teclado = 0

    def __init__(self, tipo_entrada, marca):
        Teclado.contador_teclado += 1
        self.__id_teclado = Teclado.contador_teclado
        super().__init__(tipo_entrada, marca)

    @property
    def id_teclado(self) -> int:
        return self.__id_teclado
    
    def __str__(self):
        return f"Teclado[id_teclado:{self.__id_teclado}, {super().__str__()}]"
    

class Monitor:
    contador_monitor = 0

    def __init__(self, marca: str, tamanio: str):
        Monitor.contador_monitor += 1
        self.__id_monitor = Monitor.contador_monitor
        self.__marca = marca
        self.__tamanio = tamanio

    @property
    def id_monitor(self) -> int:
        return self.__id_monitor
    
    @property
    def marca(self) -> str:
        return self.__marca
    
    @property
    def tamanio(self) -> str:
        return self.__tamanio
    
    @marca.setter
    def marca(self, marca):
        if(isinstance(marca, str)):
            self.__marca = marca

        else:
            print("No es un valor valido")

    @tamanio.setter
    def tamanio(self, tamanio):
        if(isinstance(tamanio, str)):
            self.__tamanio = tamanio

        else:
            print("No es un valor valido")     

    def __str__(self):
        return f"Monitor [id:{self.__id_monitor}, marca:{self.__marca}, tamanio:{self.__tamanio}]"
    

class Computadora:
    contador_computadora = 0

    def __init__(self, nombre: str, monitor: Monitor, teclado: Teclado, raton: Raton):
        Computadora.contador_computadora += 1
        self.__id_computadora = Computadora.contador_computadora
        self.__nombre = nombre if isinstance(nombre, str) else print("Nombre no valido")
        self.__monitor = monitor if isinstance(monitor, Monitor) else print("No es un objeto Monitor")
        self.__teclado = teclado if isinstance(teclado, Teclado) else print("No es un objeto Teclado")
        self.__raton = raton if isinstance(raton, Raton) else print("No es un objeto raton")

    @property
    def id_computadora(self) -> int:
        return self.__id_computadora
    
    @property
    def nombre(self) -> str:
        return self.__nombre
    
    @property
    def monitor(self) -> Monitor:
        return self.__monitor
    
    @property
    def teclado(self) -> Teclado:
        return self.__teclado
    
    @property
    def raton(self) -> Raton:
        return self.__raton
    
    @nombre.setter
    def nombre(self, nombre: str):
        if(isinstance(nombre, str)):
            self.__nombre = nombre
        else:
            print("No es un valor valido")

    @monitor.setter
    def monitor(self, monitor: Monitor):
        if(isinstance(monitor, Monitor)):
            self.__monitor = monitor
        else:
            print("No es un valor valido")

    @teclado.setter
    def teclado(self, teclado: Teclado):
        if(isinstance(teclado, Teclado)):
            self.__teclado = teclado
        else:
            print("No es un valor valido")

    @raton.setter
    def raton(self, raton: Raton):
        if(isinstance(raton, Raton)):
            self.__raton = raton
        else:
            print("No es un valor valido")

    def __str__(self) -> str:
        return f"Computadora [id_comp:{self.__id_computadora}, nombre:{self.__nombre}, monitor:{self.__monitor}, teclado:{self.__teclado}, raton:{self.__raton}]"
        

class Orden:
    contador_orden = 0

    def __init__(self, computadoras: list):
        Orden.contador_orden += 1
        self.__id_orden = Orden.contador_orden
        self.__computadoras = list(computadoras)
        
    @property
    def id_orden(self) -> int:
        return self.__id_orden
    
    @property
    def computadoras(self) -> list:
        return self.__computadoras
    
    @computadoras.setter
    def computadoras(self, computadoras: list):
        self.__computadoras = list(computadoras)
    
    def agregar_computadora(self, computadora: Computadora):
        if(isinstance(computadora, Computadora)):
            self.__computadoras.append(computadora)
        else:
            print("Tipo de dato no valido")

    def __str__(self):
        lista_str = f"Orden = id_orden:{self.__id_orden}"
        for computadora in self.__computadoras:
            lista_str += f"\n    {computadora}"
        return lista_str



if __name__ == "__main__":
    raton1 = Raton("USB","Logitech")
    raton2 = Raton("Bluetooth","Razer")
    teclado1 = Teclado("USB", "Razer")
    teclado2 = Teclado("USB", "HyperX")
    monitor1 = Monitor("Rogue", "24 pulgadas")
    monitor2 = Monitor("Asus", "24 pulgadas")
    computadora1 = Computadora("Comp1",monitor1,teclado1,raton1)
    computadora2 = Computadora("Comp2",monitor2,teclado2,raton2)
    lista1 = [computadora1, computadora2]
    orden1 = Orden(lista1)

    print(orden1)
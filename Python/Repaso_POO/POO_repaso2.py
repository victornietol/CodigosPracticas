''''HERENCIA MULTIPLE y CLASE ABSTRACTA'''

from abc import ABC, abstractmethod


class FigGeometrica(ABC): # Clase abstracta (no se puede instanciar)
    def __init__(self, alto:float, ancho:float) -> None:
        self.__alto = alto
        self.__ancho = ancho

    @property
    def alto(self) -> float:
        return self.__alto
    
    @property
    def ancho(self) -> float:
        return self.__ancho
    
    @alto.setter
    def alto(self, alto) -> None:
        if(isinstance(alto, float)):
            self.__alto = alto
        else:
            print("El alto debe ser un float")

    @ancho.setter
    def ancho(self, ancho) -> None:
        if(isinstance(ancho, float)):
            self.__ancho = ancho
        else:
            print("El ancho debe ser un float")

    @abstractmethod
    def calcular_area(self):  # Indicando el metodo abstracto, los hijos de esta clase deben implementar este metodo aiempre
        pass

    def __str__(self) -> str:
        return f"alto: {self.__alto}, ancho: {self.__ancho}"
    

class Color:
    def __init__(self, color:str) -> None:
        self.__color = color

    @property
    def color(self):
        return self.__color
    
    @color.setter
    def color(self, color:str) -> str:
        if(isinstance(color, str)):
            self.__color = color
        else:
            print("El color debe ser un string")

    def __str__(self) -> str:
        return f"{self.__color}"
    

# CLASE QUE HEREDA DE LAS DOS ANTERIOES
class Cuadrado(FigGeometrica, Color):
    def __init__(self, lado:float, color: str) -> None:
        FigGeometrica.__init__(self, lado, lado) # Inicializando atributos de los padres
        Color.__init__(self, color)


    def calcular_area(self):
        return self.alto * self.ancho # Utilizando los atributos de la clase padre
    
    def __str__(self) -> str:
        return f"FigGeomtrica[{FigGeometrica.__str__(self)}], Color[{Color.__str__(self)}]"
    



cuadrado1 = Cuadrado(10.0, "rojo")
print(cuadrado1)
print(cuadrado1.calcular_area())

# Ver en que orden se llaman las clases y subclases (MRO)
#print(Cuadrado.mro())
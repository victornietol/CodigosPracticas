class Persona:
    def __init__(self, nombre, edad):
        self.__nombre = nombre
        self.__edad = edad

    @property
    def edad(self) -> int:
        return self.__edad
    
    @property
    def nombre(self) -> str:
        return self.__nombre

    def __add__(self, other):
        return self.__edad + other.edad
    
    def __sub__(self, other):
        return self.__edad - other.edad
    

if __name__ == "__main__":
    pers1 = Persona("Carlos", 20)
    pers2 = Persona("Oliver", 15)
    print(pers1+pers2)
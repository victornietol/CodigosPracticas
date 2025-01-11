class Persona:
    variable_clase = "Humano" # Variable de clase
    contador_personas = 0 # Conteo de cuantos objetos de esta clase se han creado

    @classmethod
    def __aumentar_id(cls) -> int:
        cls.contador_personas += 1 # Modificar el valor de la variable de clase
        return cls.contador_personas

    def __init__(self, nombre: str, apellido: str, edad: int) -> None:
        # Persona.contador_personas += 1 
        self.__id_persona = Persona.__aumentar_id()
        self.__nombre = nombre
        self.__apellido = apellido
        self.__edad = edad

    @property
    def nombre(self) -> str:
        return self.__nombre
    
    @property
    def apellido(self) -> str:
        return self.__apellido
    
    @property
    def edad(self) -> int:
        return self.__edad

    @property
    def id_persona(self) -> int:
        return self.__id_persona
    
    @nombre.setter
    def nombre(self, nombre: str) -> None:
        if(isinstance(nombre, str)):
            self.__nombre = nombre
        else:
            print("Nombre debe ser un string")

    @apellido.setter
    def apellido(self, apellido: str) -> None:
        if(isinstance(apellido, str)):
            self.__apellido = apellido
        else:
            print("Apellido debe ser un string")

    @edad.setter
    def edad(self, edad: str) -> None:
        if(isinstance(edad, int)):
            self.__edad = edad
        else:
            print("Edad debe ser un numero entero")

    # Metodo estatico (se asocia con la clase misma, no puede acceder a las variables de instancia), no se le pasa referencia
    @staticmethod
    def metodo_estatico():
        print(Persona.variable_clase) # Accediendo a la variable de clase

    # Metodo de clase (si puede acceder a valores de la clase con "cls" como cuando se usa "self" para instancia), se le pasa referencia
    @classmethod
    def metodo_clase(cls):
        print(cls.variable_clase)

    # Metodo de instancia, puede acceder al contexto estatico y de clase
    def metodo_instancia(self):
        self.metodo_estatico()
        self.metodo_clase()

    def mostrar_atributos(self) -> str:
        print(f"Nombre: {self.__nombre}, Apellido: {self.__apellido}, Edad: {self.__edad}")

    # Sobreescribir el metodo str para mostrar los valores el objeto, se manda a llamar solo imprimendo el objeto -> print(persona1)
    def __str__(self) -> str:
        return f"Nombre: {self.__nombre}, Apellido: {self.__apellido}, Edad: {self.__edad}"


class Empleado(Persona):
    def __init__(self, nombre: str, apellido: str, edad: int, sueldo: float) -> None:
        super().__init__(nombre, apellido, edad) # Llamando al constructor de la clase padre
        self.__sueldo = sueldo

    @property
    def sueldo(self) -> float:
        return self.__sueldo
    
    @sueldo.setter
    def sueldo(self, sueldo) -> None:
        if isinstance(sueldo, float):
            self.__sueldo = sueldo
        else:
            print("El sueldo debe ser con punto decimal")

    def mostrar_atributos(self) -> str:
        print(f"Nombre: {self.nombre}, Apellido: {self.apellido}, Edad: {self.edad}, Sueldo: {self.__sueldo}") # Los primeros 3 vienen de la clase padre

    # Sobreescribir el metodo str para mostrar los valores el objeto, se manda a llamar solo imprimendo el objeto -> print(empleado1)
    def __str__(self) -> str:
        return f"{super().__str__()}, Sueldo: {self.__sueldo}" # Devulve el __str__ de la clase padre y el actual

'''
A los metodos de clase se puede acceder sin crear instancia de la clase, mientras que los
metodos de instancia necesitan crear primero una instancia para poder utilizarlos.
'''

if __name__ == "__main__":
    print("Persona".center(50,"-"))
    persona1 = Persona("David", "Juarez", 20)
    persona1.mostrar_atributos()
    persona1.nombre = "Javier"
    persona1.edad = 22
    persona1.mostrar_atributos()
    print(persona1)
    nom = persona1.nombre
    print(nom)

    print(" Variable de clase, metodo de instancia y metodo de clase ".center(52,"#"))
    print(Persona.variable_clase)
    Persona.metodo_estatico() # persona1.metodo_estatico()
    Persona.metodo_clase() # Automaticamente python pasa la referencia de clase | persona1.metodo_clase()
    

   

    # Herencia
    print("Herencia".center(50,"-"))
    empleado1 = Empleado("Eduardo", "Cruz", 30, 22.50)
    empleado1.mostrar_atributos()
    print(f"{empleado1.nombre}, {empleado1.sueldo}")
    print(empleado1)



    # Creando mas objetos persona para ver el conteo de objetos
    print("Conteo objetos clase".center(50,"-"))
    pers2 = Persona("Esteban", "Guttierrez", 21)
    pers3 = Persona("Juan", "Osorio", 19)
    pers4 = Persona("Jose", "Islas", 30)
    print(Persona.contador_personas)
    print(empleado1.id_persona)
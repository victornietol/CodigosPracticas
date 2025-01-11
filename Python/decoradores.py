def funcion_decorador_a(funcion_a_decorar_b):
    def funcion_decorada_c(*args, **kwargs):
        print("Antes desde la funcion_decorada_c")
        res = funcion_a_decorar_b(*args, **kwargs)
        print("Despues desde la funcion decorada c")
        return res

    return funcion_decorada_c # Devuelve la funcion decorada (no la ejecucion de la funcion)

# Ejemplo practico
def validar_numero(funcion):
    def decorador(*args):
        if all(isinstance(numero, (int, float)) for numero in args): # Si solo son numeros 
            return funcion(*args)
        else:
            raise TypeError("Valor invalido, todos los valores deben ser numeros.")
    return decorador
    
        

@validar_numero
def sumar(*args):
    return sum(args)


try:
    resultado = sumar(10,20,4, 6)
    print(resultado)
except Exception as e:
    print(f"Error: {e}")
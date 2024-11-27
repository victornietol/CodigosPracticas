from unidecode import unidecode

def __cifrar_mensaje(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z']
    puntuacion = ['.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_cifrado = ""
    mensaje = mensaje.lower()
    mensaje_ = mensaje.replace("ñ","#") # Evitando que elimine ñ
    mensaje = unidecode(mensaje_) # Quitando acentos
    mensaje = mensaje.replace("#","ñ") # Regresando ñ

    if(llave > 0): # Identificar el sentido del recorrido de caracteres
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_cifrado += " "
            elif(caracter in puntuacion): # Si es un signo de puntuacion no se modifica
                mensaje_cifrado += caracter
            else:
                indice_cifrado = alfabeto.index(caracter)+llave
                if(indice_cifrado >= (len(alfabeto)-1)): # Si al aplicar la llave el nuevo indice sobrepasa la ultima posicion del alfabeto se regresa a las primeras posiciones
                    indice_cifrado = indice_cifrado - (len(alfabeto)) # Ajuste de la llave
                    mensaje_cifrado += alfabeto[indice_cifrado]
                else:
                    mensaje_cifrado += alfabeto[indice_cifrado]

    elif(llave < 0):
        # Recorriendo mensaje a la derecha para cifrarlo
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_cifrado += " "
            elif(caracter in puntuacion): # Si es un signo de puntuacion no se modifica
                mensaje_cifrado += caracter
            else:
                indice_cifrado = alfabeto.index(caracter)+(llave)
                # Si al aplicar la llave el indice es negativo se hace slicing hacia atras, por lo tanto no es necesario ajustar el indice
                mensaje_cifrado += alfabeto[indice_cifrado]

    else:
        print("Llave invalida")

    return mensaje_cifrado


def __descifrar_mensaje(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z']
    puntuacion = ['.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_descifrado = ""
    mensaje = mensaje.lower()
    mensaje_ = mensaje.replace("ñ","1") # Evitando que elimine ñ
    mensaje = unidecode(mensaje_) # Quitando acentos
    mensaje = mensaje.replace("1","ñ") # Regresando ñ

    if(llave > 0): # Identificar el sentido del recorrido de caracteres
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_descifrado += " "
            elif(caracter in puntuacion): # Si es un signo de puntuacion no se modifica
                mensaje_descifrado += caracter
            else:
                indice_cifrado = alfabeto.index(caracter)-llave
                # Si al aplicar la llave el indice es negativo se hace slicing hacia atras, por lo tanto no es necesario ajustar el indice
                mensaje_descifrado += alfabeto[indice_cifrado]

    elif(llave < 0):
        # Recorriendo mensaje a la derecha para cifrarlo
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_descifrado += " "
            elif(caracter in puntuacion): # Si es un signo de puntuacion no se modifica
                mensaje_descifrado += caracter
            else:
                indice_cifrado = alfabeto.index(caracter)+llave
                if(indice_cifrado >= (len(alfabeto)-1)): # Si al aplicar la llave el nuevo indice sobrepasa la ultima posicion del alfabeto se regresa a las primeras posiciones
                    indice_cifrado = indice_cifrado - (len(alfabeto)) # Ajuste de la llave
                    mensaje_descifrado += alfabeto[indice_cifrado]
                else:
                    mensaje_descifrado += alfabeto[indice_cifrado]

    else:
        print("Llave invalida")

    return mensaje_descifrado




def cifrar_mensaje1(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z',
                '0','1','2','3','4','5','6','7','8','9',
                '.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_cifrado = ""
    mensaje = mensaje.lower()
    mensaje = quitar_acentos_conservar_signos(mensaje) # Quitar acentos y conservar signos

    if(llave > 0): # Identificar el sentido del recorrido de caracteres
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_cifrado += " "
            else:
                indice_cifrado = alfabeto.index(caracter)+llave
                if(indice_cifrado >= (len(alfabeto)-1)): # Si al aplicar la llave el nuevo indice sobrepasa la ultima posicion del alfabeto se regresa a las primeras posiciones
                    indice_cifrado = indice_cifrado - (len(alfabeto)) # Ajuste de la llave
                    mensaje_cifrado += alfabeto[indice_cifrado]
                else:
                    mensaje_cifrado += alfabeto[indice_cifrado]

    elif(llave < 0):
        # Recorriendo mensaje a la derecha para cifrarlo
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_cifrado += " "
            else:
                indice_cifrado = alfabeto.index(caracter)+(llave)
                # Si al aplicar la llave el indice es negativo se hace slicing hacia atras, por lo tanto no es necesario ajustar el indice
                mensaje_cifrado += alfabeto[indice_cifrado]

    else:
        print("Llave invalida")

    return mensaje_cifrado


def descifrar_mensaje1(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z',
                '0','1','2','3','4','5','6','7','8','9',
                '.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_descifrado = ""
    mensaje = mensaje.lower()
    mensaje = quitar_acentos_conservar_signos(mensaje) # Quitar acentos y conservar signos

    if(llave > 0): # Identificar el sentido del recorrido de caracteres
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_descifrado += " "
            else:
                indice_cifrado = alfabeto.index(caracter)-llave
                # Si al aplicar la llave el indice es negativo se hace slicing hacia atras, por lo tanto no es necesario ajustar el indice
                mensaje_descifrado += alfabeto[indice_cifrado]

    elif(llave < 0):
        # Recorriendo mensaje a la derecha para cifrarlo
        for caracter in mensaje:
            if(caracter == " "): # Si tiene espacio en blanco se mantiene
                mensaje_descifrado += " "
            else:
                indice_cifrado = alfabeto.index(caracter)-llave
                if(indice_cifrado >= (len(alfabeto)-1)): # Si al aplicar la llave el nuevo indice sobrepasa la ultima posicion del alfabeto se regresa a las primeras posiciones
                    indice_cifrado = indice_cifrado - (len(alfabeto)) # Ajuste de la llave
                    mensaje_descifrado += alfabeto[indice_cifrado]
                else:
                    mensaje_descifrado += alfabeto[indice_cifrado]

    else:
        print("Llave invalida")

    return mensaje_descifrado




def quitar_acentos_conservar_signos(texto):
    mensaje_ = texto.replace("ñ","#") # Evitando que elimine ñ
    texto = mensaje_.replace("¡","$") # Evitando que elimine ¡
    mensaje_ = texto.replace("¿","&") # Evitando que elimne ¿

    texto = unidecode(mensaje_) # Quitando acentos

    mensaje_ = texto.replace("#","ñ") # Regresando ñ
    texto = mensaje_.replace("$","¡") # Regresando ¡
    mensaje_ = texto.replace("&","¿") # Regresando ¿

    return mensaje_



def leer_archivo(ruta: str):
    try:
        with open(ruta, 'r', encoding='utf-8') as archivo:
            texto = archivo.read()
        return texto
    except Exception as e:
        print(f"Ocurrio el error: {e}")


def escribir_archivo(texto: str, ruta: str):
    try:
        with open(ruta, 'w', encoding='utf-8') as archivo:
            archivo.write(texto)
    except Exception as e:
        print(f"Ocurrio el problema: {e}")



# Aplicando aritmetica modular
def cifrar_mensaje(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z',
                '0','1','2','3','4','5','6','7','8','9',
                '.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_cifrado = ""
    mensaje = mensaje.lower()
    mensaje = quitar_acentos_conservar_signos(mensaje) # Quitar acentos y conservar signos
    
    for caracter in mensaje:
        if(caracter == " "):
            mensaje_cifrado += " "
        elif(caracter == "\n"):
            mensaje_cifrado += "\n"
        else:
            indice_cifrado = (alfabeto.index(caracter) + llave) % (len(alfabeto)) # (indice_caracter + llave) mod (longitud del alfabeto) -> aplicando aritmetica modular
            mensaje_cifrado += alfabeto[indice_cifrado]

    return mensaje_cifrado


def descifrar_mensaje(mensaje: str, llave: int):
    alfabeto = ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                'n','ñ','o','p','q','r','s','t','u','v','w','x','y','z',
                '0','1','2','3','4','5','6','7','8','9',
                '.',',',';',':','?','¿','!','¡','(',')','-','_']
    mensaje_descifrado = ""
    mensaje = mensaje.lower()
    mensaje = quitar_acentos_conservar_signos(mensaje) # Quitar acentos y conservar signos
    
    for caracter in mensaje:
        if(caracter == " "):
            mensaje_descifrado += " "
        elif(caracter == "\n"):
            mensaje_descifrado += "\n"
        else:
            indice_cifrado = (alfabeto.index(caracter) - llave) % (len(alfabeto)) # (indice_caracter + llave) mod (longitud del alfabeto) -> aplicando aritmetica modular
            mensaje_descifrado += alfabeto[indice_cifrado]

    return mensaje_descifrado



if __name__ == "__main__":
    '''
    mensaje = input("Ingresa el mensaje a cifrar: ")
    llave = int(input("Ingresa la llave: "))

    print(f"Mensaje plano: {mensaje}")

    mensaje_cifrado = cifrar_mensaje(mensaje, llave)
    print(f"Mensaje cifrado: {mensaje_cifrado}")

    mensaje_descifrafo = descifrar_mensaje(mensaje_cifrado, llave)
    print(f"Mensaje descifrado: {mensaje_descifrafo}")
    '''

    # Prueba con archivo mas grande
    # Leyendo archivo con texto plano
    texto_plano = leer_archivo("C:/Victor/CodigosGenerales/Python/texto_plano.txt")
    llave = 3
    
    # Cifrando mensaje y guardandolo en otro archivo
    texto_cifrado = cifrar_mensaje(texto_plano, llave)
    escribir_archivo(texto_cifrado, "C:/Victor/CodigosGenerales/Python/texto_cifrado.txt")

    # Descifrando el mensaje del archivo
    texto_cifrado = leer_archivo("C:/Victor/CodigosGenerales/Python/texto_cifrado.txt")
    texto_descifrado = descifrar_mensaje(texto_cifrado, llave)

    # Guardar texto descifrado en otro archivo
    escribir_archivo(texto_descifrado, "C:/Victor/CodigosGenerales/Python/texto_descifrado.txt")
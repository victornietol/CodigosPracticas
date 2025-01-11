# Ejercicio 1
def fizz_buzz():
    for num in range(1,101):
        if(num % 3 == 0):
            print("fizz")

        elif(num % 5 == 0):
            print("buzz")

        elif((num % 3 == 0) and (num % 5 == 0)):
            print("fizzbuzz")

        else:
            print(num)

# Ejercicio 2
def anagrama1(word1: str, word2: str) -> bool:
    word1, word2 = word1.lower(), word2.lower()
    if((word1 == word2) or (len(word1) != len(word2))):
        return False
    else:
        letras1 = list(word2) # se convierte en una lista
        for character in word1:
            if(character in letras1):
                letras1.remove(character)
        if(len(letras1) == 0):
            return True # Tiene las misma letras
        else:
            return False # Contiene elemetos, es decir, la palabra es diferente

def anagrama2(word1: str, word2: str):
    if((word1==word2) or (len(word1) != len(word2))):
        return False
    else:
        # Pasando a minusculas, reacomodando la palabra en orden y concatenando la lista resultante en un string 
        word1, word2 = ''.join(sorted(word1.lower())), ''.join(sorted(word2.lower()))
        return word1 == word2
    


# Ejercicio 3
# Serie de fibonacci con recursion (muy lento para numeros grandes)
def fibonacci(num: int):
    if(num < 2 ):
        return num
    else:
        return fibonacci(num-1) + fibonacci(num-2)
def serie_fibonacci(cuantos_numeros: int):
    serie = [fibonacci(num) for num in range(cuantos_numeros)] # aplicando list comprehension
    return serie

# Serie de fibonacci sin recursividad (mas rapido)
def serie_fibonacci2(cuantos_numeros: int):
    serie = [0,1]
    for num in range(2, cuantos_numeros):
        serie.append(serie[-1] + serie[-2]) # Calcular y agregar el siguiente numero con los dos ultimos
    return serie


# Ejercicio 4
def es_primo(n: int) -> bool:
    if (n <= 1):
        return False
    if (n == 2):
        return True
    if (n % 2 == 0):
        return False
    for i in range(3, int(n**0.5) + 1, 2): # Se divide el numero entre todos los numeros impares desde 3 hasta la raiz cuadrada del numero y si el resultado es diferente de 0, entonces es primo
        if n % i == 0:
            return False
    return True
def numeros_primos(start: int, end: int):
    primos = []
    for num in range(start, end):
        if(es_primo(num)):
            primos.append(num)
    return primos


# Ejercicio 5
def area(poligono: str, *lados: float) -> float:
    if(poligono=="triangulo"):
        if(len(lados)==2):
            return (lados[0]*lados[1])/2
        else:
            raise ValueError("Numero de lados incorrecto para el triangulo. Solo requiere base y altura")
    elif(poligono=="cuadrado"):
        if(len(lados)==1):
            return lados[0]**2
        else:
            raise ValueError("Numero de lados incorrecto para el cuadrado. Solo se requiere un lado")
    elif(poligono=="rectangulo"):
        if(len(lados)==2):
            return lados[0]*lados[1]
        else:
            raise ValueError("Numero de lados incorrecto para el rectangulo. Se requiere alto y ancho")
    else:
        raise ValueError("Poligono no soportado")
    

# Ejercicio 6
import math, requests
from PIL import Image
from io import BytesIO
def ratio_aspect(url: str):
    # Obtener imagen
    respuesta = requests.get(url)

    if(respuesta.status_code == 200):
        # Cargar imagen
        imagen = Image.open(BytesIO(respuesta.content))
        imagen.show()

        # Obtener dimensiones
        ancho, altura = imagen.size
        factor_comun = math.gcd(ancho, altura)
        ratio_ancho = ancho // factor_comun
        ratio_altura = altura // factor_comun
        return f"{ratio_ancho}:{ratio_altura}"



# Ejercicio 7
def invertir_cadena(cadena: str) -> str:
    cadena_invertida = ""
    for i in range(len(cadena)-1,-1,-1):
        cadena_invertida += cadena[i]
    return cadena_invertida


# Ejercicio 8 Sin usar split()
def contar_palabras(frase: str):
    frase = frase.lower()
    palabras = {}
    palabra = ""
    puntuacion = ["?", "¿", "¡", "!", ".", ",", "(", ")", "\n"]
    conteo_letras = 0

    for letra in frase:
        conteo_letras+=1
        if(letra in puntuacion):
            continue # Ignora signos
        elif(letra == " "): # Final de la palabra
            if(palabra): # Si no esta vacia se agrega
                if(palabra not in palabras):
                    palabras[palabra] = 1 # La palabra no existe aun
                else:
                    palabras[palabra] += 1 # La palabra ya existe
                palabra = "" # Se limpia la palabra
        else:
            palabra += letra  # Se sigue construyendo la palabra

    if(palabra): # Agregando ultima palabra si no termina en espacio
        if(palabra not in palabras):
            palabras[palabra] = 1 # La palabra no existe aun
        else:
            palabras[palabra] += 1 # La palabra ya existe

    for llave, valor in palabras.items():
        print(f"{llave}: {valor}")

'''
        else:
            if(letra==" " or letra=="." or letra=="," or letra=="\n"): # Si ya se completo la palabra
                if(palabras.get(palabra)==None): # La palabra no se a agregado
                    palabras[palabra] = 1
                else:   # La palabra ya existe
                    palabras[palabra] += 1
                palabra="" # Se limpia la palabra porque ya se construyo
            else: # Si aun no se completa la palabra
                palabra += letra # se sigue constuyendo la palabra
                if(conteo_letras==len(frase)): # cuando se llega al final de la frase
                    if(palabras.get(palabra)==None): # La palabra no se a agregado
                        palabras[palabra] = 1
                    else:   # La palabra ya existe
                        palabras[palabra] += 1
'''               

# Ejericio 8 usando spiit           
def contar_palabras2(frase: str):
    frase = frase.lower()
    frase = frase.split(" ")
    palabras = {}
    puntuacion = ["?", "¿", "¡", "!", ".", ",", "(", ")", "\n"]

    for palabra in frase: 
        palabra = "".join(
            [letra for letra in palabra if letra not in puntuacion]
        ) # Eliminando puntuacoines
        if(palabra not in palabras):
            palabras[palabra] = 1
        else:
            palabras[palabra] += 1

    for llave, valor in palabras.items():
        print(f"{llave}: {valor}")



# Ejercicio 9
def decimal_binario(numero: int) -> str:
    divisor = 2 # Base
    dividendo = numero
    residuo = int
    binario = ""

    if(numero==0):
        return "0"

    while(dividendo != 0):
        residuo = dividendo % divisor # Obtengo el bit
        binario = str(residuo) + binario # Lo agrego a mi numero binario al inicio de la cadena
        # Actualizar dividendo para obtener el siguiente bit
        dividendo = dividendo // divisor # Solo guardo el entero
    
    # Inviertiendo mi numero binario para colocarlo correctamente (solo se haria si no agrego el residuo al inicio de la cdena "binario")
    #binario = binario[-1::-1]

    return binario



# Ejercicio 10
import re
def codigo_morse(texto: str) -> str:
    # 1 espacio entre letras
    # 2 espacios entre palabras
    diccionario = {
        'a': '.-', 'b': '-...', 'c': '-.-.', 'd': '-..', 'e': '.', 'f': '..-.',
        'g': '--.', 'h': '....', 'i': '..', 'j': '.---', 'k': '-.-', 'l': '.-..',
        'm': '--', 'n': '-.', 'o': '---', 'p': '.--.', 'q': '--.-', 'r': '.-.',
        's': '...', 't': '-', 'u': '..-', 'v': '...-', 'w': '.--', 'x': '-..-',
        'y': '-.--', 'z': '--..', '1': '.----', '2': '..---', '3': '...--', 
        '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
        '9': '----.', '0': '-----'
    }
    traduccion = ""
    regex = r"^[a-z0-9\s]+$" # Caracteres permitidos
    
    # Es codigo morse
    if(texto[0] == "." or texto[0] == "-"): 
        diccionario = {value: key for key, value in diccionario.items()} # Invertir diccionario para poder pasar de morse a texto
        lista_palabras = texto.split("  ") # Identificar palabras (separacion de dos espacios vacios)
        for palabra in lista_palabras:
            lista_letras = palabra.split(" ") # Identificar letras (un espacio vacio)
            for letra in lista_letras:
                traduccion += diccionario.get(letra, "") # Si no coincide se ignora la parte de codigo introducido
            traduccion += " " # Separando palabras con espacio en blanco
        return traduccion
    
    # Es texto
    elif(re.match(regex, texto)): # Verificar que el texto solo contenga los caracteres permitidos para la traduccion a codigo morse
        texto = texto.lower()
        for letra in texto:
            if(letra == " "): # Espacio en blanco (se completo la palabra), se separa esa parte del codigo morse de otra palabra
                traduccion += "  "
            elif(letra== "\n"):
                traduccion += "\n"
            else:
                traduccion = traduccion + diccionario.get(letra, "") + " " # En caso de introducir codigo morse erroneo se ignora. Se agrega un espacio al final para indicar en codigo morse que es una letra
        return traduccion
    else:
        print("Se introdujo un caracter incompatible")
        return ""



# Ejercicio 11
def expresiones_equilibradas(expresion: str) -> bool:
    pila = []
    especiales_inicio = ['(', '[', '{']
    especiales_cierre = {')':'(', ']':'[', '}':'{'}
    #especiales = ['(', '[', '{', ')', ']', '}']

    index = 0
    for caracter in expresion:
        if(caracter==" "):
            continue # Si es espacio en blanco se ignora la verificacion
        index += 1 # Llevar el numero del caracter (index para identificarlo en el texto en la salida cuando se encuentre el error), solo se suma si no es espacio en blanco
        if(caracter in especiales_inicio): # Identificando los de apertura
            pila.append(caracter)
        elif(caracter in especiales_cierre): # Indentificando los de cierre
            if(len(pila) == 0): # Si se agrega primero un caracter de cierre antes de uno de apertura
                print(f"Error en el caracter de cierre correspondiente a la  posicion: {index}")
                return False
            if(pila[-1] != especiales_cierre[caracter]): # Si el caracter de cierre no coincide con el ultimo caracter de apertura (inicio) y la pila no esta vacia
                print(f"Error en el caracter de cierre correspondiente a la  posicion: {index}")
                return False
            #pila_final.append(caracter)
            elif(pila[-1] == especiales_cierre[caracter]): # Si los caracteres de inicio y cierre coinciden
                pila.pop()
        else:
            pass
    if(len(pila)==0):
        return True # Si todos los caracteres son correctos, estan equilibrados y la pila esta vacia
    else:
        return False # No se cerro un caracter



            
# Ejercicio 12
def eliminando_caracteres(cadena1: str, cadena2: str):
    out1, out2 = "", ""
    for caracter in cadena1: # Verificando que caracteres no estan en la lista 2
        if((caracter not in cadena2) and (caracter not in out1)):
            out1 += caracter
    
    for caracter in cadena2: # Verificando que caracteres no estan en la lista 1
        if((caracter not in cadena1) and (caracter not in out2)):
            out2 += caracter

    print(out1)
    print(out2)



# Ejercicio 13
from unidecode import unidecode
import re
def es_palindromo(expresion: str) -> bool:
    expresion = unidecode(expresion.lower().replace(" ", "")) # Quitando espacios en blanco, pasando a minusculas y limpiando acentos
    expresion = re.sub(r"[^a-z]", "", expresion) # Quitado simbolos que no sean letras (a-z)
    print(expresion)
    invertida = expresion[-1::-1]
    if(expresion == invertida): # Verificando si la cadean invertida es igual a la original
        return True
    else:
        return False



# Ejercicio 14
def factorial(num: int) -> int:
    if(num == 1 or num == 0):
        return 1
    elif(num > 1):
        return factorial(num-1) * num
    else:
        print("Numero no valido")



# Ejercicio 15
def numero_armstrong(num: int) -> bool:
    try:
        num_str = str(num)
        numeros = [int(numero) for numero in num_str]
        cifras = len(numeros)
        n_amstrong = 0
        #  Obteniendo el resultado de sumar los digitos elevados al numero de cifras (numero armstrong o narcisista)
        for n in numeros:
            n_amstrong += n**cifras 
        # Verificando si es un numero Armstrong
        return True if n_amstrong ==  num else False
    except Exception as e:
        print("El numero introducido no es un numero entero")
# Codigo simplificado
def numero_armstrong2(num: int) -> bool:
    try:
        num_str = str(num)
        cifras = len(num_str)
        n_armstrong = sum((int(numero)**cifras) for numero in num_str) # Suma un iterable, en este caso mis digitos
        return n_armstrong == num
    except Exception as e:
        print("El numero introducido no es un numero entero")


# Ejercicio 16
# Diferencia de dias
def mes_valido(mes: int):
    return True if (mes>0 and mes<13) else False
def dia_valido(dia: int):
    return True if (dia>0 and dia<32) else False
def cual_es_menor(fecha1:list, fecha2:list):
    if(fecha1[2]>fecha2[2]):
        return fecha2, fecha1 # menor, mayor
    elif(fecha1[2]<fecha2[2]):
        return fecha1, fecha2
    else:   # Mismo anio
        if(fecha1[1]>fecha2[1]):
            return fecha2, fecha1
        elif(fecha1[1]<fecha2[1]):
            return fecha1, fecha2
        else: # Es el mismo mes
            if(fecha1[0]>fecha2[0]):
                return fecha2, fecha1
            elif(fecha1[0]<fecha2[0]):
                return fecha1, fecha2
            else:
                return 0,0 # Es a misma fecha
def obtener_dias(fecha_menor, fecha_mayor) -> int:
    MESES_31 = [1,3,5,7,8,10,0,12] # 0 = diciembre
    MESES_30 = [4,6,9,11]
    MES_28 = [2]
    conteo_dias = 0
    # Obteniendo dias
    while fecha_menor!=fecha_mayor: # fecha = [dia,mes,anio]
        # Modificar año
        if(fecha_menor[2]<(fecha_mayor[2]-1)): # Dos años antes del mayor
            fecha_menor[2] += 1 # Sumar un año
            if(fecha_menor[2]%4 == 0): # Es año bisiesto
                conteo_dias += 366
            else:
                conteo_dias += 365
        elif(fecha_menor[2]==(fecha_mayor[2]-1)): # Un año antes
            # Modificar mes hasta igualar el año
            mes_actualizado = (fecha_menor[1]+1) % 12 # Sumar un mes hasta igualar el año
            fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado  # Ajustar mes
            fecha_menor[2] = fecha_menor[2]+1 if (fecha_menor[1]==1) else fecha_menor[2] # Ajustando año dependiendo del mes
            # Actualizando conteo de dias
            if(fecha_menor[1] in MESES_30):
                conteo_dias += 30
            elif(fecha_menor[1] in MESES_31):
                conteo_dias += 31
            elif(fecha_menor[1] in MES_28):
                conteo_dias = conteo_dias+29 if (fecha_menor[2]%4 == 0) else conteo_dias+28 # Si es año bisiesto se suma un dia mas en febrero
            continue # Volver a verificar la condicion del while
        elif(fecha_menor[2]==fecha_mayor[2]): # Mismo año
            # Sumar mes hasta llegar a un mes antes
            if(fecha_menor[1]<(fecha_mayor[1]-1)): # No ha llegado al mes correspondiente (dos mes antes)
                mes_actualizado = (fecha_menor[1]+1) % 12 # Sumar un mes hasta igualar el año
                fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado # Ajustar el mes
                # Actualizando conteo de dias
                if(fecha_menor[1] in MESES_30):
                    conteo_dias += 30
                elif(fecha_menor[1] in MESES_31):
                    conteo_dias += 31
                elif(fecha_menor[1] in MES_28):
                    conteo_dias = conteo_dias+29 if (fecha_menor[2]%4 == 0) else conteo_dias+28 # Si es año bisiesto se suma un dia mas en febrero
                continue # Volver a verificar la condicion del while
            elif(fecha_menor[1]==(fecha_mayor[1]-1)): # Un mes antes
                # Modicar dia (sumar dia hasta llegar igualar al mes)
                if(fecha_menor[1] in MES_28 and fecha_menor[2]%4==0): # Si es año bisiesto y febrero
                    dia_actualizado = (fecha_menor[0]+1) % 29
                    fecha_menor[0] = 29 if (dia_actualizado==0) else dia_actualizado
                    mes_actualizado = (fecha_menor[1]+1) % 12 if (fecha_menor[0]==1) else fecha_menor[1] # Ajustando mes dependiendo del resultado de la suma del dia
                    fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado # Ajustando mes
                    conteo_dias += 1
                elif(fecha_menor[1] in MES_28):
                    dia_actualizado = (fecha_menor[0]+1) % 28
                    fecha_menor[0] = 28 if (dia_actualizado==0) else dia_actualizado
                    mes_actualizado = (fecha_menor[1]+1) % 12 if (fecha_menor[0]==1) else fecha_menor[1] # Ajustando mes
                    fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado # Ajustando mes
                    conteo_dias += 1
                elif(fecha_menor[1] in MESES_30):
                    dia_actualizado = (fecha_menor[0]+1) % 30
                    fecha_menor[0] = 30 if (dia_actualizado==0) else dia_actualizado
                    mes_actualizado = (fecha_menor[1]+1) % 12 if (fecha_menor[0]==1) else fecha_menor[1] # Ajustando mes
                    fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado # Ajustando mes
                    conteo_dias += 1
                elif(fecha_menor[1] in MESES_31):
                    dia_actualizado = (fecha_menor[0]+1) % 31
                    fecha_menor[0] = 31 if (dia_actualizado==0) else dia_actualizado
                    mes_actualizado = (fecha_menor[1]+1) % 12 if (fecha_menor[0]==1) else fecha_menor[1] # Ajustando mes
                    fecha_menor[1] = 12 if mes_actualizado==0 else mes_actualizado # Ajustando mes
                    conteo_dias += 1
                continue
            elif(fecha_menor[1]==fecha_mayor[1]): # Mismo mes
                # Sumar dias hasta igual la fecha
                fecha_menor[0] += 1
                conteo_dias += 1
                continue
        elif(fecha_menor==fecha_mayor):
            return conteo_dias
    return conteo_dias

def diferencia_dias(fecha1: str, fecha2: str):
    try:
        fecha1_dia = int(fecha1[:2]) 
        fecha1_mes = int(fecha1[3:5])
        fecha1_anio = int(fecha1[6:])

        fecha2_dia = int(fecha2[:2])
        fecha2_mes = int(fecha2[3:5])
        fecha2_anio = int(fecha2[6:])

        if(mes_valido(fecha1_mes)==False or mes_valido(fecha2_mes)==False):
            raise ValueError("Mes fuera de rango")
        if(dia_valido(fecha1_dia)==False or dia_valido(fecha2_dia)==False):
            raise ValueError("Dia fuera de rango")
            
        fecha_menor, fecha_mayor = cual_es_menor([fecha1_dia,fecha1_mes,fecha1_anio],[fecha2_dia,fecha2_mes,fecha2_anio])
        
        if(fecha_menor==0 and fecha_mayor==0): # Si es la misma fecha
            return 0
        else:
            return obtener_dias(fecha_menor,fecha_mayor)
    except Exception as e:
        print(f"Error en el valor de la fecha: {e}")



# Ejercicio 17
def inicial_mayuscula(texto: str) -> str:
    nueva_cadena = ""
    es_nueva = True
    for i in range(len(texto)):
        try:
            if(i==0):
                nueva_cadena += texto[i].upper()
                es_nueva = False
            elif(texto[i]==" "):
                nueva_cadena += " "
                es_nueva = True
            elif(es_nueva):
                nueva_cadena += texto[i].upper()
                es_nueva = False
            elif(not es_nueva):
                nueva_cadena += texto[i]
        except Exception as e:
            continue
    return nueva_cadena



# Ejercicio 18
def carrera_obstaculos(pista: list, recorrido_atleta: list) -> bool:
    if(len(pista) != len(recorrido_atleta)):
        return False
    else:
        for i in range(len(pista)):
            if(pista[i]=="_" and recorrido_atleta[i]=="run"):
                continue
            elif(pista[i]=="|" and recorrido_atleta[i]=="jump"):
                continue
            elif(pista[i]=="_" and recorrido_atleta[i]=="jump"):
                pista[i] = "x"
            elif(pista[i]=="|" and recorrido_atleta[i]=="run"):
                pista[i] = "/"
            else:
                pista[i] = "x"
        if("x" in pista) or ("/" in pista):
            return False
        else:
            return True
        


# Ejercicio 19
def verificar_gato(tablero) -> str:
    # Verificar columnas
    for c1,c2,c3 in zip(tablero[0],tablero[1],tablero[2]):
        if(c1=="X" and c2=="X" and c3=="X"):
            return "X"
        elif(c1=="0" and c2=="0" and c3=="0"):
            return "0"
    # Verificar renglones
    for ren in tablero:
        if(ren[0] == "X" and ren[1]=="X" and ren[2]=="X"):
            return "X"
        elif(ren[0] == "0" and ren[1]=="0" and ren[2]=="0"):
            return "0"
    # Verificar diagonales
    if( all(tablero[i][i]=="X" for i in range(3)) ): # Diagonal superior izquierda a inferior derecha
        return "X"
    if( all(tablero[i][i]=="0" for i in range(3)) ): # Diagonal superior izquierda a inferior derecha
        return "0"
    if( all(tablero[i][2-i]=="X" for i in range(3)) ): # Diagonal superior derecha a inferior izquierda
        return "X"
    if( all(tablero[i][2-i]=="0" for i in range(3)) ): # Diagonal superior derecha a inferior izquierda
        return "0"

if __name__ == '__main__':
    tablero = [["X","","0"],["X","0",""],["0","","X"]]
    ganador = verificar_gato(tablero)
    print(ganador)


    '''
    pista = ["_","_","|","_"]
    atleta = ["run","run","jump","run"]
    resultado = carrera_obstaculos(pista,atleta)
    print(resultado)
    '''

    '''
    cadena = "hola buenos dias, texto de prueba."
    cadena = inicial_mayuscula(cadena)
    print(cadena)
    '''

    '''
    #dias = diferencia_dias("18/12/2023","19/10/2020")
    dias = diferencia_dias("18/12/2023","18/12/2022")
    print(dias)
    '''


    '''
    print(numero_armstrong2(153))
    print(numero_armstrong(370))
    '''

    #print(factorial(5))

    '''
    print(es_palindromo("Aná? lleva al. oso la avellana"))
    print(es_palindromo("Anita lava la tina"))
    '''

    #eliminando_caracteres("Me gusta Java","Me gusta Kotlin")

    '''
    print(expresiones_equilibradas("{a + b [c] * (2x2)}}}}"))
    print(expresiones_equilibradas("{ [ a * ( c + d ) ] - 5 }"))
    print(expresiones_equilibradas("{ a * ( c + d ) ] - 5 }"))
    print(expresiones_equilibradas("{a^4 + (((ax4)}"))
    print(expresiones_equilibradas("{ ] a * ( c + d ) + ( 2 - 3 )[ - 5 }"))
    print(expresiones_equilibradas("{{{{{{(}}}}}}"))
    print(expresiones_equilibradas("(a"))
    '''

    '''
    morse=codigo_morse("hola como estas")
    texto=codigo_morse(morse)
    print(texto)
    '''

    #binario = decimal_binario(30)
    #print(binario)

    #contar_palabras2("hola como estas. como? como estas")
    #contar_palabras2("Hola, mi nombre es brais. Mi nombre completo es Brais Moure (MoureDev).")

    #fizz_buzz()
    
    #print(anagrama1("aloh","hola"))
    
    #print(anagrama2("roma","amor"))

    #serie = serie_fibonacci2(50)
    #print(serie)
    
    #primos = numeros_primos(1,30)
    #print(primos)

    #print(area("rectangulo",10,2))

    #print(ratio_aspect("https://i.pinimg.com/originals/71/9e/80/719e80760999b4c355a723224120eb07.png"))

    #print(invertir_cadena("cadena al derecho de prueba"))
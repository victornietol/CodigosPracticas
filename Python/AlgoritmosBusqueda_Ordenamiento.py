# Generacion de una lista de elementos
import random
import math
import time

'''
    Generar lista de numeros aleatoriamente
'''
def generar_lista(num_elementos: int,repeticion: int,min: int, max: int) -> list: # (n-elementos, repeticion: 1 -> si, 0 -> no)
    lista = []
    if(repeticion==0):
        total_e = max+1 - min
        if(num_elementos <= total_e): # Verificar que el numero de elementos no sea mayor al maximo valor del intervalo
            repetido = False
            for e in range(num_elementos):
                elemento = random.randint(min,max)
                if(elemento in lista): # Verificando si el elemento esta en la lista
                    repetido = True
                    while(repetido == True):
                        elemento = random.randint(min,max)
                        if(elemento not in lista): # Verificando si el nuevo elemento esta en la lista
                            lista.append(elemento)
                            repetido = False
                else:
                    lista.append(elemento)
            return lista
        else:
            print("El numero de elemntos a generar excede el valor del intervalo de min y max")

    elif(repeticion==1):
        for e in range(num_elementos):
            lista.append(random.randint(min,max))
        return lista
    
    else:
        print("Valor incorrecto para el parametro 'repeticion'")


'''
    Ordenamiento burbuja
'''

def ord_burbuja(lista: list) -> tuple[list,int]:
    ordenada = False
    rep = 1
    while(not ordenada):
        ordeno = 0 # Auxiliar para saber se realizo ordenacion en la repeticion
        for i in range(len(lista)-1):
            if(lista[i] > lista[i+1]):
                ordeno = 1
                aux = lista[i+1]
                lista[i+1] = lista[i]
                lista[i] = aux
            else:
                # Estan acomodados
                if(((i+1) == (len(lista)-1)) and (ordeno == 0)): # Si se llego al final de la lista sin entrar a ordenalra de nuevo
                    #ordenada = True
                    #print(f"Repeticiones del while: {rep}")
                    return lista, rep
                else:
                    pass
        rep +=1 # Ver en cuantas repeticiones se ordeno


'''
    QuickSort
'''

def dividir_lista(lista: list, pivote) -> tuple[list,list]:
    elementos_men, elementos_may = [], []
    for e in lista:
        if(e < pivote):
            elementos_men.append(e)
        else:
            elementos_may.append(e)
    return elementos_men, elementos_may

def select_pivote(lista: list):
    suma = 0
    for e in lista:
        suma += e
    return suma / len(lista) # Obtener un valor promedio para dividir en 2 la lista

def verificar_iguales(lista: list) -> bool:
    if(len(lista) >= 1):
        anterior = lista[0]
        for e in lista:
            if(not e == anterior):
                return True
        return False
    else:
        return False

def quickSort(lista: list):
    if(len(lista)>1 and verificar_iguales(lista)):
        pivote = select_pivote(lista)
        elementos_men, elementos_may = dividir_lista(lista, pivote)
        elementos_men, elementos_may = quickSort(elementos_men), quickSort(elementos_may)
        return elementos_men + elementos_may
    else:
        return lista

'''
    MergeSort
'''

def unir_listas(lista1: list, lista2: list):
    lista_final = []
    while(len(lista1)>0 and len(lista2)>0):
        if(lista1[0] < lista2[0]):
            lista_final.append(lista1[0])
            lista1.remove(lista1[0])
        else:
            lista_final.append(lista2[0])
            lista2.remove(lista2[0])
    return lista_final + lista1 + lista2

def dividir_mitad(lista: list) -> tuple[list,list]:
    t_elementos = len(lista)
    mitad = t_elementos // 2
    lista1 = lista[:mitad]
    lista2 = lista[mitad:]
    return lista1, lista2

def mergeSort(lista: list) -> list:
    if(len(lista) > 1):
        lista1, lista2 = dividir_mitad(lista)
        lista1, lista2 = mergeSort(lista1), mergeSort(lista2)
        lista = unir_listas(lista1, lista2)
    return lista


'''
    Busqueda binaria
'''

def busqueda_binaria(lista: list, objetivo):
    pivote = len(lista)//2
    if(lista[pivote] == objetivo):
        return lista[pivote]
    elif(len(lista)==1 and lista[0]!=objetivo):
        return f"El elemento {objetivo} no se encuentra en la lista"
    elif(objetivo < lista[pivote]):
        return busqueda_binaria(lista[:pivote], objetivo)
    elif(objetivo > lista[pivote]):
        return busqueda_binaria(lista[pivote:], objetivo)




# Probar algoritmos
inicio = time.perf_counter()
lista = generar_lista(20,0,1,200)
tiempo_ejecucion = time.perf_counter() - inicio

print("------ Lista desordenada ------\n",lista,f"\nTiempo ejecucion: {tiempo_ejecucion:.10f}",end="\n\n")

# Burbuja
inicio = time.perf_counter()
lista_burbuja,rep = ord_burbuja(lista)
tiempo_ejecucion = time.perf_counter() - inicio
print("------ Lista ordenada por burbuja ------\n",lista_burbuja,f"\nTiempo ejecucion: {tiempo_ejecucion:.10f}")
print("Repeticiones del while: ",rep,end="\n\n")

# QuickSort
inicio = time.perf_counter()
lista_quicksort = quickSort(lista)
tiempo_ejecucion = time.perf_counter() - inicio
print("------ Lista ordenada por QuickSort -------\n", lista_quicksort,f"\nTiempo ejecucion: {tiempo_ejecucion:.10f}",end="\n\n")

# MergeSort
inicio = time.perf_counter()
lista_mergeSort = mergeSort(lista)
tiempo_ejecucion = time.perf_counter() - inicio
print("------ Lista orednada por MergeSort ------\n", lista_quicksort, f"\nTiempo ejecucion: {tiempo_ejecucion:.10f}", end="\n\n")


# Busqueda binaria
inicio = time.perf_counter()
encontrado_binaria = busqueda_binaria(lista_quicksort, random.randint(1,200))
tiempo_ejecucion = time.perf_counter() - inicio
print("------ Busqueda binaria ------\n", encontrado_binaria, f"\nTiempo ejecucion: {tiempo_ejecucion:.10f}")
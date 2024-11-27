'''
    Dibuje un tablero de 8x8 casillas, es decir, 8 renglones y 8 columnas.
    Coloque 8 reinas representadas por un asterisco: * de tal forma que no se ataquen, 
    significa que no exista mas de una reina por renglon, por columna, ni por diagonal.


# Creando tablero y posiciones de columnas y renglones
pos_ren = 0
pos_col = 0
tablero = [["O" for columans in range(8)] for filas in range(8)]

# Mostrando tablero limpio
print("---- Tablero vacio -----")
for fila in tablero:
    print(fila)

# Colocando reinas
for renglones in range(8):
    if(pos_col > 7):
        pos_col = 1
    if(pos_ren > 7):
        break
    tablero[pos_ren][pos_col] = "*"
    pos_ren += 1
    pos_col += 2

# Mostrando resultado
print("---- Tablero final ----")
for fila in tablero:
    print(fila)

############################################
    
    # Probando soluciones
col = 4
reng = 4
# Subir en diagonal izquierda
for r,c in zip(range(reng,-1,-1), range(col,-1,-1)):
    tablero[r][c] = "O"
# Subir en diagonal derecha
for r,c in zip(range(reng,-1,-1), range(col,len(tablero),1)):
    tablero[r][c] = "8"
for x in tablero:
    print(x)
'''

# Solucion

def espacio_libre(tab, ren, col): # Verificar si hay espacio libre
    for r in range(ren): # Verificando si hay espacio libre en esa columna (ninguna reina hacia arriba en la columna)
        if(tab[r][col] == "*"):
            return False
    
    for r,c in zip(range(ren,-1,-1), range(col,-1,-1)): # Verificando si hay reina en diagonal superior izquierda
        if(tab[r][c] == "*"):
            return False
    
    for r,c in zip(range(ren,-1,-1), range(col,len(tab),1)): # Verificando si hay reina en diagonal sup derecha
        if(tab[r][c] == "*"):
            return False
    
    return True # Si no encuentra ninguna reina, entonces es un espacio libre


def colocar_reinas(tab, ren): # Colocacion de reinas
    if (ren >= len(tab)): # En caso de llegar al limite del tamanio del tablero
        reinas=0 # Conteo de reinas
        # Verificar que se colocaron todas las reinas
        for r in range(len(tab)):
            for c in range(len(tab)):
                if(tab[r][c] == "*"):
                    reinas +=1
        if(reinas==8):
            return True # Se colocaron todas las reinas
        else:
            return False # No se llego a una solucion
    
    for col in range(len(tab)): # Intento de colocar una reina en una columna de la fila actual
        if (espacio_libre(tab, ren, col)):
            tab[ren][col] = "*"
            if (colocar_reinas(tab, ren+1)): # Intento de colocar otra reina en el sig renglon
                return True
            else:
                tab[ren][col] = "." # Si no es posible colocar otra reina se regresa
    
    return False # En caso de fallar la solucion

# Creando tablero y mostrando solucion
tablero = [["." for columnas in range(8)] for filas in range(8)]
inicio_ren = 0
if(colocar_reinas(tablero,inicio_ren)):
    for renglon in tablero:
        # print(renglon)
        print("  ".join(renglon))
else:
    print("No se encontro solucion")
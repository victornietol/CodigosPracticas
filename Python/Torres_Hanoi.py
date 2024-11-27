movimientos = 0

def torres_hanoi(n_discos: int, torre_inicio: str, torre_final: str, torre_pivote: str):
    global movimientos
    if(n_discos == 1):
        movimientos +=1
        print(f"{movimientos}: Mover disco 1 de {torre_inicio} a {torre_final}")
        return
    torres_hanoi(n_discos-1, torre_inicio, torre_pivote, torre_final)
    movimientos +=1
    print(f"{movimientos}: Mover disco {n_discos} de {torre_inicio} a {torre_final}")
    torres_hanoi(n_discos-1, torre_pivote, torre_final, torre_inicio)

torres_hanoi(7,'A','C','B')
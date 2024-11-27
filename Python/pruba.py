import cifrado_cesar
import time

texto = "¡hola!, ¿como estas?, el resultado es: 19 _"
llave = -3

# Prueba utilizando aritmetica modular
print("----- UTILIZANDO ARITMETICA MODULAR ------")
inicio = time.perf_counter()
texto_cifrado = cifrado_cesar.cifrar_mensaje(texto, llave)
tiempo_ejecucion_mod_cif = time.perf_counter() - inicio
print(f"Texto cifrado: {texto_cifrado}\nTimepo ejecucion: {tiempo_ejecucion_mod_cif}\n")

inicio = time.perf_counter()
texto_descifrado = cifrado_cesar.descifrar_mensaje(texto_cifrado, llave)
tiempo_ejecucion_mod_des = time.perf_counter() - inicio
print(f"Texto descifrado: {texto_descifrado}\nTimepo ejecucion: {tiempo_ejecucion_mod_des}\n")



# Prueba sin utilizar artimetica modular
print("-----SIN ARITMETICA MODULAR ------")
inicio = time.perf_counter()
texto_cifrado = cifrado_cesar.cifrar_mensaje1(texto, llave)
tiempo_ejecucion_sin_cif = time.perf_counter() - inicio
print(f"Texto cifrado: {texto_cifrado}\nTimepo ejecucion: {tiempo_ejecucion_sin_cif}\n")

inicio = time.perf_counter()
texto_descifrado = cifrado_cesar.descifrar_mensaje1(texto_cifrado, llave)
tiempo_ejecucion_sin_des = time.perf_counter() - inicio
print(f"Texto descifrado: {texto_descifrado}\nTimepo ejecucion: {tiempo_ejecucion_sin_des}\n")



# Indicando que algoritmo obtuvo un menor tiempo de ejecucion
if(tiempo_ejecucion_mod_cif > tiempo_ejecucion_sin_cif): # Comparando cifrado
    print("Menor tiempo cifrado: Sin aritmetica modular")
else:
    print("Menor tiempo cifrado: Con aritmetica modular")

if(tiempo_ejecucion_mod_des > tiempo_ejecucion_sin_des): # Comparando descifrado
    print("Menor tiempo descifrado: Sin aritmetica modular")
else:
    print("Menor tiempo descifrado: Con aritmetica modular")

#texto_cif = "ju2yñid hp2z2 r67ñ6gd ry 5r68y7ñq2 r6f ¿b n"
#texto_descifrado = cifrado_cesar.descifrar_mensaje(texto_cif, 14)
#print(texto_descifrado)
"""
    Clase 19-08-2024
    Tiro parabolico, tiro vertcal y caida libre
    
    Vx = V_ini*cos(°)
    Vy = V_ini*sen(°)
    
    x = Vx*t
    y = Vy*t-1/2*gt^2
"""
import math
import matplotlib.pyplot as plt

"""
# PRUEBA para generar los grados correctamente
grados = 90

rad = math.radians(grados)
res = math.sin(rad)  # Valor en grados

print(f"{res}")
"""
# Para graficarlo, en este caso no se utiliza
# fig, ax = plt.subplots()

V_ini = 150 # Velocidad inicial
theta = 45 # Grados

Vx = V_ini * math.cos(math.radians(theta)) # Velocidad en x
Vy = V_ini * math.sin(math.radians(theta)) # Velocidad en y

# Lista para guardar los puntos
x_puntos = []
y_puntos = []

# ---> Para guardarlo en excel y graficarlo
# ---> arch = open('tiro.csv','w')

for t in range(20): # t es tiempo
    x = Vx * t
    y = Vy * t - 4.9 * (t*t) # -> Vy * t -(0.5)(9.8)(t^2)
    
    # Agregar los puntos para graficarlos
    x_puntos.append(x)
    y_puntos.append(y)
    
# Graficar puntos
plt.plot(x_puntos,y_puntos, marker = 'o')
    
    # ---> Continuar guardandolo en excel
    # ---> arch.write(str(x)+','+str(y))
    
# Mostrar el resultado de la operacion
print(f"({round(x,4)},{round(y,4)})")

# Generar el grafico
plt.xlabel("x")
plt.ylabel("y")
plt.show()

# ---> Terminar de escribir el archivo en excel
# ---> arch.close()    


"""
 Povray
 
 - Se puede generar un grafico con este programa, solo se hace con codigo, y se puede utilizar
   el archivo con comas generado.
   
 - Generar luz:
     light_source {
         <100,100,1000>
         color rgb <1.0,0.0,0.0>}
                    red,green,blue
         }
    
 - Generar sphere:
     sphere { <0.0,0.0,0.0>, 1.0
             pigment{ color rgb <1.0,0.0,0.0>
                     }
         
         }
"""
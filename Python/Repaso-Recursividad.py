# Factorial de un numero
def factorial(numero):
    if(numero==1 or numero==0):
        return 1
    else:
        return numero * factorial(numero-1)
    
# Obteniendo factorial
num_fac = 10
res_fac = factorial(num_fac)
print(f"El factorial de {num_fac} es: {res_fac}")



# Serie de fibonacci
def fibonacci(numero):
    if(numero==0):
        return 0
    elif(numero==1):
        return 1
    else:
        return fibonacci(numero-1) + fibonacci(numero-2)

def serie_fibonacci(numero):
    print(f"La serie de Fibonacci de {numero} es:")
    for num in range(numero+1):
        print(f"{fibonacci(num)}",end=", ")
    
#num_fib = 10
#res_fib = fibonacci(num_fib)
#print(f"La serie de fibonacci de {num_fib} es: {res_fib}")

serie_fibonacci(10)
# for i in range(1,30):
#    print(i)

'''
import random

for i in range(1,10):
    print(f"-------------------COMBINACION {i+1}")
    print(f"v = {random.randint(1,200)}")
    print(f"angulo = {random.randint(10,180)}")
    print(f"for t in range({random.randint(25,150)})")
    print(f"pos = tiroPara... = {random.randint(3,20)}")
    print(f"cad = cad+blob... = {random.randint(1,8)}, {random.randint(1,5)}\n")
'''
    
def factorial(num: int) -> int:
    return 1 if num==1 else num*factorial(num-1)

num = 5
res = factorial(num)
print(f"factorial de {num} = {res}")


def cal(*args)-> float:
    return sum(args)/len(args)

print(cal(90,100,80,100,100,100,100))


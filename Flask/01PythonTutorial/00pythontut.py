import sys
import math
import math
import threading
import time
import random
from functools import reduce

print("Hello World")
# name = input("What is your name? >")
# print("Hi", name)
print(type(10))
print(sys.maxsize)
print(sys.float_info.max)
f1 = 1.11111111111111111111111111111111
f2 = 1.11111111111111111111111111111111
print (f1+f2)

b1 = False
print("Escape Sequence \' \" \t \\ \n")
print('''Triple queted ' " ''')

print(int(5.4), type(int(5.4)))
print(str(5.4), type(str(5.4)))
print(chr(65), type(chr(65)))
print(ord('a'), type(ord('a')))

print(12, 21, 1974, sep='/')
print(12, 21, 1974, end='')
print(12, 21, 1974)
print("\n%04d %s %.2f %c" % (1, "Sansoo", 1.234, 'A'))

print(5+2)
print(5-2)
print(5/2)
print(5*2)
print(5%2)
print(5**2)
print(5//2)
print(abs(-1))

print(random.randint(1,10))
print(math.inf > 0)
print(math.inf - math.inf)

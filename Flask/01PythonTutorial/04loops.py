import sys
import math
import math
import threading
import time
import random
from functools import reduce

w1 = 1
while w1 < 5:
  if(w1 % 2 == 1):
    print(w1)
  w1 += 1

l4 = [1, 3.14, "Sansoo"]
while len(l4):
  print(l4.pop())

for x in range(0, 10):
  print(x, ' ', end="")
print()

l4 = [1, 3.14, "Sansoo"]
for x in l4:
  print(x)

itr = iter(l4)
print(next(itr))
print(next(itr))
print(next(itr))

print(list(range(0,10,2)))
num_list = [[1,3,2],[10,30,20],[100,300,200]]

for x in range(0,3):
  for y in range(0,3):
    print(num_list[x][y])


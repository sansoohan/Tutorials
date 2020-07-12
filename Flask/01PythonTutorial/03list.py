import sys
import math
import math
import threading
import time
import random
from functools import reduce

l1 = [1, 3.14, "Sansoo", True]
print(len(l1))
print(l1[0])
print(l1[-1])
l1[2:4] = ["Han", False]
print(l1)
l1[2:2] = ["Paul", 9, 10]
print(l1)
print(l1 + ["Hello"])
print(l1.pop(0))
print(l1)
print(min([1,2,3]))
print(max([1,2,3]))

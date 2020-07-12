import sys
import math
import math
import threading
import time
import random
from functools import reduce

age = 30
if age > 21:
  print("You can drive a tractor trailer")
elif age >= 16:
  print("You can drive a car")
else:
  print("You can't drive")


if age < 5:
  print("Stay Home")
elif (age>=5) and (age<6):
  print("Go to Kindergarten")
elif (age>6) and (age<=17):
  print("Grade", (age-5))
else:
  print("College")

canVote = True if age >=18 else False
print(canVote)

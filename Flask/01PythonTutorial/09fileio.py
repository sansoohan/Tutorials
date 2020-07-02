import sys
import math
import math
import threading
import time

with open("mydata.txt", mode="w", encoding="utf-8") as my_file:
  my_file.write("Some randomtext")

with open("mydata.txt", encoding="utf-8") as my_file:
  print(my_file.read())

print(my_file.close())

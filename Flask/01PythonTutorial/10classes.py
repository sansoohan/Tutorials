import sys
import math
import math
import threading
import time

class Square:
  def __init__(self, height="0", width="0"):
    self.height = height
    self.width = width
  @property
  def height(self):
    return self.__height
  @height.setter
  def height(self, value):
    if value.isdigit():
      self.__height = value
    else:
      print("Please only enter numbers for height")
  @property
  def width(self):
    return self.__width
  @width.setter
  def width(self, value):
    if value.isdigit():
      self.__width = value
    else:
      print("Please only enter numbers for width")
  def get_area(self):
    return int(self.__width) * int(self.__height)

square = Square()
square.height = "10"
square.width = "10"
print(square.get_area())

class Animal:
  def __init__(self, name="unknown", weight=0):
    self.__name = name
    self.__weight = weight

  @property
  def name(self, name):
    self.__name = name
  def make_noise(self):
    return "Grrrr"
  def __str__(self):
    return "{} is a {} and says {}".format(self.__name, type(self).__name__, self.make_noise())

  def __gt__(self, animal2):
    if self.__weight > animal2.__weight:
      return True
    else:
      return False

class Dog(Animal):
  def __init__(self, name="unknown", owner="unknown", weight=0):
    Animal.__init__(self,name,weight)
    self.__owner = owner

  def __str__(self):
    return super().__str__() + " and is owned by " + self.__owner

animal = Animal("Spot", 100)
print(animal)
dog = Dog("Bowser", "Bob", 150)
print(dog)


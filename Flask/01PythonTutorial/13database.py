import sys
import math
import math
import threading
import time
import sqlite3
import csv

def printDB():
  try:
    result = theCursor.execute("SELECT ID, FName FROM Employees")
    for row in result:
      print(row[0])
      print(row[1])
  except sqlite3.OperationalError:
    print("The talbe doesn't exist")
  except:
    print("Couldn't get data")

db_conn = sqlite3.connect('test.db')
print("Database Created")

theCursor = db_conn.cursor()

try:
  db_conn.execute("CREATE TABLE Employees(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, FNAME TEXT)")
  db_conn.commit()
  print("Table Created")
except sqlite3.OperationalError:
  print("The talbe not created")

db_conn.execute("INSERT INTO Employees (FName)" "VALUES ('Sansoo')")
db_conn.commit()

printDB()
db_conn.close()
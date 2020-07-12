#!/usr/bin/env python3
from socket import AF_INET, socket, SOCK_STREAM
from threading import Thread
BUFSIZ = 1024

class ChatServer:
  def __init__(self, host, port):
    self.__host = host
    self.__port = port
    self.__clients = []
    self.__serverSocket = socket(AF_INET, SOCK_STREAM)
    self.__serverSocket.bind((host, port))

  def run(self):
    self.__serverSocket.listen()
    print(f"ChatServer started on {self.__host}:{self.__port}\n")
    while True:
      clientSocket, clientAddress = self.__serverSocket.accept()
      print("%s:%s has connected." % clientAddress)
      newClient = ChatClient(clientSocket, self)
      self.__clients.append(newClient)
      Thread(target=newClient.run).start()

  def messageController(self, message):
    self.messageToEverybody(message)
  
  def messageToEverybody(self, message):
    for client in self.__clients:
      client.messageToClient(message)

  def removeClient(self, client):
    client.getClientSocket().close()
    clients.remove(client)

  def close(self):
    self.__serverSocket.close()

class ChatClient:
  def __init__(self, clientSocket, chatServer):
    self.__clientSockets = clientSocket
    self.__chatServer = chatServer

  def messageToClient(self, message):
    self.__clientSockets.send(message)
  
  def run(self):
    while True:
      try:
        message = self.__clientSockets.recv(BUFSIZ)
        self.__chatServer.messageController(message)
      except ConnectionResetError:
        self.__chatServer.removeClient(client)
  
  def getClientSocket(self):
    return self.__clientSockets()

if __name__ == "__main__":
  chatServer = ChatServer('', 5000)
  ACCEPT_THREAD = Thread(target=chatServer.run)
  ACCEPT_THREAD.start()
  ACCEPT_THREAD.join()
  chatServer.close()

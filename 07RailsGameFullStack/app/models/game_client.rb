class GameClient < ApplicationRecord
  belongs_to :game_room_observer, optional: true

  def init
    self.game_room_observer
    self.clientID = ""
    self.isRoomMaster = false
    self.isReady = false
    self.roomNumber = 0
    # how to lock specific record in database for read write
    @semaphore = Mutex.new
    # how to observe a database
    @messageFromClient
  end

  def run
    while 1
      @messageFromClient = @clientSocket.gets()
      begin
        messageController(@messageFromClient) 
      rescue => exception
        puts exception
      end
    end
  end

  def messageController(message)
    # Response Message
    puts message
    if message[0] == '/'
      if self.roomNumber == 0
        case message.rstrip.split(/ /)[0]
        when '/make'
          makeRoom(message)
        when '/join'
          joinRoom(message)
        when '/test'
          test(message)
        when '/login'
          login(message)
        when '/newaccount'
          newAccount(message)
        when '/passwdlost'
          passwdLost(message)
        end
      else
        case message.rstrip.split(/ /)[0]
        when '/ready'
          readyRoom(message)
        when '/leave'
          leaveRoom(message)
        when '/start'
          startTheGame(message)
        when '/attack'
          fireOnMap(message)
        end
      end
    # Room Chat
    # Waiting Room : 0
    # Game Room : 1 ~ 20
    else
      for client in @server.clients do
        if self.roomNumber == client.roomNumber
          begin
            client.messageToClient(message)
          rescue => exception
            puts exception 
          end
        end
      end
    end
  end

  def makeRoom(message)
    temp = message.rstrip.split(/ /)[1]
    temp = temp.to_i
    for gameRoom in @server.gameRoomList do
      if gameRoom.roomNumber == temp
        begin
          messageToClient("Room#{temp} is already exist!")
        rescue => exception
          puts exception 
        end
        return
      end
    end
    @server.messageToEverybody("/clientstate #{self.clientID} from #{self.roomNumber} to #{temp}")
    begin
      messageToClient("/make #{temp} ok")
    rescue => exception
      puts exception 
    end
    self.roomNumber = temp
    self.isRoomMaster = true
    newRoom = GameRoomObserver.new(temp, @server)
    newRoom.roomNumber = temp
    newRoom.clientsInRoom.push(self)
    self.game_room_observer = newRoom
    @server.gameRoomList.push(newRoom)
  end

  def joinRoom(message)
    temp = message.rstrip.split(/ /)[1]
    for gameRoom in @server.gameRoomList do
      if gameRoom.roomNumber == temp.to_i
        if gameRoom.playersInRoom
          begin
            messageToClient("Room#{temp} is now playing.")
          rescue => exception
            puts exception 
          end
          return
        end
        if gameRoom.clientsInRoom.length == 6
          begin
            messageToClient("Room#{temp} is full.")
          rescue => exception
            puts exception 
          end
          return
        end
        gameRoom.clientsInRoom.push(self)
        self.game_room_observer = gameRoom
        begin
          messageToClient("/join #{temp} ok")
        rescue => exception
          puts exception 
        end
        self.roomNumber = temp.to_i
        return
      end
    end
    begin
      messageToClient("Room#{temp} is not exist. Please Make Room.")
    rescue => exception
      puts exception 
    end
  end
  def test(message)

  end
  def login(message)
    userInfo = message.rstrip.split(/ /)
    userInfo.shift
    if userInfo.length != 2
      begin
        messageToClient("/login notentered")
      rescue => exception
        puts exception 
      end
      return
    end
    Dir.mkdir('userInfo') unless File.exists?('userInfo')
    File.new("userInfo/userPrivacy.txt","w") unless File.exist?("userInfo/userPrivacy.txt")
    for lineData in File.open("userInfo/userPrivacy.txt","r") do
      userData = lineData.rstrip.split(/,/)
      if (userData[0] == userInfo[0]) && (userData[1] == userInfo[1])
        self.clientID = userData[0]
        self.clientID = userData[2]
        @server.messageToEverybody("/clientstate #{self.clientID} from #{self.roomNumber} to #{self.roomNumber}")
        for otherClient in @server.clients do
          if otherClient.clientSocket != @clientSocket
            begin
              messageToClient("/clientstate #{otherClient.clientID} from #{otherClient.roomNumber} to #{otherClient.roomNumber}") 
            rescue => exception
              puts exception 
            end
          end
        end
        begin
          messageToClient("/login ok #{self.clientID} #{self.clientID}")
        rescue => exception
          puts exception 
        end
        return
      end
    end
    begin
      messageToClient("/login mismatch")
    rescue => exception
      puts exception 
    end
  end
  def newAccount(message)
    userInfo = message.rstrip.split(/ /)
    userInfo.shift
    Dir.mkdir('userInfo') unless File.exists?('userInfo')
    File.new("userInfo/userPrivacy.txt","w") unless File.exist?("userInfo/userPrivacy.txt")
    userPravacyFile = File.new("userInfo/userPrivacy.txt","a")
    for lineData in File.open("userInfo/userPrivacy.txt", "r") do
      userData = lineData.rstrip.split(/,/)
      if userData[0] == userInfo[0]
        begin
          messageToClient("/newaccount idcollision")
        rescue => exception
          puts exception 
        end
        return
      end
    end.close
    userInfoTofile = userInfo.join(',')
    userPravacyFile.puts(userInfoTofile)
    userPravacyFile.close
    begin
      messageToClient("/newaccount ok")
    rescue => exception
      puts exception 
    end
  end
  def passwdLost(message)
    userInfo = message.rstrip.split(/ /)
    userInfo.shift
    if userInfo.length != 3
      begin
        messageToClient("Please enter your id and email")
      rescue => exception
        puts exception 
      end
      return
    end
    Dir.mkdir('userInfo') unless File.exists?('userInfo')
    File.new("userInfo/userPrivacy.txt","w") unless File.exist?("userInfo/userPrivacy.txt")
    for lineData in File.open("userInfo/userPrivacy.txt", "r") do
      userData = lineData.split(/,/)
      if userData[0] == userInfo[0]
        begin
          messageToClient("Password will be sent to your email")
        rescue => exception
          puts exception 
        end
        return
      end
    end
    begin
      messageToClient("There is no matching user")
    rescue => exception
      puts exception 
    end
  end

  def messageToClient(message)
    @semaphore.synchronize do
      @clientSocket.puts(message)
      @clientSocket.flush
    end
  end

  def readyRoom(message)
    if self.isReady == true
      self.isReady = false
    else
      self.isReady = true
    end
    begin
      messageToClient("You are #{self.isReady ? "ready" : "not ready"}")
    rescue => exception
      puts exception 
    end
  end
  def leaveRoom(message)
    if self.game_room_observer.playersInRoom
      begin
        messageToClient("You can't leave while playing")
      rescue => exception
        puts exception 
      end
    else
      self.game_room_observer.removeClient(self)
      if self.isRoomMaster == true
        self.isRoomMaster = false
        if self.game_room_observer.clientsInRoom.length == 0
          @server.gameRoomList.delete(self.game_room_observer)
        else
          newRoomMaster = self.game_room_observer.clientsInRoom[0]
          begin
            newRoomMaster.messageToClient("You are now room master")
          rescue => exception
            puts exception 
          end
          newRoomMaster.isRoomMaster = true
        end
      end
      self.game_room_observer = nil
      @server.messageToEverybody("/clientstate #{self.clientID} from #{self.roomNumber} to 0")
      self.roomNumber = 0
      begin
        messageToClient("/leave ok")
      rescue => exception
        puts exception 
      end
    end
  end
  def startTheGame(message)
    ready = true
    if self.isRoomMaster == true
      for roomClient in self.game_room_observer.clientsInRoom do
        if roomClient.isReady == false
          begin
            roomClient.messageToClient("Ready Please")
          rescue => exception
            puts exception 
          end
          self.game_room_observer.messageToRoom("#{self.clientID} is not ready")
          ready = false
        end
      end
      playersSize = self.game_room_observer.clientsInRoom.length
      if playersSize == 1
        begin
          messageToClient("You need at least two Players.")
        rescue => exception
          puts exception 
        end
        ready = false
      end

      if ready == false
        begin
          messageToClient("You can't start the game")
        rescue => exception
          puts exception 
        end
      else
        self.game_room_observer.configGameModel(self)
        self.game_room_observer.generateGameModel
        self.game_room_observer.initGameView
      end
    else
      begin
        messageToClient("You are not a Room Master.")
        ret = false
      rescue => exception
        puts exception
      end
    end
  end
  def fireOnMap(message)
    firedTarget = message.rstrip.split(/ /)[1].to_i
    if self.game_room_observer.playersInRoom == nil
      begin
        messageToClient("The game is not started")
      rescue => exception
        puts exception 
      end
      return
    end
    thisTurnPlayer = self.game_room_observer.playersInRoom[self.game_room_observer.playerTurn]
    if thisTurnPlayer.client == self
      row = firedTarget / 7
      col = firedTarget % 7
      fireError = hasFireError(row,col,thisTurnPlayer)
      case fireError
      when "No Error"
        rowString = "ABCDEFG"
        colString = "0123456"
        fireMessage = "#{self.clientID} fired on #{rowString[row]}#{colString[col]}"
        puts fireMessage
        self.game_room_observer.messageToRoom(fireMessage)
        self.game_room_observer.fireMessageToPlayers(row,col)
        self.game_room_observer.nextTurn
      when "Suicide Error"
        self.game_room_observer.suicidePlayer(thisTurnPlayer)
      when "Spot Error"
        thisTurnPlayer.client.messageToClient("There is no ship. Please select other spot.")
      end
    else
      begin
        messageToClient("It is not your turn.")
      rescue => exception
        puts exception 
      end
    end
  end

  def hasFireError(row,col,thisTurnPlayer)
    flag = thisTurnPlayer.gameMap.getPosition(row, col)
    case flag
    when '[ME]'
      return "Suicide Error"
    when '[xx]','[oo]'
      return "Spot Error"
    when '[??]'
      return "No Error"
    end
  end

  def thread
    @thread
  end
  def thread=(th)
    @thread = th
  end
  def clientSocket
    @clientSocket
  end

  def roomNumber
    self.roomNumber
  end
  def roomNumber=(number)
    self.roomNumber = number
  end
  def clientID
    self.clientID
  end
  def clientID=(id)
    self.clientID = id
  end
  def clientName
    self.clientID
  end
  def roomObserver=(ob)
    self.game_room_observer = ob
  end
  def isRoomMaster
    self.isRoomMaster
  end
  def isRoomMaster=(isMaster)
    self.isRoomMaster = isMaster
  end
  def isReady
    self.isReady
  end
  def isReady=(ready)
    self.isReady = ready
  end
end # GameClient End
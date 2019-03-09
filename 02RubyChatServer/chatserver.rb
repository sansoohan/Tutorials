require "socket"
require "thread"

class ChatServer
    def initialize(port)
        @clients = Array::new
        @clientSockets = Array::new
        @serverSocket = TCPServer.new("", port)
        @serverSocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
        printf("ChatServer started on port %d\n", port)
    end
    def run
        while 1
            Thread.start(@serverSocket.accept) do |clientSocket|
                newClient = ChatClient.new(clientSocket, self)
                printf("New Client %s:%s\n",newClient.clientSocket.peeraddr[2], newClient.clientSocket.peeraddr[1])
                @clients.push(newClient)
                begin
                    newClient.run
                rescue Errno::ECONNRESET => e
                    printf("Client Left %s:%s\n",newClient.clientSocket.peeraddr[2], newClient.clientSocket.peeraddr[1])
                    newClient.clientSocket.close
                    @clients.delete(newClient)
                    Thread.current.kill
                end
            end
        end
    end

    def messageController(message)
        messageToEverybody(message)
    end

    def messageToEverybody(message)
        for client in @clients do
            begin
                client.messageToClient(message) 
            rescue => exception
                puts exception
            end
        end        
    end
end

class ChatClient
    def initialize(clientSocket, server)
        @clientSocket = clientSocket
        @server = server
    end

    def messageToClient(message)
        @clientSocket.puts(message)
    end

    def run
        while 1
            message = @clientSocket.gets()
            @server.messageController(message)
        end
    end
    def clientSocket
        @clientSocket
    end
end

myChatServer = ChatServer.new(5000)
myChatServer.run
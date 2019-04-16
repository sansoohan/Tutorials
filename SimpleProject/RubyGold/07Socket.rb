class IO; end
    class BasicSocket < IO; end
        class IPSocket < BasicSocket; end
            class TCPSocket < IPSocket; end
                class TCPServer < TCPSocket; end 
                class SOCKSSocket < TCPSocket; end
            class UDPSocket < IPSocket; end
        class UNIXSocket < BasicSocket; end
            class UNIXServer < UNIXSocket; end
        class Socket < BasicSocket; end

p TCPSocket.superclass.superclass.superclass
p TCPSocket.ancestors
p TCPSocket.ancestors.member?(IO)
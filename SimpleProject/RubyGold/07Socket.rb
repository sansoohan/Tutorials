
class IO < BasicSocket; end
    class IPSocket < BasicSocket; end
        class TCOSocket < IPSocket; end
            class TCPServer < TCPSocker; end 
            class SOCKSSocket < TCPSocket; end
        class UDPSocket < IPSocket; end
    class UNIXSocket < BasicSocket; end
        class UNIXServer < UNIXSocket; end
    class Socket < BasicSocket; end


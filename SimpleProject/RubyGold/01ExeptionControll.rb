class PersonError < StandardError;  end
    class DesignerError < PersonError; end
    class ProgrammerError < PersonError; end

class ComputerError < StandardError; end
    class MemoryError < ComputerError; end
    class CPUError < ComputerError; end


# PersonError Group
whoMessedUp = "programmer"
begin 
    if whoMessedUp == "programmer"
        raise ProgrammerError
    else
        raise DesignerError
    end
rescue PersonError => ex
    puts ex.class
end

# StandardError Group
begin 
    if whoMessedUp == "programmer"
        raise ProgrammerError
    else
        raise DesignerError
    end
rescue StandardError => ex
    puts ex.class
end

begin 
    if whoMessedUp == "programmer"
        raise ProgrammerError
    else
        raise DesignerError
    end
rescue => ex
    puts ex.class
end

# Ignoring other Error Group
begin
    raise ProgrammerError
rescue ComputerError => ex
    puts ex.class
rescue MemoryError => ex
    puts ex.class
rescue CPUError => ex
    puts ex.class
rescue => ex
    puts "ComputerError is ignored"
    puts "MemoryError is ignored"
    puts "CPUError is ignored"
rescue ProgrammerError => ex
    puts "This line is executed"
end
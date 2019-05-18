class Exception; end
    class SystemExit < Exception; end
    class SystemStackError < Exception; end
    class NoMemoryError < Exception; end
    class ScriptError < Exception; end
        class LoadError < ScriptError; end
        class SyntaxError < ScriptError; end
    class StandardError < Exception; end
        class IndexError < StandardError; end
        class RuntimeError < StandardError; end
        class TypeError < StandardError; end
        class ZeroDivisionError < StandardError; end
        class ArgumentError < StandardError; end
        class NameError < StandardError; end
            class NoMethodError < NameError; end

class StandardError; end
    class PersonError < StandardError;  end
        class DesignerError < PersonError; end
        class ProgrammerError < PersonError; end
    class ComputerError < StandardError; end
        class MemoryError < ComputerError; end
        class CPUError < ComputerError; end

p ZeroDivisionError.superclass

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
def makeError(errorType)
    begin
        if errorType == nil
            
        else
            raise errorType
        end
    rescue ComputerError => ex
        puts ex.class
    rescue MemoryError => ex
        puts ex.class
    rescue CPUError => ex
        puts ex.class
    rescue TypeError => exception
        puts "TypeError : #{exception.message}"
    rescue
        puts "ComputerError is ignored"
        puts "MemoryError is ignored"
        puts "CPUError is ignored"
    rescue ProgrammerError => ex
        puts "This line is executed"
    rescue Exception => ex 
        puts ex
    else
        puts "No Error"
    # this excuted after rescue.
    ensure
        puts "Error Checked. Next method should be here."
        puts ""
    end
end

def makeTypeError
    begin
        1+"2"    
    rescue TypeError => exception
        return exception
    end
end

puts ""
makeError(ProgrammerError)
makeError(ComputerError)
makeError(SystemExit)
makeError(nil)
makeError(makeTypeError)




def m
    begin
      1
    rescue
      2
    else
      3 # No Error -> return
    ensure
      4
    end
end
  
p m
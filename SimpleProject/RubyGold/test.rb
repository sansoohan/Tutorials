class Exception; end
    class SystemExit < Exception; end
    class SystemStackError < Exception; end 
    class NoMemoryError < Exception; end 
    class ScriptError < Exception; end
        class LoadEror < ScriptEror; end
        class SyntaxError < ScriptError; end
    class StancdardError < Exception; end
        class IndexError < StandardError; end
        class RuntimeError < StandardError; end
        class TypeError < StancdardError; end
        class ZeroDivisionError < StandardError; end
        class ArgumentError < StandardError; end
        class NameError < StandardError; end
            class NoMethodError < NameError; end


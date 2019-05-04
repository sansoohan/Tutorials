module M
    CONST = "Hello"
    K = 1
    class C
        K = 2
        K2 = 3
        p C.constants
        p M.constants
        p ::M::C::K
        p M::C::K
    end
end
puts ::M::CONST



module ExtendStatic
    def setName(name)
        @name=name
    end
end

module IncludeStatic
    def getName
        @name
    end
end

class Static
    @@objectCount = 0
    def initialize
        @@objectCount += 1
    end
    def Static.objectCount
        @@objectCount
    end
    def self.objectCount2
        @@objectCount
    end
    class << self
        attr_reader :name
        def objectCount3
            @@objectCount
        end
        prepend IncludeStatic
    end
    extend ExtendStatic
end

Static.setName('sansoo')
p Static.name
p Static.getName
p Static.objectCount
p Static.objectCount2
p Static.objectCount3
class ChildStatic < Static
    @@objectCount = 10
end
puts Static.objectCount

# Object Static Function
class Dog; end
dog1 = Dog.new
def dog1.name
    "poodle."
end
p dog1.name

dog2 = Object.new
def dog2.walk
    "dog2 walk."
end
p dog2.walk

class << dog2
    def name
        "chiwawa"
    end
end
p dog2.name


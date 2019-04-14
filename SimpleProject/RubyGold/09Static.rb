module M
    CONST = "Hello"
    def builder
        "builder is good"
    end
    module_function
    def static_builder
        "builder for M"
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
        def objectCount3
            @@objectCount
        end
    end
    extend M
end

puts Static.objectCount
ob1 = Static.new
ob2 = Static.new
puts Static.objectCount
puts Static.objectCount2
puts Static.objectCount3
puts ::M::CONST


class ChildStatic < Static
    @@objectCount = 10
end

puts Static.objectCount
puts Static.builder
puts M.static_builder
begin
    Static.static_builder
rescue NameError => exception
    puts "static_builder is only for M"
end

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


class Object
    class << self
        def name
            "Bull"
        end
    end
end 
Object.name
p Class.ancestors

puts "BasicObject"
p BasicObject.instance_methods(false)
p BasicObject.private_instance_methods(false)
p BasicObject.singleton_methods(false)
puts ""

puts "Kernel"
# You need to know all of Kernel method.
p Kernel.instance_methods(false)
# p Kernel.public_instance_methods(false)
p Kernel.private_instance_methods(false)
p Kernel.singleton_methods(false)
puts ""

puts "Object"
p Object.instance_methods(false)
p Object.private_instance_methods(false)
p Object.singleton_methods(false)
puts ""

puts "Module"
p Module.instance_methods(false)
p Module.private_instance_methods(false)
p Module.singleton_methods(false)
puts ""

puts "Class"
p Class.instance_methods(false)
p Class.private_instance_methods(false)
p Class.singleton_methods(false)
puts ""




class DefineMethodWithString
    {:cat => 'Meow', :dog => 'Wolf'}.each do |name, message|
        define_method(name){"#{name} says #{message}"}
    end
end
p DefineMethodWithString.new.cat

puts ""
class HashMethodize
    def initialize(hash)
        if hash.class == Hash
            hash.each do |name, message|
                self.class.send(:define_method, name){"#{name} says #{message}"}
            end
        end
    end
    def method_missing(method, *args)
        yield if block_given?
        "No method : #{method}"
    end
end
animalData = {:cat => 'Meow', :dog => 'Wolf'}
animal = HashMethodize.new(animalData)
p animal.cat
p animal.dog
p animal.tiger {p "tiger block"}

class ArrayMethodize
    def initialize(array)
        if array.class == Array
            array.each do |name|
                self.class.send(:define_method, name){"#{name}"}
            end
        end
    end
end
fruitData = ['apple','banana']
fruit = ArrayMethodize.new(fruitData)
p fruit.apple
p fruit.banana
p fruit.respond_to?(:apple)


# remove_method, undef_method
module Mod
    def foo
        puts "Mod"
    end
end
class Cls1
    include Mod
    def foo
        puts "Cls1"
        super
    end
end
class Cls2 < Cls1
    def foo
        puts "Cls2"
        super
    end
end

Cls2.new.foo
puts ""
class Cls2
    remove_method :foo
end
Cls2.new.foo

class Cls1
    undef_method :foo
end

begin
    Cls2.new.foo    
rescue => exception
    puts "All of the foo methods are deleted"
end

class Parent
    private
    def foo
        p "foo"
    end
end
class Child < Parent
    def foo
        super # It is little
    end
    private
    def boo
       p 'boo' 
    end
end
Child.new.foo
Child.new.send(:boo)
Child.new.public_send(:foo)


# undef
module ModuleFoo
    def foo 
        
        "module foo" 
    end 
end 
class Foo 
    def foo 
        "foo" 
    end 
end 

class Bar < Foo 
    include ModuleFoo
    def foo 
        super + "bar" 
    end 
    alias bar foo 
    undef foo
end 
puts Bar.new.bar
puts Foo.new.foo
puts Foo.new.send(:foo)
puts Foo.new.send("foo".to_sym)
p :foo.to_s

p Foo.new.respond_to?(:foo)

# What if you have to make method for these all method?
class DS
    def getCpuInfo(workstationID)
        "2.9 Ghz quad-core" if workstationID == 42
    end
    def getCpuPrice(workstationID)
        120 if workstationID == 42
    end    
    def getMouseInfo(workstationID)
        "wireless Touch" if workstationID == 42
    end
    def getMousePrice(workstationID)
        60 if workstationID == 42
    end
    def getDisplayInfo(workstationID)
        "Asus 17 inch" if workstationID == 42
    end
    def getDisplayPrice(workstationID)
        30 if workstationID == 42
    end
end

# making ghost method (meta programming)
class Computer
    def initialize(computerID, dataSource)
        @id = computerID
        @dataSource = dataSource
    end
    def method_missing(name)
        super if !@dataSource.respond_to?("get#{name.capitalize}Info")
        info = @dataSource.send("get#{name.capitalize}Info", @id)
        price = @dataSource.send("get#{name.capitalize}Price", @id)
        result = "#{name.capitalize}: #{info} ($#{price})"
        price >= 100 ? "* "+result : result
    end
end

myComputer = Computer.new(42, DS.new)
p myComputer.cpu
p myComputer.mouse
begin
    p myComputer.keyboard
rescue => exception
    p exception
end


# Kerner#respond_to? call respond_to_missing?
p myComputer.respond_to?(:cpu)
class Computer
    # with this, ghost method is treated real method.
    def respond_to_missing?(name, include_private = false)
        @dataSource.respond_to?("get#{name.capitalize}Info") || super
    end
end
p myComputer.respond_to?(:cpu)



p Object.instance_methods



# If you want to remove Kerner, Object method?
# Extend BasicObject

p myComputer.display
class Computer2 < BasicObject
    def initialize(computerID, dataSource)
        @id = computerID
        @dataSource = dataSource
    end
    def method_missing(name)
        super if !@dataSource.respond_to?("get#{name.capitalize}Info")
        info = @dataSource.send("get#{name.capitalize}Info", @id)
        price = @dataSource.send("get#{name.capitalize}Price", @id)
        result = "#{name.capitalize}: #{info} ($#{price})"
        price >= 100 ? "* "+result : result
    end
end

myComputer = Computer2.new(42, DS.new)
p myComputer.display


def a_method(a,b)
    if block_given?
        1 +yield(a,b,4)
    else
        a+b
    end 
end 
p a_method(2,3){|x,y,z|(x+y+z)}
p a_method(2,3)


# How to bring the variable located in outside of scope?

go_through = "hi"
Through = Class.new do
    puts go_through

    define_method :through do
        puts go_through
    end
end

Through.new.through



# Method makes method
count = 0
send(:define_method ,:method_maker) do
    send(:define_method, :getCount) do
        count
    end
    send(:define_method, :addCount) do
        count+=1
    end
end
method_maker

addCount
p getCount



# Difference in Proc and lambda

def lamb
    return lambda{return 10}.call * 100
end
def proc    
    return Proc.new{return 10}.call * 100
end
p proc
p lamb



# Initialize after initailze
class Target
    @num = 0
    def second_initialize
        self.class.class_eval do
            @num = 1
            def say
                'hi'
            end
            def getNum
                @num
            end
        end
    end
end

target = Target.new
target.second_initialize
p target.say
p target.getNum


puts ""


# Variables
class ClassInstance
    num = 0 # Access from : (Class X Instance X)
    p num
    @num = 10 # Access from : (Class O Instance X)
    @@num = 999 # Access from : (Class O Instance O)
    def self.before_initialize(classNum)        
        @num = classNum
    end

    def self.getClassNum
        @num
    end

    def initialize
        @num = 100 + self.class.getClassNum # Access from : (Class X Instance O)
    end
    def num
        @num
    end
    
end

ClassInstance.before_initialize(100)
p ClassInstance.getClassNum
p ClassInstance.new.num



# Get private instace variable for Fast Debuging.
class Number1
    def initialize
        @num = 10000
    end
end
puts (Number1.new.instance_eval do
    @num
end)


# Get private class variable for Fast Debuging.
class Number2
    @num = 10000000000000
end
puts (Number2.class_eval do
    @num
end)


# Run private class method
class Number2
    private
    def self.getNum
        @num
    end
end
puts (Number2.class_eval do
    getNum
end)


# Run private instance method
class Number1
    private
    def getNum
        @num
    end
end
puts (Number1.new.instance_eval do
    getNum
end)




# Static Variable as Global variable
class BasicObject
    @@v = 1
end
# class Object @@object = "hi"; end
@@object = "hi"

class StaticTest
    @@v = 2
    @@object = "hello"
end
p @@v
p @@object


# Special method
obj = Object.new
singleton_class = class << obj
    self
end

def obj.my_singleton_mtehod; end
p singleton_class.instance_methods.grep(/my_/)


p Class.methods().grep(/eval/)






class Human
    attr_reader :name
    alias original_name name  
    def name
        "Mr. " + original_name
    end
    def initialize(name)
        @name = name
    end
end
  
human = Human.new("Andrew")
puts human.name
class Human
    attr_reader :name   
    def name
        "Mr. " + @name
    end
    def initialize(name)
        @name = name
    end
end
    
human = Human.new("Andrew")
puts human.name
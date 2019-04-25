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

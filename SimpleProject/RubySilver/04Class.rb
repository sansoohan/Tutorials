class Object; end
    module Enumerable; end
        class Array; end
        class Hash; end
    module Comparable; end
        class String; end
        class Numeric; end
            class Float; end
            class Complex; end
            class Rational; end
            class Integer; end
                class Fixnum < Integer; end
                class Bignum < Integer; end

class Integer
    def to_square
        return self * self
    end
end 

p 3.to_square


class Parent
    attr_reader :name
end

class Child < Parent
    def initialize name
        @name = "Child"+name
    end 
end 
p Child.new("Hoge").name

class Object
    def instanceGreeting
        print "instance : How are you?\n"
    end
    private
    def topLeverGreeting
        print "topLever : How are you?\n"
    end
end
[1,2].instanceGreeting
1.instanceGreeting
"hey".instanceGreeting
topLeverGreeting

class Hoge
    p "set Hoge class"
    attr :message
    def initialize
        p "Hoge init"
        @message = "Hoge"
    end
end
class Piyo < Hoge
    p "set Piyo class"
    def initialize
        super
        p "Piyo init"
        @message = "Piyo"
        super # you can call initialize several times.
    end
end
puts Piyo.new.message

# What difference between dup and clone?
s = "?"
def s.greet # Object static method.
    puts "Hi"
end
class String
    def greet
        puts "Hello!"
    end
end
puts ""
s.greet # Object static method is called before class method called.
s.freeze
puts ""
sClone = s.clone
sClone.greet
p sClone.frozen?
puts ""
sDup = s.dup # doesn't copy object static method.
sDup.greet
p sDup.frozen? # doesn't copy object frozen state.


p String.instance_methods
p String.instance_methods.grep(/strip/)

require 'uri'
p URI::HTTP.instance_methods

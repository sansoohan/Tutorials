=begin
[Class8]  
 [Mod7]   <====|(prepend)
 [Mod6]   <====|(include)
[Class5]
 [Mod4]   <====|(prepend)
[Refine3] <====|(using)
[static2] <====|(include)
[static1] <====|(def self.function)
[static0] <====|(prepend)
[Refine0]   X  |(Blocked by Object Static functionh)
=end
module Mod7
    def say
        p 'Mod7'
        super
    end
end

class Class8
    prepend Mod7
    def say
        p 'Class8'
    end
end

module Mod4
    def say
        p 'Mod4'
        super
    end
end

module ModExtraTree
    def say
        p 'ModExtraTree'
        super
    end
end

module Mod6
    def self.append_features(include_class_name) # it is same as initialize
        include_class_name.say_something = 'Class5'
        super # call class5 initialize
    end

    def self.included(include_class_name) # relate with other module
        include_class_name.include ModExtraTree
    end
    def say
        p 'Mod6'
        super
    end
end

class Class5 < Class8
    class << self
        attr_accessor :say_something
    end
    include Mod6
    prepend Mod4
    def say
        p self.class.say_something
        super
    end
end

object = Class5.new

module Refine3
    refine Class5 do
        def say
            p 'Refine3'
            super
        end
    end
end

using Refine3

def object.say
    p 'Static1'
    super
end

module Static2
    def say
        p 'Static2'
        super
    end
end
module Static0
    def say
        p 'Static0'
        super
    end
end

class << object
    prepend Static0
    include Static2
end

module Refine0
    refine Class5 do
        def say
            p 'Refine3'
            super
        end
    end
end
using Refine0

object.freeze

p Class5.ancestors
object.clone.say
p object.clone.frozen?

p Class5.ancestors
object.dup.say
p object.dup.frozen?


module M1; end
module M2; include M1; end
module M3
    prepend M1
    include M2
    module_function
    def static_builder
        'builder for M'
    end
end
p M3.static_builder
p M3.ancestors


module M1;end
module M2;end
class C
    include M1, M2
end
p C.ancestors
class D
    include M1
    include M2
end
p D.ancestors




class Menu
    include Enumerable
    def initialize(array)
        @array = array
    end
    def each
        #@array.each |item| do
        #@array.enum_for.map do |item| # This is important!
        @array.enum_for.map do |item, i|
            yield item
        end
    end
end
menu_option = Menu.new(["pizza","spaghetti","salad","water","bread"])
p menu_option.find{|item| item = "pizza"}
p menu_option.select{|item| item.size <= 5 }
p menu_option.reject{|item| item.size > 5}
p menu_option.first
p menu_option.take(2)
p menu_option.drop(2)
p menu_option.min
p menu_option.max
p menu_option.sort
p menu_option.sort.reverse_each.map{|item| item} # This is important!
p menu_option.sort.reverse.each.map{|item| item} # This is important!
p menu_option.all? {|item| item.size >= 5} # This is important!
p menu_option.any? {|item| item.size >= 10}
p [1,2,3].all? {|num| num > 0 }
p [1,2,3].any? {|num| num > 3 }





class Human
    NAME = "Unknown"  
    def initialize
        @name2 = "Unknown"
    end
    def name
        NAME
    end
    def name2
        @name2
    end
end
  
class Noguchi < Human
    def initialize
        @name2 = "Hideyo"
    end
    NAME = "Hideyo"
end
  
puts Noguchi.new.name
puts Noguchi.new.name2



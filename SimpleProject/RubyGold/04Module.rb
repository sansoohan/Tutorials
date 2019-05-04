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
        p 'mod7'
        super
    end
end
module Mod6
    def say
        p 'mod6'
        super
    end
end
module Mod4
    def say
        p 'mod4'
        super
    end
end
class Class8
    prepend Mod7 #  [Mod7]   <====|(prepend)
    def say
        p 'class8'
    end
end
class Class5 < Class8
    include Mod6 #  [Mod6]   <====|(include)
    prepend Mod4 #  [Mod4]   <====|(prepend)
    def say
        p 'class5'
        super
    end
end
module Refine3
    refine Class5 do
        def say
            p 'refine3'
            super
        end
    end
end
module Static2
    def say
        p 'static2'
        super
    end
end

module Static0
    def say
        p 'static0'
        super
    end
end

module Refine0
    refine Class5 do
        def say
            p 'refine0'
            super
        end
    end
end

something = Class5.new

p Class5.ancestors
something.say

using Refine3 #  [Refine3] <====|(using)

p Class5.ancestors
something.say

class << something
    prepend Static0 #  [static0] <====|(prepend Static0)
    include Static2 #  [static2] <====|(include Static2)
end

def something.say #  [static1] <====|(def self.function)
    p 'static1'
    super
end

p Class5.ancestors
something.say
p something.singleton_methods

using Refine0 #  Object Static function block Refining.

p Class5.ancestors
something.say



=begin
[M2]     <====|(prepend)
[M3]     
[M1]     <====|(include)
=end
module M1; end
module M2
    include M1 # this is not working
end

module M3
    prepend M1
    include M2
    module_function
    def static_builder
        "builder for M"
    end
end

p M3.ancestors
p M3.static_builder


somethingCopied = something.freeze.clone
puts somethingCopied.frozen?

somethingDuplicated = something.freeze.dup
puts somethingDuplicated.frozen?

def foo
    p "?"
end 



# Modifying method

p [1,2,3,4].length
class Array
    alias_method :real_length, :length
    def length
        real_length > 3 ? 'long' : 'short'
    end
end

p [1,2,3,4].length

module StringRefinements
    refine String do
        def length
            super > 5 ? 'long' : 'short'
        end
    end
end

p "hi".length
using StringRefinements
p 'hi'.length

module HashPrepend
    def length
        super > 2 ? 'long' : 'short'
    end
end

p ({:cat => 1}).length
Hash.class_eval do prepend HashPrepend; end
p ({:cat => 1}).length
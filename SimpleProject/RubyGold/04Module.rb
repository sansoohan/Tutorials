=begin
[Class6]  
 [Mod5]   <====|(prepend)
 [Mod4]   <====|(include)
[Class3]
 [Mod2]   <====|(prepend)
[Refine1] <====|(using)
[static0] <====|(def self.function)
=end
module Mod5
    def say
        p 'mod5'
        super
    end
end
module Mod4
    def say
        p 'mod4'
        super
    end
end
module Mod2
    def say
        p 'mod2'
        super
    end
end
class Class6
    prepend Mod5
    def say
        p 'class6'
    end
end
class Class3 < Class6
    include Mod4
    prepend Mod2
    def say
        p 'class3'
        super
    end
    # refine and static method is not working inside the class
    # prepend still work inside the class
    def saysay
        p self.say 
        super
    end 
end
module Refine1
    refine Class3 do
        def say
            p 'refine1'
            super
        end
    end
end
module Refine0
    refine Class3 do
        def say
            p 'refine1'
            super
        end
    end
end

something = Class3.new
p Class3.ancestors
something.say

using Refine1
p Class3.ancestors
something.say

def something.say
    p 'static0'
    super
end
p Class3.ancestors
something.say
using Refine1

p Class3.ancestors
p Class3.new.saysay

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
end

p M3.ancestors



somethingCopied = something.freeze.clone
puts somethingCopied.frozen?

somethingDuplicated = something.freeze.dup
puts somethingDuplicated.frozen?

def foo
    p "?"
end 
class VeryHard1
    foo
    def go
        foo
    end
    def foo
        p "foo"
    end
end
VeryHard1.new.foo
class VeryHard2
    attr_accessor :foo
    foo # this is not used as instance variable
    def foo= x
        foo = x
    end
    # def foo # because of this attr :foo is removed
    #     p "foo"
    # end            
end
hard = VeryHard2.new
hard.foo = 3
p hard.foo





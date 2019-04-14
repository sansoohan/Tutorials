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


puts ""
module M1
end
module M2
end
class C1
    include M1
end
class C2 < C1
    p self.ancestors
    include M2
end

# refine outside of class: using module
class C
    def hoge
        puts "hoge"
    end
    def roge
        puts "hoge" 
    end
end
module M
    refine C do
        def roge
            puts "roge"
        end
    end
end
c = C.new
c.hoge
using M
c.roge
c.hoge
puts ""

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

=begin
[Class4]  (prepend)
 [Mod3]  <====|
 [Mod2]  <====|
[Class1]  (include)
=end
module Mod3
    def say
        p 'mod3'
        super
    end
end
module Mod2
    def say
        p 'mod2'
        super
    end
end
class Class4
    prepend Mod3
    def say
        p 'class4'
    end
end
class Class1 < Class4
    include Mod2
    def say
        p 'class1'
        super
    end
end
something = Class1.new
something.say
p Class1.ancestors

somethingCopied = something.freeze.clone
puts somethingCopied.frozen?

somethingDuplicated = something.freeze.dup
puts somethingDuplicated.frozen?

module M
    def hoge
        puts "hoge M"
    end
end

class A
    prepend M
    def hoge
        puts "hoge A"
    end
end
A.new.hoge # It seems A but, it is acting like M because of prepend.
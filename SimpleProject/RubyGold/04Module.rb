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
    remove_method :foo # undef
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

class C
    def hoge
        puts "hoge"
    end
end
module M
    refine C do
        undef hoge
        def roge
            puts "roge"
        end
    end
end
c = C.new
c.hoge
using M
c.roge
begin
    c.hoge    
rescue => exception
    puts "There is no hoge anymore."
end

puts ""


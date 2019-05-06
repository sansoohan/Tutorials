x, *y = *[1,2,3],4
p x,y

x, *y = [1,2,3],4
p x,y

def hoge (x,y,*params)
    puts ''
    p x,y,params
end


hoge(*[1,2,3],4)
hoge([1,2,3],4)

puts ''
begin
    hoge(1)
rescue ArgumentError => exception
    p exception
end

puts ''
def hoge2 (x:, y:2, **params)
    p "#{x}, #{y}, #{params}"
end
hoge2(x:1, a:3, b:4)

def tag(name,&block) # closure
    closed = 'sansoo' if name == :p # closed variable
    puts "<#{name}>#{block.call(closed)}</#{name}>" # real function
end

def tag(name)
    closed = 'sansoo' if name == :p
    puts "<#{name}>#{yield(closed)}</#{name}>"
end

tag(:p) {"Hello World!"}
tag(:p) do "Hello World!" end

tag(:p) do |a| "Hello #{a}!" end
tag(:p, & Proc.new {|a|"Hello #{a}!"})
tag(:p, & -> (a){"Hello #{a}!"})
tag(:p, & lambda{|a| "Hello #{a}!"})
begin
    tag(:p, & -> {'Hello World!'})    
rescue ArgumentError => exception
    puts exception
end
tag(:p, & Proc.new {'Hello World!'})



def someArray(*arg)
    return *arg
end
p someArray([1,2,3]) # [[1,2,3]]
p someArray(*[1,2,3]) # [1,2,3]
p someArray(1,2,3)
p [1,2,3]
p *[1,2,3]




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
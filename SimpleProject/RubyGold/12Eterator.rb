class Menu
    include Enumerable
    def initialize(array)
        @array = array
    end
    def each
        @array.each do |item|
            yield item
        end
    end
end
menu_option = Menu.new(["pizza","spaghetti","salad","water","bread"])
p menu_option.find{|item| item = "pizza"}
p menu_option.select{|item| item.size <= 5 }
p menu_option.reject{|item| item.size <=5}
p menu_option.first
p menu_option.take(2)
p menu_option.drop(2)
p menu_option.min
p menu_option.max
p menu_option.sort
p menu_option.sort.reverse_each.map{|item| item}
p menu_option.all? {|item| item.size >= 5}
p [1,2,3].all? {|num| num > 0 }
p [1,2,3].any? {|num| num > 3 }

puts ""

proc = Proc.new {|x,y|
    p x
    p y
}

proc.call(1)

lmd = -> (x,y){
    p x
    p y
}
begin
    lmd.call(1)
rescue => exception
    p "lambda has to have all parameters"
end


1.upto(3) do |i| p i end
1.upto(3) { |i| p i }
1.upto 3 do |i| p i end


def tag(p, &block)
    if block_given?
        p "<#{p}>#{block.call}</#{p}>"
    else
        p "no block"
    end
end

tag(:p)
tag(:p){"Hello World."}

class Number
    attr_accessor :num
    def << (num)
        @num = num
    end
end

num1 = Number.new
num1 << 1
p num1.num


def someArray(*arg)
    return *arg
end
p someArray([1,2,3]) # [[1,2,3]]
p someArray(*[1,2,3]) # [1,2,3]
p someArray(1,2,3)
p [1,2,3]
p *[1,2,3]
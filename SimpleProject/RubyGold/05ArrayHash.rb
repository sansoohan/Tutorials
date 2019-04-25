someArray = []
someArray << 1
someArray.push(2)
p someArray

readOnlyArray = [1,2,3].freeze
begin
    readOnlyArray.push(4)
    p readOnlyArray
rescue => exception
    puts "Can't push"
end

begin
    readOnlyArray << 4
    p readOnlyArray
rescue => exception
    puts "Can't <<"
end

begin
    readOnlyArray += [4]
    p readOnlyArray
rescue => exception
    puts "Can't +="
end

readOnlyArray += [4,5]



p readOnlyArray
readOnlyArray[4] = 10
readOnlyArray[1] = 20
p readOnlyArray[1]
p readOnlyArray[4]



%r|(http://www(¥.)(.*)/)| =~ "http://www.abc.com/"
p $0, $1, $2, $3

p [1,2,3].map{|x| x**2}
p [1,2,3].collect{|x| x**2}
p [1,2,3].inject([]){|x,y|x<<y**2}

puts ""
p (1..3).inject(0){|x,y|x+y**2}
p [1,2,3].inject{|x,y|x+y**2}


alphabet = Array.new(3,"a")
alphabet[0].next!.next!
p alphabet
p "a".next!
p "abz9".next!
p "abz9".next!

class MyNum
    attr :num
    def initialize(num)
        @num = num
    end
    def <=> (otherNum)
        @num <=> otherNum.num
    end
end
numbers = [MyNum.new(1), MyNum.new(3), MyNum.new(2) ]
p numbers.sort
p numbers.sort.map{|n| n.num}

class MyNum
    undef_method :<=>
end
p numbers.sort(& -> (a,b){a.num<=>b.num})
p numbers.sort(& -> (a,b){a.num<=>b.num}).map{|n| n.num}

# class static method
p Array.methods.grep(/^re/)
# class instance method
p Array.instance_methods.grep(/^re/)
p [].methods.grep(/^re/)
# ignore superclass method
p Array.instance_methods(false).grep(/^re/)
p MyNum.new(1).instance_variables



p Module.instance_methods(false)
p Class.instance_methods(false)
p Kernel.private_instance_methods.grep(/^sp/)
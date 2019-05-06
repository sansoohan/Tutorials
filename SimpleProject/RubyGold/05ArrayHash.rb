someArray = []
someArray << 1
someArray.push(2)
p someArray

readOnlyArray = [1,2,3].freeze
begin
    readOnlyArray.push(0)
rescue => exception
    puts 'can\'t push'
end
begin
    readOnlyArray << 2
rescue => exception
    puts 'can\'t push'
end

readOnlyArray += someArray
readOnlyArray[6] = 10
p readOnlyArray

p [1,2,3].map{|x| x**2}
p [1,2,3].collect{|x| x**2}
p [1,2,3].inject([]){|x,y| x << y**2}


p (1..3).inject(0){|x,y| x+y**2}
p [1,2,3].inject{|x,y| x+y**2}

alphabet = Array.new(3,"a")
alphabet[0].next!
p alphabet
p "a".next!

class MyNum
    attr :num
    def initialize(num)
        @num = num
    end
    def <=> (otherNum)
        @num <=> otherNum.num
    end
end

numbers = [MyNum.new(1),MyNum.new(3),MyNum.new(2)]
p numbers.sort
p numbers.sort.map{|n| n.num}

class MyNum
    undef_method :<=>
end
p numbers.sort{|a,b| a.num <=> b.num}
p numbers.sort(& -> (a,b){a.num <=> b.num})

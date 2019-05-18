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



CONST_LIST_A = ['001', '002', '003']
begin
  CONST_LIST_A.map{|id| id << 'hoge'}
rescue
end

CONST_LIST_B = ['001', '002', '003'].freeze
begin
  CONST_LIST_B.map{|id| id << 'hoge'}
rescue
end

CONST_LIST_C = ['001', '002', '003'].freeze
begin
  CONST_LIST_C.map!{|id| id << 'hoge'}
rescue
end

CONST_LIST_D = ['001', '002', '003'].freeze
begin
  CONST_LIST_D.push('add')
rescue
end

p CONST_LIST_A
p CONST_LIST_B
p CONST_LIST_C
p CONST_LIST_D


require('yaml')
yamlArray = <<-Data
- aaa
-
  - b1
  -
    - b3.1
- ccc
Data

p YAML.load(yamlArray)

yamlHash = <<-Data
A: aaa
B:
  B1: b1
  B2: b2
C: c2
Data
p YAML.load(yamlHash)



# Class Closure : Sharing variable
module Closure
    name = 'han' # 
    Animal = Class.new do # class Animal
        p name
        def initialize(a)
        @a = a
        end
        
        def method1()
        @a
        end
    end

    Dog = Class.new(Animal) do # class Dog < Animal
        p name
        def initialize(a, b)
        @b = b
        super(a)
        end
        
        def method2(c)
        @a + @b + c
        end
    end
    
    dog = Dog.new("hello", " world")
    dog.method2(" !!") #=> "hello world !!"
end

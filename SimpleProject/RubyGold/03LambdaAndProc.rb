say = -> (x){puts "#{x} World!"}
say.call("Hello")

var = lambda { puts "hello" }
p var.class

puts ""
hello = Proc.new do |name|
    puts "Hello #{name}"
end
hello.call("World!")

def counter
    c = 0
    Proc.new do
        c += 1
    end 
end
c1 = counter
p c1.call
p c1.call
p c1.call

require 'test/unit'
class TC_Foo < Test::Unit::TestCase
    def test_foo
        assert_equal(1,1)
    end
    def test_bar
        assert_true(true)
    end 
    def foo
        
    end
    def bar
    end
end
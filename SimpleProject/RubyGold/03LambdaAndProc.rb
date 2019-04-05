say = -> (x){puts "#{x} World!"}
say.call("Hello")

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
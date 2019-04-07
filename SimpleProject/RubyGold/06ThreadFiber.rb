f = Fiber.new do
    while 1 do
    puts 'Hello1'
    puts Fiber.yield
    puts 'Hello4'
    end
end 

f.resume
f.resume("Hello2", "Hello3")
f.resume
f.resume

puts ""
t1 = Thread.new do
    while 1 do
        puts "Thread New Hello"
        Thread.current.stop
    end
end
t1.run
t1.wakeup

t2 = Thread.start do
    while 1 do
        puts "Thread Start Hello"
        Thread.current.stop
    end
end

t1.kill
t2.kill

# ruby -d 06ThreadFiber.rb
Thread.start do
    raise ThreadError
end
sleep
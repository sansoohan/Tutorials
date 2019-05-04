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



require 'concurrent'
c1 = Concurrent::Promise.new{10}.then{|x| x * 2}.then{|result| result - 10 }.execute
p c1.value

class Crawler
    attr_accessor :nodeJS
    def initialize
        @nodeJS = NodeJS.new
    end
    def visit(url)
        Concurrent::Promise.new{@nodeJS}
        .then{|nodeJS|
            nodeJS.sendUrl(url)
        }
    end
    class NodeJS
        attr_accessor :body, :url
        def sendUrl(url)
            @url = url
            self
        end
        def getBody
            @body = @url*2
            self
        end
    end
end
crawler = Crawler.new
node = crawler.visit('www.naver.com')
.then{|nodeJS|
    # while nodeJS.url.nil? do; end
    nodeJS.getBody
}
.execute
p node.value.body
p crawler.nodeJS.body



# ruby -d 06ThreadFiber.rb
Thread.start do
    raise ThreadError
end
sleep
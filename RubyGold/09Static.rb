module M
    def builder
        "builder is good"
    end
end

class Static
    @@objectCount = 0
    def initialize
        @@objectCount += 1
    end
    def Static.objectCount
        @@objectCount
    end
    extend M
end

puts Static.objectCount
ob1 = Static.new
ob2 = Static.new
puts Static.objectCount

class ChildStatic < Static
    @@objectCount = 10
end

puts Static.objectCount
puts Static.builder


x, *y = *[1,2,3]
p x, y

def hoge (x, y, *params)
    p x, y, *params
end

puts ""
hoge(1,2)

puts ""
hoge(1,2,3)

puts ""
hoge(1,2,3,4)

puts ""
begin
    hoge(1)
rescue => exception
    p "You need two parameters at least"
end

puts ""

def hoge2 (x:, y: 2, **params)
    p "#{x}, #{y}, #{params.values}"
end
hoge2(x:1, z:3)
hoge2(x:1, y:10, z:3)
hoge2(x:1, y:10, z:3, k:7)
puts ""

def hoge3(x:, y:2 , **params)
    p x
    p y
    p params
end
hoge3(x:1, z:10000)

def tag(name, &block)
    puts "<#{name}>#{block.call}</#{name}>"
end
tag(:p) {"Hello, World."}
tag(:p) do "Hello, World." end
tag(:p, & -> {"Hello, World."})


def tag(name)
    puts "<#{name}>#{yield}</#{name}>"
end
tag(:p) {
    "Hello, World."
}
tag(:p) do
    "Hello, World."
end
tag(:p, & -> {
    "Hello, World."
})
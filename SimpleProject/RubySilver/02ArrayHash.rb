def area1 r
    include Math
    return r * r * PI
end

def area2 r
    return r * r * Math::PI
end

p area2(3)
p area1(3)

p [1,2,3,4][1,3]
p [1,2,3,4][1...3]
p [1,2,3,4][1..3-1]

p [1,2,3,4][-1]
p [1,2,3,4][1,-1]
p [1,2,3,4][1..-1]
p [1,2,3,4][1...-1]

p [1,2,3,4].map{ |num| num+2 }
p [1,2,3,4].collect{ |num| num+2 }

a1 = %w(a b).zip(%w(x y))
p a1
p a1.first
p a1.last

a2 = %r(1 2)
p a2

p [1,2,3,4].slice(1,2)


# In Array Calculation, it creates new array.
a = [1,2,3]
b = [1,3,5]
c = a
a = a & b
b = b - a
p a + b + c

# Array has a reference.
puts ""
foo = [1,2,3]
bar = foo
baz = foo.dup
bar[3] = 4
p foo
p bar
p baz

p false&&"One"
p true&&"One"
p false||"One"
p true||"One"


p [1,2,3].delete_if {|a| a==2}
p [1,2,3].delete_if {|a| a==4}

p [1,2,3].reject! {|a| a==2}
p [1,2,3].reject! {|a| a==4}

["a","b","c"].each_with_index {|ob, i| puts "#{i}:#{ob}"}
p [1,2,3].unshift
p [1,2,3].unshift(0)
a = [1,2,3]
a.unshift(0)
p a

puts ""
p [1,2,3,nil,3].concat([4,5,6])
a = [1,2,3,nil,3]
a.concat([4,5,6])
p a

puts ""
p [1,2,3,nil,3].uniq
a = [1,2,3,nil,3]
a.uniq
p a

puts "" 
p [1,2,3,nil,3].compact
a = [1,2,3,nil,3]
a.compact
p a

p [1,2,3].find {|a| a>1} 
p [1,2,3].detect {|a| a>1}

p [1,2,3,4].find_all {|num| num>2 }
p [1,2,3,4].select { |num| num>2 }

a = [1,2,3]
b = [4,5,6]
p [a,b]
p [a,b].each{|x,y,z| [x,y,z]}
p [a,b].each{|x| x}
p [a,b].transpose

a = {:a => 1, :b => 2}
p a.invert
p a

p a.reject {|x,y| y<2}
p a


a = {"Foo" => "Hoge", "Bar" => "Piyo", "Baz" => "Fuga"}
# Hash To Array
p a.map{|x,y| [x,y] }
# Array To Hash
p Hash[a.map{|x,y| [x,y]}]

def print_key(hash)
    hash.map {|x,y| x}
end
p print_key(a)


p a
p a.sort{|x,y| x[1] <=> y[1]}
p a.sort{|x,y| x[0] <=> y[0]}

puts ""
a.delete("Foo")
p a 
p a.fetch("Bar")
p [1,2,3].clear
a.clear
p a
a.update({"Foo" => "hoge", "Bar" => "piyo", "Baz" => "fuga"})
p a
puts ""

p "123\r\n"
p "123\r\n".chop

odd = [1,3,5]
even = [2,4,6]
num = odd + even
p num.sort

cc = {"nz"=>"New Zealand", "ru"=>"Russia", "ar"=>"Argentina"}
p cc.has_key?('nz')
p cc.key?('nz')
p cc.include?('nz')
p cc.member?('nz')

s1 = "To be or not to be, that is the question."
hash = Hash.new(0)
s1.scan(/\w+/) {|i| hash[i] += 1}
p hash
p hash["be"] #=>2


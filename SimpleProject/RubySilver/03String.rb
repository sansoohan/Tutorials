p "a".encoding.name

p "abc"=="abc"
p "abc".eql?("abc")
p "abc".equal?("abc")
p "abc"==="abc"

p "hi"*5
class String
    def * (num)
        return self if num == 1
        self + self*(num-1)
    end
end
p "hi"*5

p true || (raise "failed")
p false && (raise "failed")

p "school".gsub("ool","edule")
p "school".gsub("oul","edule")
p "school".gsub!("oul","edule")
p "school".gsub!("ool","edule")

p ?A + ?d + ?d

p "12ab34".to_i

p [1,2,3].join(":")
p "a\\b.c\\d.e".split(/\\|\./)
p "a\\b.c\\d.e".slice(/\\.../)
def hello
    s = <<EOB
    Hello
EOB
end

p hello

a = "hello"
p a.upcase
p a
p "123:456:".index(":",2)
p "123:456:".index(":",4)

print "hello \n".chomp
print "world3".chop
puts "!".chomp

a = "hello world!"
a.chop.chop
puts a

a = "012abc89-"
p a.delete("^1-8-")
p a.delete("1-8-")
puts "Ruby on Rails".delete("Rails")
puts "Ruby on Rails".delete("^Rails")

p "123abc" =~ /^[a-z]/
p "123abc" =~ /^[a-z]*/
p "123abc" =~ /^[0-9]/
p "123abc" =~ /^[0-9][0-9]*/

# Regular expression i option
# doesn't care it is upper or lower letter.
p "Hello"[/^[hc].*o$/i]
p "Cello"[/^[hc].*o$/i]


# Slice the word
# from [first index] to [last index]
p "abc def 123 ghi 456"[/[\d]+[^\d]+/]
p "abc def 123 ghi 456"[/[a-z]+[^0-9]+/]

# find
p "abc def 123 ghi 456"[/\d+/]

# select
p "abc def 123 ghi 456".scan(/\d+/)

p 65.chr
p "A".ord

str = "a,b,c,d"

# How many do you want to split?
p str.split(/,/, 2)
p str.split(/,/, 3)

p "a".upto("g").to_a
p "a".upto("g").map{|word| word}
p "a".upto("g").inject(""){|word,chr| word += chr}

s = <<"EOL"
gogo1
EOL
puts s 
s = <<-EOL
gogo2
    EOL
puts s

member = [10,"Tanaka"]
print "|ID  :%10d |Name:%10s|" % member
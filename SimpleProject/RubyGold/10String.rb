require "yaml"
dir = <<-EOY
file1:
    name: app.rb
    data: ruby
    EOY
p YAML.load(dir)

require 'json'
h = { "a" => 1, "b" => 2}
p h.to_json
p JSON.dump(h)

class Person
    def initialize(name)
        @name = name
    end
    def inspect # p
        @name
    end
    def to_s # print puts
        @name
    end
    def to_str # String#+ call this method
        @name
    end
end

p Person.new("Han")
puts Person.new("Han")
print Person.new("Han")
print 'Sansoo'+Person.new("Han")


puts ""




%r|(http://www(\.)(.*)/)| =~ "http://www.abc.com/"
p $0, $1, $2, $3



name ='Andy'
case name
when /Andy|Bob/ # /Andy|Bob/~=(name)
    p name
else
    p "who are you?"
end

age = '14'
case age
when 0..12 # (0..12).include?(age)
    p 'You are a child.'
when 13 # 13 == 13
    p 13
when '14' # '14' == '14'
    p '14'
else
    p 'You are an adult.'
end

case 1
when Fixnum # Fixnum === 1
    p 'Fixnum'
when String
    p 'string'
end



# https://rubular.com/

p 'RubyProgram' =~ /Prog./
while DATA.gets do
    puts $_ if $_ =~ /Ruby/
end
__END__
Java Programing
Ruby Programing
C Programing
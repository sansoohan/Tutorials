require "yaml"
dir = <<-EOY
file1:
    name: app.rb
    data: ruby
    EOY
p YAML.load(dir)

require 'json'
h = { "a" => 1, "b" => 2}
puts h.to_json
puts JSON.dump(h)

class Person
    def initialize(name)
        @name = name
    end
    def inspect
        @name
    end
end

p Person.new("Han")

puts ""

# https://rubular.com/
p "hi123"["hi123" =~ /(\d)+/]
p "hello world!"[("hello world!" =~ /(\A)/)..("hello world!" =~ /(\s)/)-1]
p "hello world!"[("hello world!" =~ /(\S)orld/)..("hello world!" =~ /(\z)/)]
p "hi 123 456"[("hi 123 456" =~ /(\s)123/)+1..("hi 123 456" =~ /(\s)456/)-1]
p "http://vareal.co.jp/"[("http://vareal.co.jp/" =~ /:\/{2}/)+3..("http://vareal.co.jp/" =~ /[a-z]\/|(\z)/)]

puts 'RubyProgram' =~ /Progrem/
while DATA.gets do
    puts $_ if $_ =~ /Ruby/
end
__END__
Java Programing
Ruby Programing
C Programing

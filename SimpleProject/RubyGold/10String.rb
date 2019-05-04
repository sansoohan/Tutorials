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
    def inspect
        @name
    end
end

p Person.new("Han")

puts ""

# https://rubular.com/

p 'RubyProgram' =~ /Prog./
while DATA.gets do
    puts $_ if $_ =~ /Ruby/
end
__END__
Java Programing
Ruby Programing
C Programing

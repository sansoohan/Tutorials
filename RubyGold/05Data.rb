require "yaml"

dir = << EOY
file1:
    name: app.rb
    data: ruby
EOY

p YAML.load(dir)


someArray = []
someArray << 1
someArray.push(2)
p someArray

%r|(http://www(¥.)(.*)/)| =~ "http://www.abc.com/"
p $0, $1, $2, $3

p [1,2,3].map{|x| x**2}
p [1,2,3].collect{|x| x**2}
p [1,2,3].inject([]){|x,y|x<<y**2}

puts ""
p (1..3).inject(0){|x,y|x+y**2}
p [1,2,3].inject{|x,y|x+y**2}


alphabet = Array.new(3,"a")
alphabet[0].next!.next!
p alphabet
p "a".next!
p "abz9".next!
p "abz9".next!






puts 'RubyProgram' =~ /Progrem/
while DATA.gets do
    puts $_ if $_ =~ /Ruby/
end
__END__
Java Programing
Ruby Programing
C Programing
puts 1.class
puts 1.123456789.class
puts "power".class

PI = 3.14
puts PI


Dir.mkdir('userInfo') unless File.exists?('userInfo')
File.new("userInfo/userPrivacy.txt","w") unless File.exist?("userInfo/userPrivacy.txt")
write_handler = File.new("userInfo/userPrivacy.txt","w")
write_handler.puts('1')
write_handler.puts('2')
write_handler.close
for lineData in File.open("userInfo/userPrivacy.txt","r") do
  print lineData
end
write_handler = File.new("yourSum.out","w")
write_handler.puts("Random Text").to_s
write_handler.close

date_from_file = File.read("yourSum.out")
puts date_from_file

age=12

if(age>=5)&&(age<6)
  puts "You're in Kindergarten"
elsif(age>=7) && (age<13)
  puts "You're in Middle School"
  puts "Yeah"
else
  puts "Stay Home"
end

unless age>4
  puts "No School"
else
  puts "Go to School"
end

puts (age>50)?"Old":"joung"

i = 0
loop do
  i+=1
  next unless (i%2)==0
  puts i
  break if i>10
end

j=0
while j<10
  j+=1
  next unless (j%2)==0
  puts j
end

k=0
until k==10
  k+=1
  next unless (k%2)==0
  puts k
end

numbers =[1,2,3,4]
for each in numbers
  puts "#{each},"
end
groceries=["bananas","sweet potatos","pasta","tomato"]
for each in groceries
  print "#{each},"
end

groceries.each do |food|
  puts "Some #{food}"
end

(0..5).each do |num|
  print num
end

puts "Add Them #{4+5}"
puts 'Add Them #{4+5}'

title = "Title1"
puts title.count("^aeiou").to_s
multiline_string = <<EOM
<div>
  <h1>#{title}</h1>
    <p>Paragraph</p>
</div>
EOM
puts multiline_string


=begin
Multiline Comment
=end

load "Tutorial01.rb"

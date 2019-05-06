print "Enter a Value"
first_num = gets.to_i
print "Enter Another Value :"
second_num = gets.to_i
puts first_num.to_s+"+"+second_num.to_s+"="+(first_num+second_num).to_s
puts "6+4="+(6+4).to_s

big_float = 1.12345678901234
puts (big_float+0.12345678901234).to_s

greeting = gets.chomp
case greeting
  when "French", "french"
    puts "Bonjuor"
    exit
  when "Spanish","spanish"
    puts "Hola"
    exit
  else
    puts "Hello"
end

def devide(num1,num2)
  begin
    raise ArgumentError, "Invalid value" if num2==0
    answer = num1/num2
  rescue
    puts "You can't divide by zero"
    exit
  end
  return answer
end
puts devide(3,2)

def check_age(age)
  raise ArgumentError, "Invalid value" if age <= 0
end

begin
  check_age(-1)
rescue ArgumentError
  puts "That is an impossible"
end

first_name = " SanSoo"
last_name = "Han "
full_name = "#{first_name} #{last_name}"
puts "\"a\".equals?(\"a\") : " + ("a".equal?"a").to_s
puts first_name.equal?first_name.to_s
puts full_name.upcase
puts full_name.downcase
puts full_name.swapcase
puts full_name.lstrip
puts full_name.rstrip

puts full_name.rjust(20,'.')
puts full_name.ljust(20,'.')
puts full_name.center(20,'.')
puts full_name.chop.chop
puts full_name.chomp('an ')

puts full_name.delete("a")
puts full_name.split(//)
puts full_name.split(/ /)

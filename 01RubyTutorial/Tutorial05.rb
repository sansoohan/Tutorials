# require_relative "Mo01"
# require_relative "Mo02"

# module Animal
#   def make_sound
#     puts "Grrr"
#   end
# end

# class Dog
#   include Animal
# end

# rover = Dog.new
# rover.make_sound

# class Scientist
#   include Human
#   prepend Smart
#   def act_smart
#     return "E = mc  ^2"
#   end
# end

# einstein = Scientist.new
# einstein.name = "Albert"
# einstein.run
# puts einstein.name + " says " + einstein.act_smart

# class Bird
#   def tweet(birt_type)
#     birt_type.tweet
#   end
# end

# class Cardinal < Bird
#   def tweet
#     puts "Tweet tweet"
#   end
# end

# class Parrot < Bird
#   def tweet
#     puts "Squawk"
#   end
# end

# generic_bird = Bird.new
# generic_bird.tweet(Cardinal.new)
# generic_bird.tweet(Parrot.new)

# Array_1 = Array.new
# Array_2 = Array.new(5)
# Array_3 = Array.new(5,"empty")
# Array_4 = [1,"two",3,5.5]

# puts Array_1
# puts Array_2
# puts Array_3[2,2].join(",")
# puts Array_4.values_at(0,1,3).join(",")
# Array_4.unshift("head")
# Array_4.push("tail1","tail2")
# Array_4.pop()
# Array_4.concat(Array_3)
# puts Array_4.join(",")
# puts Array_4.include?"tail1"
# puts Array_4.empty?

# Array_4.each do |value|
#   printf("%s,",value)
# end

require_relative "Mo01"
require_relative "Mo02"

module Animal
  def make_sound
    puts "Grrr"
  end
end

class Dog
  include Animal
end

rover = Dog.new
rover.make_sound

class Scientist
  include Human
  prepend Smart
end

einstein = Scientist.new
einstein.name = "Albert"
einstein.run
puts einstein.name + " says "+ einstein.act_smart

class Bird
  def tweet(bird_type)
    bird_type.tweet
  end
end

class Cardinal < Bird
  def tweet
    puts "Tweet Tweet"
  end
end

class Parrot < Bird
  def tweet
    puts "Squawk"
  end
end

generic_bird = Bird.new
generic_bird.tweet(Cardinal.new)
generic_bird.tweet(Parrot.new)

Array_1 = Array.new
Array_2 = Array.new(5)
Array_3 = Array.new(5,"empty")
Array_4 = [1,"two",3,4,5]

puts Array_1
puts Array_2
puts Array_3
puts Array_4

puts Array_3[2,2].join(',')
puts Array_4.values_at(0,1,3).join(',')
puts Array_4.join(',')
puts Array_4.unshift("head").join(',')
puts Array_4.push("tail").join(',')
Array_4.pop(); puts Array_4.join(',')
puts Array_4.concat(Array_3).join(',')
puts Array_4.include?('empty')
puts Array_4.empty?

Array_4.each do |value|
  printf("%s, ", value)
end
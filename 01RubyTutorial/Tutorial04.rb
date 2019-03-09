class Animal
  def initialize
    puts "Creating a New Animal"
  end
  def set_name(new_name)
    @name = new_name
  end
  def get_name
    @name
  end
  def name
    @name
  end
  def name=(new_name)
    if new_name.is_a?(Numeric)
      puts "Name Can't Be a Number"
    else
      @name = new_name
    end
  end
end


cat = Animal.new
cat.set_name("Peekaboo")
puts cat.get_name
puts cat.name
cat.name = "Sophie"
puts cat.name

class Dog
  attr_reader :name, :height, :weight
  attr_writer :name, :heigth, :weight
  attr_accessor :name, :height, :weight
  def bark
    return "Generic Bark"
  end
end

class GermanShepard < Dog
  def bark
    return "Loud Bark"
  end
end

rover = Dog.new
rover.name = "Rover"
printf "%s goes %s \n", rover.name, rover.bark

max = GermanShepard.new
max.name = "Max"
printf "%s goes %s \n", max.name, max.bark

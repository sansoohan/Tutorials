number_hash = {"PI"=>3.14, "Golden"=>1.618, "e"=>2.718}
puts number_hash["PI"]

superheroes = Hash["Clark Kent","Superman","Bruce Wayne","Batman"]
puts superheroes["Clark Kent"]
superheroes["Barry Allen"] = "Flash"
samp_hash = Hash.new("No Such Key")
puts samp_hash["Dog"]

superheroines = Hash["Lisa Morel","Aquagril","Betty Kane","Batgirl"]
superheroes.update(superheroines)
superheroes.each do |key,value|
  puts key.to_s + ":" +value
end

puts "Has Key Lisa Morel : " + superheroes.has_key?("Lisa Morel").to_s
puts "Has Value Betman : " + superheroes.has_value?("Batman").to_s
puts "Is Hash Empty : " + superheroes.empty?.to_s
superheroes.delete("Barry Allen")
puts "Size of Hash : " + superheroes.size.to_s

class Menu
  include Enumerable
  def each
    yield "pizza"
    yield "spaghetti"
    yield "salad"
    yield "water"
    yield "bread"
  end
end
menu_option = Menu.new
menu_option.each do |item|
  puts "would you like : #{item}"
end
p menu_option.find{|item| item = "pizza"}
p menu_option.select{|item| item.size <= 5 }
p menu_option.reject{|item| item.size <=5}
p menu_option.first
p menu_option.take(2)
p menu_option.drop(2)
p menu_option.min
p menu_option.max
p menu_option.sort
menu_option.reverse_each{|item| puts item}

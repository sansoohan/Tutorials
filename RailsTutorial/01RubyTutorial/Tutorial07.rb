file = File.new("authors.out","w")
file.puts "a"
file.puts "b"
file.puts "c"
file.puts "d"
file.close
puts File.read("authors.out")

file = File.new("authors.out","a")
file.puts "e"
file.close

file2 = File.new("authors_info.out","w")
file2.puts "William Shakespeare,English,plays and poetry"
file2.puts "Agatha Cristie,English,who done its"
file2.close

File.open("authors_info.out") do |record|
  record.each do |item|
    name,lang,specialty = item.chomp.split(',')
    puts "#{name} was a #{lang} author that specialized in #{specialty}."
  end
end

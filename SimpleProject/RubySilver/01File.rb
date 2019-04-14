# coding: us-ascii
p "a".encoding.name

# warning
MAX = 10
MAX = 100

# write only
    # Delete all contents in the file
    open("test.txt","w") do |f|
        f.write("banana\ngirl1")
    end
    # Doesn't delete any contents in the file
    open("test.txt","a") do |f|
        f.rewind
        f.write("banana\ngirl2")
    end

# read only
    open("test.txt","r") do |f|
        data = f.read.chomp
        p data.reverse!
    end
    open("test.txt") do |f|
        lines = f.readlines
        0.upto(lines.length-1) do |i|
            p lines[i]
        end
        puts ""
        f.rewind
        while (line = f.gets) != nil do
            p line
        end
        puts ""
        f.rewind
        begin
            while line = f.readline do
                p line
            end
        rescue EOFError=> exception
            p exception
        end
    end

# read and write several times
    # Delete all contents in the file 
    open("test.txt","w+") do |f|
        f.write("banana\ngirl")
        f.rewind # Back to line 0 to read
        data = f.read.chomp # There is no data to read 
        p data.reverse!
        f.rewind # Back to line 0 to write
        f.write(data)
    end
    # Doesn't delete any contents in the file
    open("test.txt","r+") do |f|
        data = f.read.chomp
        p data.reverse!
        f.rewind # Back to line 0 to write
        f.write(data)
    end
    # Can't delete any contents in the file
    open("test.txt","a+") do |f|
        data = f.read.chomp
        p data.reverse!
        f.rewind # It doesn't move to line 0
        f.write(data)
    end

p File.join("ruby", "exam","silver")
p File.join("/", "exam","silver")

p Dir.pwd
Dir.mkdir('userInfo') unless File.exists?('userInfo')
Dir.chdir("userInfo")
    File.new("userPrivacy.txt","w").close unless File.exist?("userPrivacy.txt")
        p "filename : #{File.join(Dir.pwd,"userPrivacy.txt")}"
        p "dirname : #{File.dirname(File.join(Dir.pwd,"userPrivacy.txt"))}"
        p "extname : #{File.extname(File.join(Dir.pwd,"userPrivacy.txt"))}"
        p "basename : #{File.basename(File.join(Dir.pwd,"userPrivacy.txt"))}"
        p "size : #{File.size(File.join(Dir.pwd,"userPrivacy.txt"))}"    
    File.delete("userPrivacy.txt") if (File.exist?("userPrivacy.txt")) && (!File.directory?("userPrivacy.txt"))
Dir.chdir("..")
Dir.rmdir("userInfo") if (File.exist?("userInfo")) && (File.directory?("userInfo"))
p Dir.getwd

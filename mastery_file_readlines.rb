### Another redundant example of printing all lines in a file, and closing the file, and its inaccessibility when closed.
datafile = File.open("sample.txt", "r")
lines = datafile.readlines   
puts lines.class # Array, because .readlines has been called on it the original file object.       
datafile.close
# jump = datafile.readlines     # Error, the file is already closed. "closed stream"
lines.each{ |line| puts line }  # Prints all the lines in the sample.txt file.



# Another example of 2 loops, using each_line , very similar to .readline. 
File.open("sample.txt") do |file|
	file.each_line do |current_line|
		puts current_line 
	end
end

# The block below is indentical to the one above it.
# You can make this easier - instead of calling .open, just call .readlines instead. Let it give an array, then call .each on that array. 
File.readlines("sample.txt").each do |line|
	puts line 
end

####
# new.txt contains this:
# High Scores
# Tony DiNitto
# Some other people

bb = File.open("new.txt").readlines.each do |line|
   puts line
   puts line.class # It's a String right now, but .readlines will eventually turn it into an array at the end. 
end
puts bb.class # Array. 
puts bb[0]    # High Scores. The first line of file is now the 0 index in the array. 
puts bb[1]    # Tony DiNitto

# The .readline method will step forward in the file one line at a time. Each time you call it, it begins where the last invocation left off. 
# Example of .readline : 
puts "Readline:"
first_line = File.open("new.txt").readline
puts first_line.class # String.
puts first_line[0]    # H  from the High Scores. The first line of file.  
puts first_line[1]    # i  from High. 
# Stepping ahead, when we call it again: 
second_line = File.open("new.txt").readline
puts second_line      # High Scores.   This is actually still the first line. 
first_line = File.open("new.txt").readline
puts first_line       # High Scores.   This is still the first line. 

# File.readlines turns each line into an array. 
# .readline and .readlines are different methods. .readline will evaluate each line, turn it into an array, and separate the array by line breaks.

pot = File.open("new.txt", 'r')
puts "#"
puts pot.readline
puts "#-"
puts pot.readline
puts "#--"
puts pot.readline
puts "#---"
# puts pot.readline    # Error. At end of file. "end of file reached (EOFError)"
file = File.open("new.txt", 'r')
puts file.readline            # This runs the .readline method once, making the first loop in the block start at "Tony DiNitto" and NOT "High Scores"

# The .eof? is a method that returns true if you're at the .(e)nd (of) file or not. The .readline will return an error if it tries to read the
# next line of a file that's already at its end.

while !file.eof?         # While Not at the end of the 'file' then run this block:
   puts "-----"
   line = file.readline  # 
   puts line
end

close_example = File.open("new.txt")  # The 'r' flag isn't needed if that's what you want. It's the default value anyway. 
puts "----- Example of new file ----- "
puts close_example.readline  # High Scores
close_example.close
# puts close_example.readline  # Error - "closed stream (IO Error)"
# You have to reopen a file to use it again:
close_example = File.open("new.txt") 
puts close_example.readline   # High Scores

# Use .readline on massive files (over several megs) that shouldn't have to be loaded into memory all at once. Use .readlines when 
# it's smaller, performance doesn't matter, and you need a quick solution. 

# Using File.foreach
# File.foreach will read a file line by line (or using a different separator given as second argument). 





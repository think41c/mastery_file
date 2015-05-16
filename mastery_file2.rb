# Remember include uri
require 'open-uri'         
url = "http://www.gutenberg.org/cache/epub/1342/pg1342.txt"
ham = "hambone.txt"



# if you wanted to read the file at the url: 
File.open(ham, "w"){|file| file.write(open(url).read)}   # Open the File class, invoke .open, so it knows it's about to read/write, the filename is
														 # the first parameter, with the (w)rite flag. It takes a block, and |file| is piped in as 
														 # the current file. That file invokes the .write method, but what is it going to write? 
														 # it's going to 'open' the 'url' given and .read it, as it's reading that info at the URL
														 # it's going to write it as well. Essentially, the url gets read, and written into the 
														 # hambone.txt file. 


doggy = File.open("ham42.txt", "w")                              # Create a blank file.
# Example of taking a file and extracting only lines divisible by 42.
copyz = File.open(ham, "r") do |file|       # Create a File instance, invoke .open method to open ham/"hambone.txt", with the (r)ead flag. Use a block:
   file.readlines.each_with_index do |line, idx|      # use the current file, 'file' and .readlines (which reads all the lines into an array), which 
   													  # can now be called with .each_with_index and another block with the line and index now:
      puts line if idx % 42 == 41                     # print out the current line if the index divided by 42 if the remainder is 41, why? 
      												  # Because arrays start at 0. This gives us every 42nd line. 
	  
	  # Write the file, by appending it to the already created new file, and put in each line into the file thats every 42nd line. 
	  # File.open("ham42.txt", "a") {|x| x.puts(line) if idx % 42 == 41}    # This is the equivalent of the line below it. 
	  # doggy.puts(line) if idx % 42 == 41
   end 
end

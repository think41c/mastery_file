################ File.read    ###################  File.open  #################   File.close ###################
#
# the .read and .open methods allow for either single or double quotes. 
# Standard syntax for opening a file. The File class, the .open method, and the file name surrounded by quotes as a parameter. 
File.open("scores.csv")
# This just creates the file object, just like a Class.new syntax. Assign it to a variable: 
myfilez = File.open("scores.csv")
# After a file is open, you need to 'close' it with the following .close method: 
myfilez.close
# Why close a file? To make sure Ruby doesn't get confused. If you're just reading a file and forget to close it, it's not a big deal other than
# you're using memory/resources to keep that file open. However, if you're writing a file, especially different files, it can cause lost data.

NAME = "foo"  
f1 = File.open("remember_to_close.txt", "w")
f1.puts "text 1xxxxx"  # forgot to close f1 . This also calls the File class' .puts method, which writes to a file instead of printing to screen.
f2 = File.open("remember_to_close.txt", "a") 
f2.puts "text 2xxxsdfdsxxzz"  # forgot to close f2  

# In older ruby versions like 1.8, the "text 2" wouldn't be written, as you couldn't open a file in a different instance until it already 
# closed by the last instance that had it opened. However, these lines will write to (or create, if it doesn't exist) a file called
# "rememeber_to_close". The parameters after the file (eg. "w", and "a") refer to the type of writing. They are as follows: 
# "r"  |  (R)ead-only,    starts at BEGINNING of file  (default mode). The file must ALREADY exist before this flag will work.
# "r+" |  (R)ead + Write, starts at BEGINNING of file.
# "w"  |  (W)rite-only, truncates (eg. DELETES!) existing file to zero length or creates a new file for writing.
# "w+" |  (W)rite + Read, truncates existing file to zero length or creates a new file for reading and writing.
# "a"  |  (A)ppend. Write-only, starts at end of file if file exists, otherwise creates a new file for writing.
# "a+" |  Read-write, starts at end of file if file exists, otherwise creates a new file for reading and writing.
#  "b" |  (B)inary file mode (may appear with any of the key letters listed above).Suppresses EOL <-> CRLF conversion on Windows. And
#      |  sets external encoding to ASCII-8BIT unless explicitly specified.
#  "t" |  (T)ext file mode (may appear with any of the key letters listed above except "b").

# If you pass a block to File.open instead of using a regular parameter, Ruby will automatically close the file for you. Example:
ggg = File.open('autoclose.rb', 'w+') do |x|    # Assigned this to ggg just to demonstrate below that the file doesn't need closing.
  puts x   # this shows the file object id -> #<File: 0x0343943408bdd> 
  x.puts "This is working. "  # This shows up in the file. 
  while line = x.gets  
    x.puts "hey there"   # Doesn't actually print to the file. Not sure what's going on in this block.
    puts line  
  end  
end  
# ggg.close   # Error, this has already closed. 

##########################################################################################
# Working with a new file - "sample.txt"
#
fname = "sample.txt"        
somefile = File.open(fname, "w")   # Creates a filename (or deletes the current contents of the file) called sample.txt

# With 'fname' above, you can also make a variable the object that File.open can accept as a parameter. Variables called like files do not need quotes.
# However, the variable should contain a string (not a string in an array, etc), which should be the name of the file you're accessing/creating. 

somefile.puts "Am I at the start?! Yes."        # Calls the object somefile and calls the puts method to alter that file. 
somefile.close                                  # Closes the file since a block wasn't called on the File.open method. 

# The block equivalent (except we will (a)ppend, instead of (w)rite for the flag) of the same 4 lines above is:
File.open("sample.txt", "a") { |somefile| somefile.puts "Hello* file(!) Seig Heil." }  # Block automatically close the previously open file

w1 = File.open("anewfile.rb", "w")
w1.puts "There's some stuff in it now."

# Reading files ################
file = File.open("sample.txt", "r")
what = file.read    # .read will read the entire file into a gigantic string contained in the var 'what'
puts what.class     # String. The entire file is returned as a gigantic string. 
puts what.upcase    # Prints the contents of the file, as a string, in all Upper case.

# As Ruby goes through a file, it remembers where it left off. If it looks line by line, the next command to look at the next line will
# look at the line where it left off until it's hit the end of the file. In the case above, 'file.read' has "slurped" the entire file into 
# memory and is at the end... 

puts file.read      # Nil. This is because the .read operation begins where the last .read operation left off. There's nothing left 
				            # after our puts what.upcase expression, so it's just nil.
another = file.read # Changing variable names doesn't "reset" the .read method to start from the beginning. 
puts another        # Still prints nil. 
file.close
puts "#{what} <- We closed the file. So now will actually print again."

############# Reading, using a block, which will auto close the file ###############################################
stuff = File.open("sample.txt", "r"){ |filez_instance| filez_instance.read }
puts stuff # Prints the entire contents of the file, unaltered. 
puts stuff # Prints the entire contents AGAIN. The read operation ends from the last one left off. This is allowed b/c the block had closed the file.
####################################################################################################################

#################### File.write ####################################################################################
# Instead of using .puts, you can also use the .write method in the File class ##
dir_name = "junk-folder"
File.open("yourfile.md", 'w') { |file| file.write("your text") }   # This will .write "your text" into yourfile.md. 
File.open("yourfile.md", 'a') { |file| file.puts("but whats the difference between puts and write?")}  # puts appends a \n at the end, .write doesn't.
File.open("#{dir_name}/new-file.txt", 'w'){|f| f.write('Howdy!')} # Using a folder, write a file in a new folder called new-file.txt, and writes "Howdy!"
# Also .write will display formatting escape codes as opposed to interpret them. So if you manipulate a file that you've read
# and then go to .write it, it will not print any lines breaks, tabs, etc. It'll just be a jumble of \n and escape codes.
# A short version of the write method, .write method will create/overwrite the file: 
File.write('./junk-folder/another.txt', 'Howdy there!')   # takes the present working directory  ./ and a path and file name, writes "Howdy there!"	
####################################################################################################################

##################### File.seek ############## Seeking inside a file. ##############################################
f = File.new("hellousa.rb")  #a-b-c-d-e-f-g-h-i-j-k-l-m   <-- this is what the file contains
# SEEK_CUR - Seeks to first integer number parameter plus current position  
# SEEK_END - Seeks to first integer number parameter plus end of stream  
# SEEK_SET - Seeks to the absolute location given by first integer number parameter  
puts f.seek(12, IO::SEEK_SET)   # Calls the hellousa.rb file, points to the 12th character in the file, starting printing the 13th and on. 
print f.readlines               # ["g-h-i-j-k-l-m"] , shows a blank array if the file was blank. In this case it starts at the g, the 13th character.
puts f.class    # File
puts f.close    # Nil. Pointless form, but this DOES close the file! 
# f.close       # Error. You've already closed the file. "closed stream (IO Error)"
#####################################################################################################################

###################### File.exist? ########################
puts File.exist?("sample.txt")  # True 

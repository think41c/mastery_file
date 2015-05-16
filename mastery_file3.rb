##### File.exists?   ################

# Using other methods in the File class.  .exists? 
hambone = "ham42.txt"
if File.exists?("ham42.txt")
   puts "#{hambone} exists"   # ham42.txt exists.
end

################### DIR Class ###########################
dir_name = "junk-folder"
# Do something      unless  something else is true.
Dir.mkdir(dir_name) unless File.exists?(dir_name)   #Dir.mkdir is a class and method that creates folders. 

# Dir class also has a .glob method. The * is a wildcard to look at everthing. 
# Count the files in Downloads directory:
puts Dir.glob('junk-folder/*').length   #=> 1
puts Dir.glob('../fileio/**/*').length  # count all files in one folder back and then all in the filoio folder and all subdirectories
puts Dir.glob('**').length    # Show the current amount of files in JUST the current folder.
puts Dir.glob('**.{RB,rb}').join(",\n") # list just PDF files, either with .rb or .RB extensions:

# Using the Dir.glob with the File.size method. 
# Scan through the top 10 biggest files in a certain folder, and sort_by the files from largest to smallest (use the .reverse method)
Dir.glob("../../**/*.*").sort_by{|fname| File.size(fname)}.reverse[0..9].each do |fname|
   puts "#{fname}".ljust(140) + "#{File.size(fname)}"
end

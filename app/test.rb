# require 'active_support/all'

# lines = File.readlines "dictionary.txt"
# lines.each do |line|
#     line.mb_chars.delete! " 0123456789"
#     puts line.mb_chars 
# end

# File.open("dictionaryV2.txt", 'w') do |file|
#     file.puts lines
# end


# source = File.read("../source/words.txt")
# source.gsub!(/(, )/, "\n")
# source = source.split("\n")
# source.delete_if {|word| word.length.between?(1,3)}
# File.open("wordsFIX.txt", 'w') do |file|
#     file.puts source
# end
            # ==================
            # working with Cyrillic
            # ===================
# require 'active_support/all'

# lines = File.readlines "dictionary.txt"
# lines.each do |line|
#     line.mb_chars.delete! " 0123456789"
#     puts line.mb_chars 
# end

# File.open("dictionaryV2.txt", 'w') do |file|
#     file.puts lines
# end

            # ==================
            # Load, change and save file
            # ===================
# source = File.read("../source/words.txt")
# source.gsub!(/(, )/, "\n")
# source = source.split("\n")
# source.delete_if {|word| word.length.between?(1,3)}
# File.open("wordsFIX.txt", 'w') do |file|
#     file.puts source
# end

            # ==================
            # Saving data to yaml file
            # ===================
# require 'yaml'

# a = [1,2,3]
# s = "test"
# array1 = {a:a, s:s}
# File.write('test.yaml', array1.to_yaml)


# array2 = YAML.load_file('test.yaml')
# test_a = array2[:a]
# test_s = array2[:s]

# puts test_a
# puts test_s
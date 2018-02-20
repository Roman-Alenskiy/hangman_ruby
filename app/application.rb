class Game
    require 'yaml'

    def show_fields
        print "\n______________________________________________\n"
        print "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n"
        print @fields.join(" ")
        print "\n\n"
        puts "*Used letters: #{@used_letters.join(", ")}"
        puts "*Number of attempts: #{@number_of_attempts}"
        print "______________________________________________\n"
        print "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n"
    end

    def save_game
        puts "\n============================"
        puts "Saving game..."
        puts "============================"
        
        game = {secret_word: @secret_word, fields: @fields, 
                used_letters: @used_letters, number_of_attempts: @number_of_attempts}
        save_file_name = "../save/#{Time.now.strftime("%d-%m-%Y_%H-%M")}.yaml"
        File.write(save_file_name, game.to_yaml)

        sleep(1.5)
        puts "\n============================"
        puts "Game successfuly saved!"
        puts "============================"
    end

    def load_game
        game = load_file("save")
        @secret_word = game[:secret_word]
        @fields = game[:fields]
        @used_letters = game[:used_letters]
        @number_of_attempts = game[:number_of_attempts]

        puts "\n============================"
        puts "Loading game..."
        puts "============================"
        sleep(1.5)
        puts "\n============================"
        puts "Game successfuly loaded!"
        puts "============================"

        show_fields
        input_handler
    end

    def input_handler
        loop do
            print "\nEnter the letter:\n>> "
            letter = gets.chomp
            letter.downcase!
            if letter == "save"
                save_game
                exit
            end
            if !(/^[a-z]$/ === letter)
                puts "\nIncorrect input! Only A-Z characters are allowed."
                next
            end

            @used_letters << letter
            @used_letters.uniq!

            suitable_letters = @secret_word.each_index.select {|index| @secret_word[index] == letter}
            if !(suitable_letters.empty?)
                step(suitable_letters) 
            else
                puts "\n#  Wrong letter  #"
                @number_of_attempts -= 1
                game_over_check
                show_fields
            end
        end
    end

    def game_over_check
        if @number_of_attempts == 0
            puts "\n============================"
            puts "\nGAME OVER! (answer was: #{@secret_word.join})" 
            puts "\n============================"
            exit
        end

        if @fields == @secret_word
            puts "\n============================"
            puts "\nYOU WIN!"
            puts "\n============================"
            exit
        end
    end

    def step(suitable_letters)
        suitable_letters.each do |index|
            @fields[index] = @secret_word[index]
        end
        show_fields
        game_over_check
        input_handler
    end

    def show_catalog(catalog_name)
        n = 1
        files_in_catalog = Dir.glob("../#{catalog_name}/*")
        files_in_catalog.each do |file|
            puts "#{n}) #{file[catalog_name.length+4..-1]}"
            n += 1
        end
    end
        
    def load_file(catalog_name)
        puts "\nChoose the #{catalog_name}:"
        files_in_catalog = Dir.glob("../#{catalog_name}/*")
        show_catalog(catalog_name)
        loop do
            option = gets.chomp.to_i - 1
            if !(/^\d$/ === option.to_s && option.between?(0, files_in_catalog.size - 1))
                puts "Incorrect input!"
                next
            end 
            file = files_in_catalog[option]
            return YAML.load_file(file) if file[-4..-1] == "yaml"
            return File.read(file)
        end
    end

    def start_game
        dictionary = load_file("dictionary")
        @secret_word = dictionary.split("\n").sample.split("")
        
        @secret_word.length.times do 
            @fields << "_"
        end

        print "\n========================================\n"
		print "#                                      #\n"
		print "#         THE NEW GAME BEGINS!         #\n"
        print "#  (enter 'save' to save your game!)   #\n"
        print "#                                      #\n"
		print "========================================\n"
        # puts @secret_word.join

        show_fields
        input_handler
    end

    def start_or_load
        puts "\nStart new or load saved game?"
        puts "1. Start new game"
        puts "2. Load from file"
        loop do
            option = gets.chomp
            if !(/^\d$/ === option.to_s && option.to_i.between?(1, 2))
                puts "Incorrect input!"
                next
            end
            
            if option == "1"
                start_game
            else
                load_game
            end
        end
    end

    def initialize
        @fields = []
        @used_letters = []
        @number_of_attempts = 6

        start_or_load
    
    end

end

Game.new

class Game

    def show_fields
        print "\n______________________________________________\n"
        print "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n"
        @fields.each {|field| print "#{field} "}
        print "\n\n"
        puts "*Used letters: #{@used_letters}"
        puts "*Number of attempts: #{@number_of_attempts}"
        print "______________________________________________\n"
        print "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n"
    end

    def input_handler
        loop do
            print "\nEnter the letter:\n>> "
            letter = gets.chomp
            letter.downcase!
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
            puts "\nGAME OVER!"
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

    def show_source_catalog
        @source_catalog = Dir.glob("../source/*")
        n = 1
        @source_catalog.each do |source|
            puts "#{n}) #{source[10..-1]}"
            n += 1
        end
    end
        
    def read_source
        puts "\nChoose the dictionary:"
        show_source_catalog
        loop do
            option = gets.chomp.to_i - 1
            source = @source_catalog[option]
            @dictionary = File.read(source)
            return
        end
    end

    def show_file
        puts @dictionary
    end

    def start_game
        print "\n========================================\n"
		print "#                                      #\n"
		print "#         THE NEW GAME BEGINS!         #\n"
		print "#                                      #\n"
		print "========================================\n"
        puts @secret_word.to_s

        show_fields
        input_handler
    end

    def initialize
        @fields = []
        @used_letters = []
        @number_of_attempts = 6

        read_source
        @secret_word = @dictionary.split("\n").sample.split("")
        
        @secret_word.length.times do 
            @fields << "_"
        end

        start_game
    end

end

Game.new

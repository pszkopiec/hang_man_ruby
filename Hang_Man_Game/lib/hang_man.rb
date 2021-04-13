require "yaml"

class Game
  def initialize(word,board,incorrect_guess)
  @the_word = word
  @board = board
  @incorrect_guess = incorrect_guess
end
  
def dictionary_array
  dictionary = File.readlines "5desk_dictionary.txt", chomp:true
  dictionary_array = []
  dictionary.each do |word|
    dictionary_array.push word
  end
  return dictionary_array
end

def find_word
  @the_word = dictionary_array.sample.downcase 
  until @the_word.length >= 5 and @the_word.length <= 12 do
    @the_word = dictionary_array.sample.downcase
  end
  return @the_word
end

def board
  @board = Array.new(find_word.length,"__")
end

def game_intro
  puts "\n" * 300
  puts "**********************************************************"
  puts "----------------Welcome to Hangman!-----------------------"
  puts "**********************************************************"
  puts "\n" * 2 
  puts "Hangman is a game where you guess letter by letter a random dictionary word. Every wrong guess will get you closer to getting HANGED! WATCH OUT! ;|"
  puts "***********************************************************"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end



def hang_man_figure
  if @incorrect_guess == 0
    puts " 
              
        __________ 
        |         |
        |         |
                  |
                  |
                  |
                  |
                  |
                  |
                  |
                  |
      ____________|
"
  elsif @incorrect_guess == 1
    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
                  |
                  |
                  |
                  |
                  |
                  |
      ____________|
"
  elsif @incorrect_guess == 2
 
    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
        |         |
        |         |
        |         |
        |         |
                  |
                  |
      ____________|
"
  elsif @incorrect_guess == 3

    hang_man_guy = %{  
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
        |         |
        |         |
        |         |
        |         |         
         \\        |
          \\       |
           \\_     |
      ____________|
    }

    puts hang_man_guy

  elsif @incorrect_guess == 4

    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
        |         |
        |         |
        |         |
        |         |
       / \\        |
      /   \\       |
    _/     \\_     |
                  |
  ________________|
"

  elsif @incorrect_guess == 5

    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
        |         |
        |____/_   |
        |    \\    |
        |         |
       / \\        |
      /   \\       |
    _/     \\_     |
                  |
  ________________|
"
  elsif @incorrect_guess == 6

    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      | _ |       |
      |___|       |
        |         |
  _\\____|____/_   |
   /    |    \\    |
        |         |
       / \\        |
      /   \\       |
    _/     \\_     |
                  |
__________________|
     "

  elsif @incorrect_guess == 7

    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      |X_ |       |
      |___|       |
        |         |
  _\\____|____/_   |
   /    |    \\    |
        |         |
       / \\        |
      /   \\       |
    _/     \\_     |
                  |
__________________|
     "

  elsif @incorrect_guess == 8

    puts "
        __________ 
        |         |
        |         |
      ^^^^^       |
      |X_X|       |
      |_O_|       |
        |         |
  _\\____|____/_   |
   /    |    \\    |
        |         |
       / \\        |
      /   \\       |
    _/     \\_     |
                  |
__________________|
    GAME OVER "
end
end


def update_board
   @the_word.split("").each_with_index do |n,i|
     if n == @guess 
       @board[i] = @guess
     end
   end
   p @board
end

def guess 
  puts "What is your guess?"
  @guess = gets.downcase.chomp
    until @guess.length == 1 and @guess.is_a?(String) do
      puts "Please enter only ONE LETTER at a time. Thank you."
      @guess = gets.downcase.chomp
    end
    return @guess
end

@incorrect_guess = 0

def incorrect_guess?
  if @the_word.split("").any?{|x| x == @guess} == true
    puts "\n"*100
    puts "NICE GUESS! THAT IS CORRECT, KEEP GOIN'!"
    return 
  else
    puts "\n"*100
    puts "NERRHHHHH!! WRONG! TRY AGAIN!"
    @incorrect_guess += 1
  end
end

def game_end?
  if @board.all?{|x| x != "__"}
    true
  else
    false
  end
end

def save?
  puts "Would you like to save?(y/n)"

  choice = gets.downcase.chomp
    until choice == "y" || choice == "n" do
      puts "Not a valid decision. Please enter <y> or <n>. Thank you."
      choice = gets.downcase.chomp
    end
  if choice == "y"
    puts "Please name your save file"
    save_name = gets.chomp
    save_file = File.open("saves/#{save_name}", "w")
    the_word_yaml = @the_word.to_yaml
    save_file.write(the_word_yaml)
    #["C","__","__","__","__","__"]
    @board.each do |element|
      element_yaml = element.to_yaml
      save_file.write(element_yaml)
    end
    #board_yaml = @board.join.to_yaml #"f________"
    #board_yaml2 = @board.to_yaml
    incorrect_guess_yaml = @incorrect_guess.to_yaml
    #save_file.write(the_word_yaml)
    #save_file.write(board_yaml)
    save_file.write(incorrect_guess_yaml)
    #save_file.write(board_yaml2)
    puts "\n" * 100
    puts "SAD TO SEE YOU GO! COME BACK SOON!"
    exit
    #"fjord"
    #"f________"
    #"0"
    #yaml array of board
    #spanning multiple lines lines[3] to EOF
    #
  elsif choice == "n"
    return
  end
end

  def load_game?
    puts "Would you like to load a game?(y/n)"
    @confirm = gets.downcase.chomp
    if @confirm  == "y"
      puts "what is the name of your saved file?"
      file = gets.chomp
      until File.exist?("saves/#{file}") or file == "cancel load request" do 
        puts "That save file does not exist. Please try again.\n**Or if you would like to exit the load request screen please enter <cancel load request>. =)**"
        file = gets.chomp
      end
      if file == "cancel load request"
        exit
      else
      load_file = File.open("saves/#{file}", "r")

      lines_arr = IO.readlines(load_file, chomp: true)
      #lines_arr = ["---Curiae","C__________","1","C","__","__","__","__","__"]
      @the_word = YAML.load(lines_arr[0])
      @board = []
      cycle = 1
      until cycle == @the_word.length + 1 do
        yaml_letter = YAML.load(lines_arr[cycle])
        @board.push(yaml_letter)
        cycle += 1
      end
      cycle = 1
      #@board = YAML.load(lines_arr[1]).split #["f","_","_","_","_","_","_","_","_"] 
      #starts lines_arr[1] end lines_arr[lines_arr.length-2)
      #load everything from [1]...[-2] range for board.
      @incorrect_guess = YAML.load(lines_arr[@the_word.length+1])  
      #@board.each do |elem|
      #  if elem == "_"
      #    elem = "__"
      #  else
      #    next
      #  end
      #end
      #@board2 = YAML.load()
      #[2..lines_arr.length-1
      #p @the_word
      #p @board
      #p @incorrect_guess
      #p @board2
      #for @board to rebuild must go inside array.each and push each element into an array based here. **no implicit conversion of Array into string.
      end
    end
  end
  
#def load_game?
#  puts "would you like to load a game?(Y/n)"
#  choice = gets.chomp
#  if choice == "Y"
#    File.open(saves/
#    #open file and load that game in"
#  else
#    return
#  end
#end

def game_play
  find_word
  board
  load_game?
  if  @confirm != 'y'
   game_intro
  end 
  until game_end? || @incorrect_guess == 8 
  #p @the_word
  guess
  incorrect_guess?
  hang_man_figure
  update_board
  save?
  end
  if game_end? != true
  puts "\n" * 100
  hang_man_figure
  update_board
  puts "SORRY, YOU LOST!!" 
  puts "\n"
  puts "The word was....#{@the_word.upcase}!!"
  exit
  elsif game_end? == true
    puts "\n" * 100
    hang_man_figure
    update_board
    puts "OMG!"
    puts "#{@the_word.upcase} is the word!"
    puts "YOU WIN!!! =)"
    puts "******!*******!*****!*******!*****!*****!"
    exit
  end
end

end

game = Game.new("","",0)
game.game_play


#serialized_game = YAML::dump(game)

#if $save_name.exist?
#  $save_file.write(serialized_game)
#end
  

#puts serialized_game
#deserialized_game = YAML::load(serialized_game)
#puts deserialized_game.game

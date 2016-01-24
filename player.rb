# Tic Tac Toe
# nolan camp - 2016
# player.rb

class Player
  attr_reader :letter, :nested_selections, :outer_selections, :diags, :diags2, :name
  
  def initialize(letter = get_letter, name = get_name)
    @letter = letter
    @name = name
    @nested_selections = []
    @outer_selections = []
    @diags = []
    @diags2 = []
  end
  
  def get_name
    puts "One last thing - What's your name?"
    @name = gets.chomp
    puts ""
    puts "OK #{@name.green}, you're going to be #{@letter.green}. Lets get started."
    puts ""
    @name
  end  

  def get_letter
    puts ""
    puts "What letter would you like - either X or O"
    loop do
      @letter = gets.chomp.upcase
      if @letter == "X" || @letter == "O"
        break
      end
      puts "Sorry, that isn't an X or O, please choose again."
    end
    puts ""
    @letter
  end

  def opponent
    @letter == "O" ? "X" : "O"    
  end
end

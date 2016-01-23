# Tic Tac Toe
# nolan camp - 2016

class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
end

class Game
  attr_reader :board, :human, :computer, :nils
  
  def initialize(winner = nil)
    @board = Board.new
    @human = Player.new
    @computer = Player.new(@human.opponent, "The Computer")
    @nils = calculate_nils
    @winner = winner
    start_game
  end

  def calculate_nils
    indicies = (0...@board.rows).to_a
    indicies.repeated_permutation(2).to_a
  end

  def start_game
    case @winner
    when "The Computer"
      puts "Since the computer won last game, you start.".red
      human_move
    when "Human"
      puts ""
      puts "Since you won last game, the computer will start this time.".red
      computer_move
    when "Tie"
      puts "Since the last game was a tie, we'll roll the dice on who goes first...".red
      [true, false].sample ? human_move : computer_move      
    else
      puts "Make your selection by entering the horizontal position and".green
      puts "then the vertical postition of the cell you want to select:".green
      [true, false].sample ? human_move : computer_move
    end
  end
  
  def human_move
    if @nils.length == @board.rows ** 2
      @board.pretty_print
    end
    puts ""
    puts "Enter the horizontal position only and then press return".green
    nested = gets.chomp.to_i - 1
    puts ""
    puts "Ok, now enter the Vertical position".green
    outer = gets.chomp.to_i - 1

    move = Move.new(nested, outer)
    check_if_valid(move)
    
    @board.layout[move.outer][move.nested] = @human.letter.green
    @nils.delete(move.index)
    @board.pretty_print
    check_for_winner(@human, move)
    computer_move
  end

  def computer_move
    puts ""
    puts "It's the computers turn".magenta
    puts ""

    vals = @nils.shuffle!.pop
    move = Move.new(vals[0], vals[1])
    
    @board.layout[move.outer][move.nested] = @computer.letter.magenta
    @board.pretty_print
    
    check_for_winner(@computer, move)
    human_move
  end  

  def check_for_winner(player, move)
    player.nested_selections.push(move.nested)
    player.outer_selections.push(move.outer)
    player.diags.push(move) if move.nested == move.outer
    player.diags2.push(move) if move.nested + move.outer == @board.rows - 1

    if player.nested_selections.count(move.nested) == board.rows ||
       player.outer_selections.count(move.outer) == board.rows ||
       player.diags.size == board.rows ||
       player.diags2.size == board.rows
      puts ""
      puts "    ---- #{player.name} is the winner! ----".red
      if player.name == "The Computer"
        play_again?(player.name)
      else
        play_again?("Human")
      end
    elsif @nils.length < 1
      puts ""
      puts "    ---- Looks like nobody won! ----".red
      play_again?("Tie")
    end
  end
  
  def check_if_valid(move)
    if !nils.include?(move.index)
      puts "move invalid - try again!".red
      puts ""
      human_move
    end
  end  
    
  def play_again?(winner)
    puts ""
    puts 'Would you like to play again? - Type "yes" to play again or anything else to exit'
    if gets.chomp == "yes"
      Game.new(winner)
    else
      exit
    end
  end
end


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
    return "X" if @letter == "O"
    return "O" if @letter == "X"
  end
end

class Move
  attr_reader :nested, :outer
  
  def initialize(nested, outer)
    @nested = nested
    @outer = outer
  end
  
  def index
    [nested, outer]
  end
end

class Board
  attr_reader :rows, :layout

  def initialize
    @rows = get_rows
    @layout = []
    @rows.times { @layout.push(Array.new(@rows)) }
  end

  def get_rows
    puts ""
    puts "Welcome to Tic Tac Toe!".green
    puts ""
    puts "How many rows and columns would you like the board to be?"
    puts "A standard tic tac toe board would be 3."
    input = gets.chomp.to_i

    loop do
      if input < 3
        puts ""
        puts "Sorry, that tic tac toe board would be too small! There is a minimum of 3."
        puts "Enter a higher numer, making sure it's an integer."
        input = gets.chomp.to_i
      else
        @rows = input
        break
      end
    end 
    @rows
  end
  
  def array_print
    @layout.reverse.each {|row| p row }
  end

  def pretty_print
    divider = "       --------------------------"
    (rows - 3).times { divider << "----------" }
    @layout.reverse.each_with_index do |x, index|
      string = "    #{rows - index}    "
      for i in x
        i = " " if i.nil?
        string << "#{i}    |    "
      end
      puts ""
      puts string[0...-5]
      puts divider unless index == rows - 1
    end
    puts ""
    string = "         1"
    for i in 2..rows
      string << "         #{i}"
    end
    puts string
    # puts ""
  end
end

Game.new

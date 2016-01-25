# Tic Tac Toe
# nolan camp - 2016
# game.rb

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
      puts ""
      human_move
    when "Human"
      puts ""
      puts "Since you won last game, the computer will start this time.".red
      puts ""
      computer_move
    when "Tie"
      puts "Since the last game was a tie, we'll roll the dice on who goes first...".red
      puts ""
      [true, false].sample ? human_move : computer_move      
    else
      puts "Make your selection by entering the horizontal position and".green
      puts "then the vertical postition of the cell you want to select:".green
      puts ""
      [true, false].sample ? human_move : computer_move
    end
  end
  
  def human_move
    if @nils.length == @board.rows ** 2
      @board.pretty_print
      puts ""
      puts "It's your turn first!".magenta
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

  def check_if_valid(move)
    if !nils.include?(move.index)
      puts "move invalid - try again!".red
      puts ""
      human_move
    end
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
    player.diags_reverse.push(move) if move.nested + move.outer == @board.rows - 1

    if player.nested_selections.count(move.nested) == board.rows ||
       player.outer_selections.count(move.outer) == board.rows ||
       player.diags.size == board.rows ||
       player.diags_reverse.size == board.rows
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

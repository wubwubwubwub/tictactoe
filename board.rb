# Tic Tac Toe
# nolan camp - 2016
# board.rb

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
  
  # def array_print
  #   @layout.reverse.each {|row| p row }
  # end

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
  end
end

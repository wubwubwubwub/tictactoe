# Tic Tac Toe
# nolan camp - 2016
# move.rb

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

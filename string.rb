# Tic Tac Toe
# nolan camp - 2016
# string.rb

class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
end

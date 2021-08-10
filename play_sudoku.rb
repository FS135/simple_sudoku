require "byebug"
require_relative "sudoku"

sudoku = Sudoku.new

puts "\e[H\e[2J"
puts "\n" * 1

while true
  puts "     ------Sudoku - by Florian Schulte-------      "
  sudoku.draw
  
  
  puts "\n" * 2
  
  puts "geben sie eine Zahl ein mit den Koordinaten xyn"
  input = gets.chomp
  number = input.to_s[2]
  position = [input.to_s[0].to_i, input.to_s[1].to_i]
  puts "\e[H\e[2J"
  puts "\n" * 1
  puts sudoku.try_num(number, position)

end


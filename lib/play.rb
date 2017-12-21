#lib/play.rb
require_relative 'tic-tac-toe'

puts "Welcome to Tic-tac-toe.  Type quit at any time to exit."
loop do
  play_game
  puts "Type 'Y' to play again, or any other key to exit."
  input = gets.chomp
  if input[/[^Yy]/]
    break
  end
end

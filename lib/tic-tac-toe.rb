#lib/tic-tac-toe.rb
class Board
  def initialize
    @board_state = [['_', '_', '_'], ['_', '_', '_'], [' ', ' ', ' ']]
  end

  def format_input(input)
    input.upcase!
    if input == 'QUIT' then exit end
    row = input[/[ABC]/]
    column = input[/[123]/]
    if (input[/[^ABC123]/]) || (input.length !=2) || (row == nil) || (column == nil)
      return "Invalid input. input must be two characters: 1 row letter and 1 column number."
    end
    column = column.to_i - 1 #adjust column index since array starts from 0
    #convert row letter to array number
    case row
    when "A"
      row = 0
    when "B"
      row = 1
    when "C"
      row = 2
    else
      return "Invalid input. input must be two characters: 1 row letter and 1 column number."
    end
    if @board_state[row][column][/[XO]/]
      return "There is already a token on that space."
    else
      return [row, column]
    end
  end

  def place_token (token, row, column)
    @board_state[row][column] = token
  end

  def check_win
    output = check_win_with_token('X')
    if output == 'continue'
      output = check_win_with_token('O')
    end
    output
  end

  def check_win_with_token(token)
    3.times do |i|
      #check rows
      if @board_state[i].all? {|t| t == token}
        return token
      end
      #check columns
      if (@board_state[0][i] == token) && (@board_state[1][i] == token) && (@board_state[2][i] == token)
        return token
      end
    end
    #check diagonals
    if (@board_state[1][1] == token) && ((@board_state[0][0] == token && @board_state[2][2] == token) || (@board_state[0][2] == token && @board_state[2][0] == token))
      return token
    end
    #check draw
    if (@board_state[0].all? {|t| t[/[XO]/]}) && (@board_state[1].all? {|t| t[/[XO]/]}) && (@board_state[2].all? {|t| t[/[XO]/]})
      return 'draw'
    end
    return 'continue'
  end

  def print_board
    puts "   1   2   3\nA _#{@board_state[0][0]}_|_#{@board_state[0][1]}_|_#{@board_state[0][2]}_\nB _#{@board_state[1][0]}_|_#{@board_state[1][1]}_|_#{@board_state[1][2]}_\nC  #{@board_state[2][0]} | #{@board_state[2][1]} | #{@board_state[2][2]} "
  end
end

def play_game
  my_board = Board.new
  current_player = 'X'
  formatted_input = []
  my_board.print_board
  9.times do
    puts "Player #{current_player}, please input your move based on the grid above."
    loop do
      input = gets.chomp
      formatted_input = my_board.format_input(input)
      if formatted_input.is_a?(Array) #if input is valid
        break
      else #if input is invalid
        puts formatted_input #error string output but format_input
      end
    end
    my_board.place_token(current_player, formatted_input[0], formatted_input[1])
    my_board.print_board
    winner = my_board.check_win
    case winner
    when 'continue'
    when 'draw'
      puts "Match is a draw."
      break
    else
      puts "Player #{winner} is the winner!"
      break
    end
    current_player == 'X' ? (current_player = 'O') : (current_player = 'X')
  end
end

puts "Welcome to Tic-tac-toe.  Type quit at any time to exit."
loop do
  play_game
  puts "Type 'Y' to play again, or any other key to exit."
  input = gets.chomp
  if input[/[^Yy]/]
    break
  end
end

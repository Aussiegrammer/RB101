INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
FIRST_MOVE = ['player', 'computer']
AI_DIFFICULTY = ['easy', 'medium', 'hard']
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # Rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # Columns
                [[1, 5, 9], [3, 5, 7]]              # Diagonals
WINNING_SCORE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def settings_first_move
  valid_answer = FIRST_MOVE[0..1]
  answer = ''
  loop do
    prompt "Choose who goes first, player or computer."
    answer = gets.chomp.downcase
    break if valid_answer.include?(answer)
    puts "Sorry, I didn't get that. Please enter player or computer."
  end
  answer
end

def settings_ai_difficulty
  valid_answer = AI_DIFFICULTY[0..2]
  answer = ''
  loop do
    prompt "Please choose a difficulty - Easy, medium, or hard."
    answer = gets.chomp.downcase
    break if valid_answer.include?(answer)
    puts "Sorry, I didn't get that. Please enter easy, medium or hard."
  end
  case answer
  when 'easy' then 0
  when 'medium' then 1
  when 'hard' then 2
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(b)
  system('clear') || system('cls') unless empty_squares(b) == 9
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts "     |     |"
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}"
  puts "     |     |"
end
# rubocop:enable Metrics/AbcSize

def display_scoreboard(round, scores)
  puts "Round #{round} | " \
       "Player score = #{scores[0]} | Computer score = #{scores[1]}"
end

def initialise_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def joinor(squares, delimiter = ', ', word = 'or')
  case squares.size
  when 0 then ''
  when 1 then squares.first
  when 2 then squares.join(" #{word} ")
  else
    last = squares.pop
    squares.join(delimiter) + ", #{word} " + last.to_s
  end
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(board))})"
    square = gets.to_i
    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice"
  end

  board[square] = PLAYER_MARKER
end

def computer_ai_defense_check(board)
  WINNING_LINES.each_with_index do |line, index|
    if board.values_at(*line).count(PLAYER_MARKER) == 2 &&
       board.values_at(*line).count(COMPUTER_MARKER) == 0
      return WINNING_LINES[index]
    end
  end
  false
end

def computer_ai_offense_check(board)
  WINNING_LINES.each_with_index do |line, index|
    if board.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       board.values_at(*line).count(PLAYER_MARKER) == 0
      return WINNING_LINES[index]
    end
  end
  false
end

def computer_ai_place(board, line)
  line.each do |square|
    if board[square] == " "
      board[square] = COMPUTER_MARKER
    end
  end
end

def computer_ai_place_random(board)
  square = empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

def computer_places_piece!(board, computer_ai)
  if computer_ai_offense_check(board) && computer_ai >= 2
    computer_ai_place(board, computer_ai_offense_check(board))
  elsif computer_ai_defense_check(board) && computer_ai >= 1
    computer_ai_place(board, computer_ai_defense_check(board))
  elsif board[5] == ' '
    board[5] = COMPUTER_MARKER
  else
    computer_ai_place_random(board)
  end
end

def place_piece!(board, current_player, ai_difficulty)
  if current_player == 'player'
    player_places_piece!(board)
  elsif current_player == 'computer'
    computer_places_piece!(board, ai_difficulty)
  end
end

def alternate_players(current_player)
  if current_player == 'player'
    'computer'
  elsif current_player == 'computer'
    'player'
  end
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won_round?(board)
  !!detect_round_winner(board)
end

def game_round(board, round, scores, current_player, ai_difficulty)
  loop do
    display_board(board)
    display_scoreboard(round, scores)
    place_piece!(board, current_player, ai_difficulty)
    current_player = alternate_players(current_player)
    break if someone_won_round?(board) || board_full?(board)
  end
end

def detect_round_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_game_winner(scores)
  if scores[0] == WINNING_SCORE
    'Player'
  elsif scores[1] == WINNING_SCORE
    'Computer'
  end
end

def someone_won_game?(scores)
  !!detect_game_winner(scores)
end

def add_score(winner, scores)
  if winner == 'Player'
    scores[0] += 1
  else
    scores[1] += 1
  end
  scores
end

def yes_no_prompt(question)
  valid_answer = ['y', 'yes', 'n', 'no']
  answer = nil
  loop do
    prompt(question)
    answer = gets.chomp
    if valid_answer.include?(answer.downcase)
      break
    else
      prompt("Sorry, please enter yes or no.")
    end
  end
  answer
end

def new_game?
  answer = yes_no_prompt("Would you like to play again?")
  if answer.downcase == "y" || answer.downcase == "yes"
    true
  elsif answer.downcase == "n" || answer.downcase == "no"
    false
  end
end

def change_settings_prompt?
  answer = yes_no_prompt("Do you want to try new settings?")
  if answer.downcase == "y" || answer.downcase == "yes"
    true
  elsif answer.downcase == "n" || answer.downcase == "no"
    false
  end
end

prompt "Welcome to Tic Tac Toe! First to #{WINNING_SCORE} wins the game."

first_move = settings_first_move
ai_difficulty = settings_ai_difficulty
change_settings = false

loop do # Main game loop
  if change_settings == true
    first_move = settings_first_move
    ai_difficulty = settings_ai_difficulty
  end

  scores = [0, 0] # Player, computer
  round = 1

  loop do
    board = initialise_board
    current_player = first_move
    game_round(board, round, scores, current_player, ai_difficulty)

    display_board(board)

    loop do
      if someone_won_round?(board)
        puts "#{detect_round_winner(board)} wins the round! " \
             "Point to #{detect_round_winner(board)}."
        scores = add_score(detect_round_winner(board), scores)
      else
        puts "It's a tie!"
      end
      display_scoreboard(round, scores)
      prompt "Press Enter for the next round." unless someone_won_game?(scores)
      gets.chomp unless someone_won_game?(scores)
      break
    end

    round += 1

    if someone_won_game?(scores)
      puts "#{detect_game_winner(scores)} wins the game!"
      break
    end
  end
  break unless new_game?
  change_settings = change_settings_prompt?
end

system('clear') || system('cls')
prompt "Thanks for playing Tic Tac Toe!"

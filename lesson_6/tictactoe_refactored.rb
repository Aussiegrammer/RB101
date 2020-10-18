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
  answer = ''
  loop do
    prompt "Choose who goes first, #{joinor(FIRST_MOVE)}."
    answer = gets.chomp.downcase
    break if FIRST_MOVE[0..1].include?(answer)
    puts "Sorry, I didn't get that. Please enter #{joinor(FIRST_MOVE)}."
  end
  answer
end

def settings_ai_difficulty
  answer = ''
  loop do
    prompt "Please choose a difficulty - #{joinor(AI_DIFFICULTY)}"
    answer = gets.chomp.downcase
    break if AI_DIFFICULTY[0..2].include?(answer)
    puts "Sorry, I didn't get that. Please enter #{joinor(AI_DIFFICULTY)}."
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
       "Player score = #{scores[:player]} | " \
       "Computer score = #{scores[:computer]}"
end

def initialise_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def joinor(array, delimiter = ', ', word = 'or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{word} ")
  else
    last = array.last
    temp_array = array[0..-2]
    temp_array.join(delimiter) + "#{(delimiter)}#{word} " + last.to_s
  end
end

def player_places_piece!(board)
  square = ''
  valid_input = %w(1 2 3 4 5 6 7 8 9)
  loop do
    prompt "Choose a square (#{joinor(empty_squares(board))})"
    square = gets.chomp
    unless valid_input.include?(square)
      invalid_choice
      next
    end
    break if empty_squares(board).include?(square.to_i)
    invalid_choice
  end

  board[square.to_i] = PLAYER_MARKER
end

def invalid_choice
  prompt "Sorry, that's not a valid choice"
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
  if scores[:player] == WINNING_SCORE
    'Player'
  elsif scores[:computer] == WINNING_SCORE
    'Computer'
  end
end

def display_round_winner(board)
  puts "#{detect_round_winner(board)} wins the round! " \
       "Point to #{detect_round_winner(board)}."
end

def display_tie
  puts "It's a tie!"
end

def increment_by_one(round)
  round += 1
  round
end

def enter_to_continue_round(scores)
  prompt "Press Enter for the next round." unless someone_won_game?(scores)
  gets.chomp unless someone_won_game?(scores)
end

def someone_won_game?(scores)
  !!detect_game_winner(scores)
end

def display_grand_winner(scores)
  puts "#{detect_game_winner(scores)} wins the game!"
end

def add_score(winner, scores)
  if winner == 'Player'
    scores[:player] += 1
  else
    scores[:computer] += 1
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
  answer.downcase.start_with?('y')
end

def change_settings_prompt?
  answer = yes_no_prompt("Do you want to try new settings?")
  answer.downcase.start_with?('y')
end

def display_goodbye
  system('clear') || system('cls')
  prompt "Thanks for playing Tic Tac Toe!"
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

  scores = { player: 0, computer: 0 }
  round = 1

  loop do
    board = initialise_board
    current_player = first_move
    game_round(board, round, scores, current_player, ai_difficulty)

    display_board(board)

    loop do
      if someone_won_round?(board)
        display_round_winner(board)
        scores = add_score(detect_round_winner(board), scores)
      else
        display_tie
      end
      display_scoreboard(round, scores)
      enter_to_continue_round(scores)
      break
    end

    round = increment_by_one(round)

    break if someone_won_game?(scores)
  end
  display_grand_winner(scores) if someone_won_game?(scores)

  break unless new_game?
  change_settings = change_settings_prompt?
end

display_goodbye

VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
PLAYER_SHORTCUTS = ['r', 'p', 'sc', 'l', 'sp']
WIN_CONDITIONS = { 'rock' => ['scissors', 'lizard'],
                   'paper' => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'lizard' => ['spock', 'paper'],
                   'spock' => ['scissors', 'rock'] }
WINS_AMOUNT = 5

def prompt(message)
  puts "=> #{message}"
end

def win?(player_one, player_two)
  if WIN_CONDITIONS[player_one].include?(player_two)
    true
  end
end

def display_result(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
end

def display_round_details(choice, computer_choice)
  prompt("You chose #{choice}; Computer chose: #{computer_choice}")
  display_result(choice, computer_choice)
end

def give_point(player_one, player_two)
  if win?(player_one, player_two)
    1
  else
    0
  end
end

def update_scores(score, player_choice, computer_choice, player_name)
  score[:player] += give_point(player_choice, computer_choice)
  score[:computer] += give_point(computer_choice, player_choice)
  post_scores(score, player_name)
end

def post_scores(score, player_name)
  prompt "#{player_name}: #{score[:player]} / Computer: #{score[:computer]}"
end

def grand_winner?(score, player_name)
  if score[:player] == WINS_AMOUNT
    prompt "#{player_name} wins the game! Final score:
    #{player_name}: #{score[:player]} / Computer: #{score[:computer]}"
    true
  elsif score[:computer] == WINS_AMOUNT
    prompt "Computer wins the game! Final score:
    #{player_name}: #{score[:player]} / Computer: #{score[:computer]}"
    true
  end
end

def player_choice_prompt
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp.downcase
    if VALID_CHOICES.include?(choice)
      return choice
    elsif PLAYER_SHORTCUTS.include?(choice)
      return choice_shortcut(choice)
    else
      prompt("That's not a valid choice.")
    end
  end
end

def choice_shortcut(choice)
  case choice
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  end
end

def new_game_prompt
  valid_answer = ['y', 'yes', 'n', 'no']
  answer = nil
  loop do
    prompt("Do you want to play again?")
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
  answer = new_game_prompt
  if answer.downcase == "y" || answer.downcase == "yes"
    true
  elsif answer.downcase == "n" || answer.downcase == "no"
    false
  end
end

def login
  player_name = nil
  loop do
    prompt "Please enter your name:"
    player_name = gets.chomp
    if player_name == " "
      prompt "Please enter a valid name!"
    else
      break
    end
  end
  player_name
end

def display_welcome(player_name)
  prompt("Welcome #{player_name} to Rock Paper Scissors! (Lizard & spock too!)")
  prompt("First to #{WINS_AMOUNT} wins the game.")
  prompt("Tip: Use shortcuts such as 'p', 'sc', or 'sp' for Spock!")
end

def display_goodbye
  prompt("Thanks for playing! Enter to exit.")
  gets
end

player_name = login
display_welcome(player_name)

loop do # Main game loop
  player_choice = nil
  score = { player: 0, computer: 0 }
  loop do # First to 5 loop
    player_choice = player_choice_prompt
    system('clear') || system('cls')
    computer_choice = VALID_CHOICES.sample
    display_round_details(player_choice, computer_choice)
    update_scores(score, player_choice, computer_choice, player_name)
    break if grand_winner?(score, player_name)
  end

  break unless new_game?
  system('clear') || system('cls')
end

display_goodbye

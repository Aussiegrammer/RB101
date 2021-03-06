VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
PLAYER_SHORTCUTS = ['r', 'p', 'sc', 'l', 'sp']
WIN_CONDITIONS = { 'rock' => ['scissors', 'lizard'],
                   'paper' => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'lizard' => ['spock', 'paper'],
                   'spock' => ['scissors', 'rock'] }

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

def keep_score(player_one, player_two)
  if win?(player_one, player_two)
    1
  else
    0
  end
end

def scoreboard(player_score, computer_score, player_name)
  if player_score == 5
    prompt "#{player_name} wins the game! Final score:
    #{player_name}: #{player_score} / Computer: #{computer_score}"
  elsif computer_score == 5
    prompt "Computer wins the game! Final score:
    #{player_name}: #{player_score} / Computer: #{computer_score}"
  else
    prompt "#{player_name}: #{player_score} / Computer: #{computer_score}"
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

puts "Please enter your name:"
player_name = gets.chomp
prompt("Welcome, #{player_name}!")
prompt("Tip: Use shortcuts such as 'p', 'sc', or 'sp' for Spock!")

loop do # Main game loop
  choice = nil
  player_score = 0
  computer_score = 0

  loop do # First to 5 loop
    loop do # Player input loop
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp.downcase

      if VALID_CHOICES.include?(choice)
        break
      elsif PLAYER_SHORTCUTS.include?(choice)
        choice = choice_shortcut(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose #{choice}; Computer chose: #{computer_choice}")

    display_result(choice, computer_choice)

    player_score += keep_score(choice, computer_choice)
    computer_score += keep_score(computer_choice, choice)

    scoreboard(player_score, computer_score, player_name)

    break if player_score == 5 || computer_score == 5
  end

  break unless new_game?
  system('clear') || system('cls')
end

prompt("Thanks for playing! Any key to exit.")
gets
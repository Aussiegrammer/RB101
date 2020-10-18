FULL_DECK = {
  Hearts: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Diamonds: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Clubs: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Spades: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
}
FACE_CARDS = ['Jack', 'Queen', 'King']
DEALER_MAX = 17
BUST_NUMBER = 22
WINNING_SCORE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def initialise_new_deck
  deck = []
  FULL_DECK.each do |suit, values|
    current_suit = suit
    values.each do |value|
      deck << [current_suit, value]
    end
  end
  deck.shuffle
end

def deal_cards!(deck, player_hand, dealer_hand)
  2.times do
    player_hand << deck.pop
    dealer_hand << deck.pop
  end
end

def deal_single_card!(deck, hand, current_turn)
  dealt_card = deck.pop
  if current_turn == 'player'
    hand << dealt_card
    prompt "You are dealt a #{dealt_card[1]} of #{dealt_card[0]}!"
  elsif current_turn == 'dealer'
    hand << dealt_card
    prompt "The dealer hits and is dealt " \
           "a #{dealt_card[1]} of #{dealt_card[0]}!"
  end
end

def get_card_values(hand)
  card_values = []
  hand.each do |sub_arr|
    card_values << sub_arr[1]
  end
  card_values
end

def convert_hand_to_points(hand)
  card_points = 0
  card_values = get_card_values(hand)
  card_values.each do |card|
    if FACE_CARDS.include?(card)
      card_points += 10
    elsif card == 'Ace'
      card_points += 11
    else
      card_points += card
    end
  end

  card_values.select { |value| value == "Ace" }.count.times do
    card_points -= 10 if card_points > 21
  end
  card_points
end

def detect_result(player_total, dealer_total)
  if player_total > BUST_NUMBER
    :player_busted
  elsif dealer_total > BUST_NUMBER
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_winner(player_total, dealer_total)
  result = detect_result(player_total, dealer_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def display_hands(p_hand, d_hand, p_total, d_total, current_turn)
  puts "===================================="
  display_dealer_hand(d_hand, d_total, current_turn)
  display_player_hand(p_hand, p_total)
  puts "===================================="
end

def hand_concate(hand)
  array = get_card_values(hand)
  if array.size == 2
    array.join(" and ")
  else
    last = array.last
    temp_array = array[0..-2]
    temp_array.join(', ') + ", and " + last.to_s
  end
end

def dealer_reveals_hole_card(dealer_hand)
  if dealer_hand[1][1] == 'Ace'
    prompt "The dealer turns over his card, " \
         "revealing an Ace of #{dealer_hand[1][0]}"
  else
    prompt "The dealer turns over his card, " \
         "revealing a #{dealer_hand[1][1]} of #{dealer_hand[1][0]}"
  end
end

def display_dealer_hand(hand, total, current_turn)
  if current_turn == 'player'
    prompt "Dealer has: #{hand[0][1]} and an unknown card"
  elsif current_turn == 'dealer'
    prompt "Dealer hand is #{hand_concate(hand)} " \
         "worth a total of #{total}"
  end
end

def display_player_hand(hand, total)
  prompt "Your hand is #{hand_concate(hand)} " \
       "worth a total of #{total}."
end

def player_turn(deck, p_hand, d_hand, p_total, d_total)
  current_turn = 'player'
  loop do
    move = player_turn_prompt
    deal_single_card!(deck, p_hand, current_turn) if move == 'hit'
    p_total = convert_hand_to_points(p_hand)
    display_hands(p_hand, d_hand, p_total, d_total, current_turn)
    break if move == 'stay' || busted?(p_total)
  end
end

def player_turn_prompt
  valid_input = ['hit', 'h', 'stay', 's']
  answer = ''
  loop do
    prompt "Would you like to hit or stay?"
    answer = gets.chomp
    break if valid_input.include?(answer.downcase)
    prompt "Sorry, please enter hit or stay."
  end
  system('clear') || system('cls')

  case answer
  when 'h' then 'hit'
  when 's' then 'stay'
  else answer
  end
end

def dealer_turn(deck, hand, total, current_turn)
  while total <= DEALER_MAX
    deal_single_card!(deck, hand, current_turn)
    total = convert_hand_to_points(hand)
  end
end

def busted?(total)
  true if total >= BUST_NUMBER
end

def update_scores(player_total, dealer_total, scores)
  result = detect_result(player_total, dealer_total)
  if result == :player || result == :dealer_busted
    scores[:player] += 1
  elsif result == :dealer || result == :player_busted
    scores[:dealer] += 1
  end
end

def display_scores(scores)
  prompt "Player wins = #{scores[:player]} | " \
         "Dealer wins = #{scores[:dealer]}"
end

def end_round(player_total, dealer_total, scores)
  display_winner(player_total, dealer_total)
  update_scores(player_total, dealer_total, scores)
  display_scores(scores)
  enter_to_continue_round(scores)
end

def grand_winner?(scores)
  true if scores[:player] == WINNING_SCORE || scores[:dealer] == WINNING_SCORE
end

def display_grand_winner(scores)
  if scores[:player] == WINNING_SCORE
    prompt "Player wins the game!"
  elsif scores[:dealer] == WINNING_SCORE
    prompt "Dealer wins the game!"
  end
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

def enter_to_continue_round(scores)
  prompt "Press Enter for the next round." unless grand_winner?(scores)
  gets.chomp unless grand_winner?(scores)
end

def new_game?
  answer = yes_no_prompt("Would you like to play again?")
  answer.downcase.start_with?('y')
end

def display_goodbye
  system('clear') || system('cls')
  prompt "Thanks for playing Twenty-One!"
end

system('clear') || system('cls')
puts "Welcome to Twenty-One! First to five rounds wins the game!"

loop do # Main Game Loop
  scores = { player: 0, dealer: 0 }
  loop do # One Game Round
    break if grand_winner?(scores)
    system('clear') || system('cls')

    player_hand = []
    dealer_hand = []
    deck = initialise_new_deck
    deal_cards!(deck, player_hand, dealer_hand)

    p_total = convert_hand_to_points(player_hand)
    d_total = convert_hand_to_points(dealer_hand)

    current_turn = 'player'
    display_hands(player_hand, dealer_hand, p_total, d_total, current_turn)
    player_turn(deck, player_hand, dealer_hand, p_total, d_total, current_turn)

    p_total = convert_hand_to_points(player_hand)
    if busted?(p_total)
      end_round(p_total, d_total, scores)
      next
    end

    system('clear') || system('cls')
    display_dealer_hand(dealer_hand, d_total, current_turn)
    current_turn = 'dealer'
    dealer_reveals_hole_card(dealer_hand)
    dealer_turn(deck, dealer_hand, d_total, current_turn)

    d_total = convert_hand_to_points(dealer_hand)
    if busted?(d_total)
      end_round(p_total, d_total, scores)
      next
    end

    display_hands(player_hand, dealer_hand, p_total, d_total, current_turn)
    end_round(p_total, d_total, scores)
  end

  display_grand_winner(scores)
  break unless new_game?
end

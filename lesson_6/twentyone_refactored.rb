SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

FACE_CARDS = ['Jack', 'Queen', 'King']
DEALER_MAX = 17
BUST_NUMBER = 22
WINNING_SCORE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def initialise_new_deck
  SUITS.product(VALUES).shuffle
end

def deal_cards!(deck, hands)
  2.times do
    hands[:player_cards] << deck.pop
    hands[:dealer_cards] << deck.pop
  end
end

def deal_card!(deck, hands, current_turn)
  display_single_card(deck, current_turn)
  deal_single_card!(deck, hands, current_turn)
end

def deal_single_card!(deck, hands, current_turn)
  dealt_card = deck.pop
  if current_turn == 'player'
    hands[:player_cards] << dealt_card
    prompt "You are dealt a #{dealt_card[1]} of #{dealt_card[0]}!"
  elsif current_turn == 'dealer'
    hands[:dealer_cards] << dealt_card
    prompt "The dealer hits and is dealt " \
           "a #{dealt_card[1]} of #{dealt_card[0]}!"
  end
end

def display_single_card(deck, current_turn)
  dealt_card = deck.last
  if current_turn == 'player'
    prompt "You are dealt a #{dealt_card[1]} of #{dealt_card[0]}!"
  elsif current_turn == 'dealer'
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
    card_points += if FACE_CARDS.include?(card)
                     10
                   elsif card == 'Ace'
                     11
                   else
                     card
                   end
  end

  correct_for_aces(card_values, card_points)
  card_points
end

def correct_for_aces(card_values, card_points)
  card_values.select { |value| value == "Ace" }.count.times do
    card_points -= 10 if card_points > 21
  end
  card_points
end

def detect_result(hands)
  if hands[:player_total] >= BUST_NUMBER
    :player_busted
  elsif hands[:dealer_total] >= BUST_NUMBER
    :dealer_busted
  elsif hands[:dealer_total] < hands[:player_total]
    :player
  elsif hands[:dealer_total] > hands[:player_total]
    :dealer
  else
    :tie
  end
end

def display_winner(hands)
  result = detect_result(hands)

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

def display_hands(hands, current_turn)
  puts "===================================="
  display_dealer_hand(hands, current_turn)
  display_player_hand(hands)
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

def display_dealer_hole_card(dealer_hand)
  if dealer_hand[1][1] == 'Ace'
    prompt "The dealer turns over his card, " \
         "revealing an Ace of #{dealer_hand[1][0]}"
  else
    prompt "The dealer turns over his card, " \
         "revealing a #{dealer_hand[1][1]} of #{dealer_hand[1][0]}"
  end
end

def display_dealer_hand(hands, current_turn)
  if current_turn == 'player'
    prompt "Dealer has: #{hands[:dealer_cards][0][1]} and an unknown card"
  elsif current_turn == 'dealer'
    prompt "Dealer hand is #{hand_concate(hands[:dealer_cards])} " \
         "worth a total of #{hands[:dealer_total]}"
  end
end

def display_player_hand(hands)
  prompt "Your hand is #{hand_concate(hands[:player_cards])} " \
       "worth a total of #{hands[:player_total]}."
end

def player_turn(deck, hands, current_turn)
  loop do
    move = player_turn_prompt
    deal_card!(deck, hands, current_turn) if move == 'hit'
    hands[:player_total] = convert_hand_to_points(hands[:player_cards])
    display_hands(hands, current_turn)
    break if move == 'stay' || busted?(hands[:player_total])
  end
end

def player_turn_prompt
  valid_input = ['hit', 'h', 'stay', 's']
  answer = ''
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp
    break if valid_input.include?(answer.downcase)
    prompt "Sorry, please enter hit or stay."
  end
  clear_screen

  case answer
  when 'h' then 'hit'
  when 's' then 'stay'
  else answer
  end
end

def dealer_turn(deck, hands, current_turn)
  while hands[:dealer_total] <= DEALER_MAX
    deal_card!(deck, hands, current_turn)
    hands[:dealer_total] = convert_hand_to_points(hands[:dealer_cards])
  end
end

def busted?(total)
  true if total >= BUST_NUMBER
end

def update_scores(hands, scores)
  result = detect_result(hands)
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

def end_round(hands, scores)
  display_winner(hands)
  update_scores(hands, scores)
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

def clear_screen
  system('clear') || system('cls')
end

def display_goodbye
  clear_screen
  prompt "Thanks for playing Twenty-One! Press Enter to exit."
  gets.chomp
end

clear_screen
puts "Welcome to Twenty-One! First to five rounds wins the game!"
prompt "Please press Enter to begin."
gets.chomp

loop do # Main Game Loop
  scores = { player: 0, dealer: 0 }
  loop do # One Game Round
    break if grand_winner?(scores)
    clear_screen

    hands = { player_cards: [], dealer_cards: [],
              player_total: 0, dealer_total: 0 }

    deck = initialise_new_deck
    deal_cards!(deck, hands)

    hands[:player_total] = convert_hand_to_points(hands[:player_cards])
    hands[:dealer_total] = convert_hand_to_points(hands[:dealer_cards])

    current_turn = 'player'
    display_hands(hands, current_turn)
    player_turn(deck, hands, current_turn)

    hands[:player_total] = convert_hand_to_points(hands[:player_cards])
    if busted?(hands[:player_total])
      end_round(hands, scores)
      next
    end

    clear_screen
    display_dealer_hand(hands, current_turn)
    current_turn = 'dealer'
    display_dealer_hole_card(hands[:dealer_cards])
    dealer_turn(deck, hands, current_turn)

    hands[:dealer_total] = convert_hand_to_points(hands[:dealer_cards])
    if busted?(hands[:dealer_total])
      end_round(hands, scores)
      next
    end

    display_hands(hands, current_turn)
    end_round(hands, scores)
  end

  display_grand_winner(scores)
  break unless new_game?
end

display_goodbye

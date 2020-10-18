=begin

1. Initialize deck
Create a full deck of 52 cards
When dealing cards, remove the associated value from the deck

2. Deal cards to player and dealer
Initialise a blank array for dealer and player
Deal two cards to each
Each card is a sub array of the key value pairs
Display the value of the dealer's first card, hiding the second
Display the value of the player's two cards


3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
If they bust, instantly game over. Reveal the game's result and all hands
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

=end

FULL_DECK = {
  Hearts: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Diamonds: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Clubs: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
  Spades: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
}
FACE_CARDS = ['Jack', 'Queen', 'King']
DEALER_MAX = 17
BUST_NUMBER = 22

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
    dealt_card = deck.pop
    player_hand << dealt_card
    dealt_card = deck.pop
    dealer_hand << dealt_card
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
      card_points += 1
    else
      card_points += card
    end
  end
  card_points
end

def display_hands(player_hand, dealer_hand, current_turn)
  display_dealer_hand(dealer_hand, current_turn)
  display_player_hand(player_hand)
end

def hand_concate(hand)
  array = get_card_values(hand)
  if array.size == 2
    array.join(" and ")
  else
    last = array.last
    temp_array = array[0..-2]
    temp_array.join(', ') + "#{', and '}" + last.to_s
  end
end

def display_dealer_hand(hand, current_turn)
  if current_turn == 'player'
    puts "Dealer has: #{hand[0][1]} and an unknown card"
  elsif current_turn == 'dealer'
    puts "Dealer has: #{hand_concate(hand)}"
  end
end

def display_player_hand(hand)
  puts "You have: #{hand_concate(hand)}"
end

def deal_single_card!(deck, hand)
  hand << deck.pop
end

def player_turn(deck, player_hand)
  loop do
    move = player_turn_prompt
    deal_single_card!(deck, player_hand) if move == 'hit'
    display_player_hand(player_hand)
    break if move == 'stay' || busted?(player_hand)
  end
end

def player_turn_prompt
  valid_input = ['hit', 'h', 'stay', 's']
  answer = ''
  loop do
    prompt "Would you like to hit or stay?"
    answer = gets.chomp
    break if valid_input.include?(answer.downcase)
    puts "Sorry, please enter hit or stay."
  end

  case answer
  when 'h' then 'hit'
  when 's' then 'stay'
  else answer
  end
end

def dealer_turn(deck, dealer_hand)
  while convert_hand_to_points(dealer_hand) <= DEALER_MAX do
    deal_single_card!(deck, dealer_hand)
  end
end

def busted?(hand)
  true if convert_hand_to_points(hand) >= BUST_NUMBER
end

player_hand = []
dealer_hand = []
current_turn = ''

loop do
  deck = initialise_new_deck
  deal_cards!(deck, player_hand, dealer_hand)

  current_turn = 'player'
  display_hands(player_hand, dealer_hand, current_turn)
  player_turn(deck, player_hand)
  if busted?(player_hand)
    puts "Bust! Dealer wins!"
    break
  end

  puts "The Dealer turns over his card."
  current_turn = 'dealer'
  display_hands(player_hand, dealer_hand, current_turn)
  dealer_turn(deck, dealer_hand)
  if busted?(dealer_hand)
    puts "Bust! Player wins!"
    break
  end

  display_hands(player_hand, dealer_hand, current_turn)
  puts "Dealer's total is: #{convert_hand_to_points(dealer_hand)}"
  puts "Player's total is: #{convert_hand_to_points(player_hand)}"

  break
end

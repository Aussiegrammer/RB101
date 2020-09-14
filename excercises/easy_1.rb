def repeat(string, number)
  number.times { puts string } 
end

repeat("Hello", 2)

def is_odd?(number)
  number.remainder(2) != 0
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-10)
puts is_odd?(-13)

def digit_list(numbers)
  digit_list = []
  numbers_array = numbers.to_s.split("")
  numbers_array.each { |number| digit_list << number.to_i }
  digit_list
end

p digit_list(12345)

def digit_list(number)
  number.to_s.chars.map(&:to_i) # .map iterates through, (&:to_i) = { |char| char.to_i }
end

def count_vehicles(array)
  vehicle_count = {}
  array.each do |vehicle|
    if vehicle_count[vehicle] 
      vehicle_count[vehicle] += 1
    else
      vehicle_count[vehicle] = 1
    end
  end
  vehicle_count
end
  
vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

p count_vehicles(vehicles)

# Alternative using Array's count method: 

def count_occurrences(array)
  occurrences = {}

  array.uniq.each do |element|
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end

def reverse_sentence(string)
  string.split.reverse.join(' ')
end


string = "Hello world"
reversed_words = reverse_sentence(string)

p reversed_words

def reverse_words(string)
  string_reversed = ""
  string.split.each do |word|
    if word.length >= 5
      string_reversed << word.reverse + " "
    else
      string_reversed << word + " "
    end
  end
  string_reversed.rstrip
end

p reverse_words("Professional")
p reverse_words("Walk around the block")
p reverse_words("Launch School")

# Probably better solution: 

def reverse_words(string)
  words = []

  string.split.each do |word|
    word.reverse! if word.size >= 5
    words << word
  end

  words.join(' ') # <-- Use .join more
end

def stringy(number)
  string = ''
  increment = 0
  number.times do
    increment += 1
    if increment.odd?
      string << '1'
    else
      string << '0'
    end
  end
  string
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

# Alternative using array

def stringy(size)
  numbers = []

  size.times do |index|
    number = index.even? ? 1 : 0
    numbers << number
  end

  numbers.join
end

def average(numbers)
  total = 0
  numbers.each { |number| total += number }
  total / numbers.count
end

puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40
p average([9, 47, 23, 95, 16, 52])

def sum(number)
  number.digits.reduce(:+)
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45
  
def calculate_bonus(number, bool)
  if bool
    number / 2
  else
    0
  end
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000

# One liner alternative

def calculate_bonus(salary, bonus)
  bonus ? (salary / 2) : 0
end


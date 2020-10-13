alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_chars = ''
counter = 0

loop do
  current_char = alphabet[counter]
  
  if current_char == 'g'
    selected_chars << current_char
  end
  counter +=1 
  break if counter == alphabet.size
end

p selected_chars #==> 'g'

fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

(fruits.size).times do
  current_element = fruits[counter]
  transformed_elements << current_element + 's'
  counter += 1
end

p transformed_elements # => ["apples", "bananas", "pears"]

def select_vowels(str)
  selected_chars = ''
  counter = 0
  
  loop do
    current_char = str[counter]
    
    if 'aeiouAEIOU'.include?(current_char)
      selected_chars << current_char
    end
    
    counter += 1
    break if counter == str.size
  end
  
  selected_chars
end

puts select_vowels('the quick brown fox')      # => "euioo"
sentence = 'I wandered lonely as a cloud'
puts select_vowels(sentence)                   # => "Iaeeoeaaou"

number_of_vowels = select_vowels('hello world').size
p number_of_vowels # => 3

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce) 
  selected_keys = {}

  produce.keys.each do |key|
    if produce[key] == 'Fruit'
      selected_keys[key] = 'Fruit'
    end
  end

  selected_keys
end

p select_fruit(produce)

def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    doubled_numbers << current_number * 2

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]
# My numbers remains unmuted. 

# Can you implement a double_numbers! method that mutates its argument?

def double_numbers!(numbers)
  counter = 0
  loop do
    break if counter == numbers.size
    numbers[counter] *= 2
    counter += 1
  end
end

double_numbers!(my_numbers)
p my_numbers # Original array has been mutated. 

def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if current_number.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_odd_numbers(my_numbers)  # => [2, 4, 6, 14, 2, 6]

# not mutated
my_numbers                      # => [1, 4, 3, 7, 2, 6]

# Exercise for the reader: What if we wanted to transform the numbers based on their position in the array rather than their value?

def double_odd_indexes(numbers)
  doubled_numbers = []
  counter = 0
  
  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd? # => Changed to counter
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

# Try coding a method that allows you to multiply every array item by a specified value

def multiply_numbers!(numbers, multiple)
  counter = 0
  loop do
    break if counter == numbers.size
    numbers[counter] *= multiple
    counter += 1
  end
end

my_numbers = [1, 4, 3, 7, 2, 6]
multiply_numbers!(my_numbers, 3)
p my_numbers == [3, 12, 9, 21, 6, 18]

def select_letter(string, character)
  selected_chars = ''
  counter = 0
  
  loop do
    break if counter == string.size
    current_char = string[counter]
    
    if current_char == character
      selected_chars << current_char
    end
    counter += 1
  end
  
  selected_chars
end

question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a').size # => "aaaaaaaa"
p select_letter(question, 't').size # => "ttttt"
p select_letter(question, 'z').size  # => ""
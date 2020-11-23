# Welcome Stranger
# Create a method that takes 2 arguments, an array and a hash. The array will contain 2 or more elements that, when combined with adjoining spaces, will produce a person's name.
# The hash will contain two keys, :title and :occupation, and the appropriate values.
# Your method should return a greeting that uses the person's full name, and mentions the person's title and occupation.

def greetings(name, job)
  puts "Hello, #{name.join(" ")}! Nice to have a" \
       "#{job[:title]} #{job[:occupation]} around."
end

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
# => Hello, John Q Doe! Nice to have a Master Plumber around.
puts
# Double Doubles
# A double number is a number with an even number of digits whose left-side digits are exactly the same as its right-side digits.
# For example, 44, 3333, 103103, 7676 are all double numbers. 444, 334433, and 107 are not.

# Write a method that returns 2 times the number provided as an argument,
# unless the argument is a double number; double numbers should be returned as-is.

def twice(number)
  string_number = number.to_s
  center = string_number.size / 2
  left_side = center.zero? ? '' : string_number[0..center - 1]
  right_side = string_number[center..-1]
  if left_side == right_side
    number
  else
    number * 2
  end
end



p twice(37) == 74
p twice(44) == 44
p twice(334433) == 668866
p twice(444) == 888
p twice(107) == 214
p twice(103103) == 103103
p twice(3333) == 3333
p twice(7676) == 7676
p twice(123_456_789_123_456_789) == 123_456_789_123_456_789
p twice(5) == 10
puts

# Always Return Negative
# Write a method that takes a number as an argument. If the argument is a positive number, return the negative of that number. If the number is 0 or negative, return the original number.

def negative(number)
  if number > 0
    number * -1
  elsif number < 0
    number
  else
    0
  end
end


# LS Solution uses a ternary - condition ? true : false

def negative(number)
  number > 0 ? -number : number
end

p negative(5) == -5
p negative(-3) == -3
p negative(0) == 0      # There's no such thing as -0 in ruby

puts


# Counting Up
# Write a method that takes an integer argument, and returns an Array of all integers, in sequence, between 1 and the argument.
# You may assume that the argument will always be a valid integer that is greater than 0.

def sequence(int)
  if int > 0
    (1..int).to_a
  else
    (int..-1).to_a
  end
end

# Remember to use ternary for condition true / false

def sequence(num)
  num >= 1 ? (1..num).to_a : (num..-1).to_a
end
p sequence(5) == [1, 2, 3, 4, 5]
p sequence(3) == [1, 2, 3]
p sequence(1) == [1]
p sequence(-5)
puts

# Uppercase Check
# Write a method that takes a string argument, and returns true if all of the alphabetic
# characters inside the string are uppercase, false otherwise. Characters that are not alphabetic should be ignored.

def uppercase?(string)
  string == string.upcase
end

p uppercase?('t') == false
p uppercase?('T') == true
p uppercase?('Four Score') == false
p uppercase?('FOUR SCORE') == true
p uppercase?('4SCORE!') == true
p uppercase?('') == true
puts

# How long are you?
# Write a method that takes a string as an argument,
# and returns an Array that contains every word from the string,
# to which you have appended a space and the word length.

def word_lengths(string)
  string.split.map do |word|
    "#{word} #{word.length}"
  end
end

p word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

p word_lengths("baseball hot dogs and apple pie") ==
  ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

p word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

p word_lengths("Supercalifragilisticexpialidocious") ==
  ["Supercalifragilisticexpialidocious 34"]

p word_lengths("") == []
puts

# Name Swapping
# Write a method that takes a first name, a space,
# and a last name passed as a single String argument, and returns a string that contains the last name, a comma, a space, and the first name.

def swap_name(string)
  first_name, last_name = string.split
  full_name = "#{last_name}, #{first_name}"
  full_name
end

# LS Method:

def swap_name(name)
  name.split(' ').reverse.join(', ')
end

p swap_name('Joe Roberts') == 'Roberts, Joe'
puts
# Sequence Count
# Create a method that takes two integers as arguments.
# The first argument is a count, and the second is the first number of a sequence that your method will create.
# The method should return an Array that contains the same number of elements as the count argument,
# while the values of each element will be multiples of the starting number.

def sequence(count, multi)
  result = []
  count.times do |n|
    result << (n + 1) * multi
  end
  result
end

p sequence(5, 1) == [1, 2, 3, 4, 5]
p sequence(4, -7) == [-7, -14, -21, -28]
p sequence(3, 0) == [0, 0, 0]
p sequence(0, 1000000) == []
puts

# Grade book
# Write a method that determines the mean (average) of the three scores passed to it,
# and returns the letter value associated with that grade.

def get_grade(score1, score2, score3)
  average = (score1 + score2 + score3) / 3
  case average
  when 90..100 then "A"
  when 80..89 then "B"
  when 70..79 then "C"
  when 60..69 then "D"
  when 0..59 then "F"
  else "???"
  end
end

p get_grade(95, 90, 93) == "A"
p get_grade(50, 50, 95) == "D"
puts

# Grocery List
# Write a method which takes a grocery list (array) of fruits with quantities and converts it into an array of the correct number of each fruit.

def buy_fruit(array)
  result = []
  array.each do |sub_arr|
      sub_arr[1].times do
        result << sub_arr[0]
      end
    end

  result
end
p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) # == ["apples", "apples", "apples", "orange", "bananas","bananas"]

#LS Solutions, each method but a little cleaner:


def buy_fruit(list)
  expanded_list = []

  list.each do |item|
    fruit, quantity = item[0], item[1]
    quantity.times { expanded_list << fruit }
  end

  expanded_list
end

#Map method I attempted, but didn't know the implementation:

def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten # [fruit] * quantity => ["apples", "apples", "apples"]
end

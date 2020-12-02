# Rotation (Part 1)
# Write a method that rotates an array by moving the first element to the end of the array. The original array should not be modified.

def rotate_array(array)
  new_array = array.dup
  new_array.push(new_array.shift)
  new_array
end

# LS Solution, requires no new variable and instead returns the value we're looking for:

def rotate_array(array)
  array[1..-1] + [array[0]]
end

# Further Exploration:

def rotate_string(string)
  rotate_array(string.chars).join("")
end

def rotate_integer(int)
  rotate_array(int.digits.reverse).join
end

p rotate_array([7, 3, 5, 2, 9, 1])  == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']
p
p x = [1, 2, 3, 4]
p rotate_array(x) == [2, 3, 4, 1]   # => true
p x == [1, 2, 3, 4]                 # => true

p rotate_string("Hello")
p rotate_integer(12345)

puts

def rotate_rightmost_digits(number, range)
  number_array = number.digits.reverse
  range_array = number_array.slice!(-range..-1)
  (number_array + rotate_array(range_array)).join("").to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917

puts

# If you take a number like 735291, and rotate it to the left, you get 352917.
# If you now keep the first digit fixed in place, and rotate the remaining digits, you get 329175.
# Keep the first 2 digits fixed in place and rotate again to 321759. Keep the first 3 digits fixed in place and rotate again to get 321597.
# Finally, keep the first 4 digits fixed in place and rotate the final 2 digits to get 321579.
# The resulting number is called the maximum rotation of the original number.

def max_rotation(number)
  number_array = number.digits
  number_length = number_array.length
  (0..number_length - 1).each do |n|
    number = rotate_rightmost_digits(number, number_length - n)
  end
  number
end

p max_rotation(735291)== 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845

puts
# You have a bank of switches before you, numbered from 1 to n.
# Each switch is connected to exactly one light that is initially off.
# You walk down the row of switches and toggle every one of them. You go back to the beginning,
# and on this second pass, you toggle switches 2, 4, 6, and so on. On the third pass,
# you go back again to the beginning and toggle switches 3, 6, 9, and so on. You repeat this process and keep going until you have been through n repetitions.

# Create an array called 'switches' that consists of 0's
# Iterating through the switches array with an incremental 'n' of 1, by length times.
  # n is the step size
  # n increments by 1 every iteration
  # With each iteration, iterate again with a double iteration
    # Take n steps, flick a 0 to 1, or a 1 to 0
    # Iterate until we exit the bounds of the array
# Once done, our switches array should consist of various 1's and 0's
# Return a new array consisting with the index + 1 position of all 1's in the switches array

def initialize_switches(number)
  Array.new(number, 0)
end

def flip_switch(switch)
  switch == 0 ? 1 : 0
end

def return_switches(switches)
  i = 0
  switches = switches.map do |switch|
    i += 1
    i if switch == 1
  end
switches.compact
end

def thousand_lights(n)
  switches = initialize_switches(n)
  step = 1
  switches.each do |_|
    (step-1..n-1).step(step).each do |index|
      switches[index] = flip_switch(switches[index])
    end
    step += 1
  end
  return_switches(switches)
end

p thousand_lights(5)
p thousand_lights(10)
p thousand_lights(1000)

puts

# Write a method that displays a 4-pointed diamond in an n x n grid,
# where n is an odd integer that is supplied as an argument to the method.
# You may assume that the argument will always be an odd integer.

def diamond(size)
  (1..size).step(2) do |n|
    spacing = (size - n) / 2
    stars = n
    puts (" " * spacing) + ("*" * stars) + (" " * spacing)
  end
  (-size+2..-1).step(2) do |n|
    n *= -1
    spacing = (size - n) / 2
    stars = n
    puts (" " * spacing) + ("*" * stars) + (" " * spacing)
  end
end

diamond(3)

# Write a method that takes a sentence string as input,
# and returns the same string with any sequence of the words 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.
DIGIT_HASH = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}


def word_to_digit(words)
  DIGIT_HASH.keys.each do |word|
    words.gsub!(/\b#{word}\b/, DIGIT_HASH[word])
  end
  words
end


p word_to_digit('Please call me at five five five one two three four. Thanks.')#  == 'Please call me at 5 5 5 1 2 3 4. Thanks.'
puts

# Write a recursive method that computes the nth Fibonacci number, where nth is an argument to the method.

def fibonacci(nth)
  return 1 if nth <= 2
  fibonacci(nth - 1) + fibonacci(nth - 2)
end

p fibonacci(1) == 1
p fibonacci(2) == 1
p fibonacci(3) == 2
p fibonacci(4) == 3
p fibonacci(5) == 5
p fibonacci(12) == 144
p fibonacci(20) == 6765
puts

def fibonacci_tail(nth, acc1, acc2)
  if nth == 1
    acc1
  elsif nth == 2
    acc2
  else
    fibonacci_tail(nth - 1, acc2, acc2 + acc1)
  end
end

def fibonacci(nth)
  fibonacci_tail(nth, 1, 1)
end

p fibonacci(8000)


def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end

  last
end

def fibonacci_last(nth)
  fibonacci(nth).to_s[-1].to_i
end


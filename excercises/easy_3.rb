# Write a program that solicits 6 numbers from the user, then prints a message that describes whether or not the 6th number appears amongst the first 5 numbers.

array = []
puts "==> Enter the 1st number:"
array << 25
puts "==> Enter the 2nd number:"
array << 15
puts "==> Enter the 3rd number:"
array << 20
puts "==> Enter the 4th number:"
array << 17
puts "==> Enter the 5th number:"
array << 23
puts "==> Enter the last number:"
# comparison = gets.to_i
comparison = 17

if array.include?(comparison) 
  puts "The number #{comparison} appears in #{array}"
else
  puts "The number #{comparison} does not appear in #{array}"
end

# Write a program that prompts the user for two positive integers, and then prints the results of the following operations on those two numbers: 
# addition, subtraction, product, quotient, remainder, and power. Do not worry about validating the input.


puts "==> Enter the first number:"
# num1 = gets.to_i
num1 = 10
puts "==> Enter the second number:"
# num2 = gets.to_i
num2 = 5

puts "==> #{num1} + #{num2} = #{num1 + num2}"
puts "==> #{num1} - #{num2} = #{num1 - num2}"
puts "==> #{num1} * #{num2} = #{num1 * num2}"
puts "==> #{num1} / #{num2} = #{num1 / num2}"
puts "==> #{num1} % #{num2} = #{num1 % num2}"
puts "==> #{num1} ** #{num2} = #{num1 ** num2}"

# Write a program that will ask a user for an input of a word or multiple words and give back the number of characters. 
# Spaces should not be counted as a character.

puts "==> Please write a word or multiple words"
# input = gets.chomp
input = "words words words"
total = 0
input.split(" ").each { |word| total += word.length } 
puts "There are #{total} characters in #{input}"

# Alternative:

print 'Please write word or multiple words: '
# input = gets.chomp
number_of_characters = input.delete(' ').size
puts "There are #{number_of_characters} characters in \"#{input}\"."

# Create a method that takes two arguments, multiplies them together, and returns the result.

def multiply(num1, num2)
  num1 * num2
end

puts multiply(5, 5)

def square(num)
  multiply(num, num)
end

puts square(5)

# Exclusive Or

def xor?(cond1, cond2)
  if cond1 && cond2
    return false
  elsif cond1 || cond2
    true
  else 
    return false
  end
end

# Alternative, probably best method

def xor?(value1, value2)
  return true if value1 && !value2
  return true if value2 && !value1
  false
end

# Even shorter just because ruby 

def xor?(value1, value2)
  !!((value1 && !value2) || (value2 && !value1))
end

p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false

# Write a method that returns an Array that contains every other element of an Array that is passed in as an argument. 
# The values in the returned list should be those values that are in the 1st, 3rd, 5th, and so on elements of the argument Array.

def oddities(array)
  odd_elements = []
  iterator = 0
  array.each do |element|
    iterator += 1
    odd_elements << element if iterator.odd?
  end
  odd_elements
end

def oddities(array) # This works, but has an edge case if there's a duplicate entry in the array it will delete them both. 
  iterator = 0
  array.each do |index|
    iterator += 1
    array.delete(index) if iterator.even?
  end
end

def oddities(array) # LS Provided solution 
  odd_elements = []
  index = 0
  while index < array.size
    odd_elements << array[index]
    index += 2
  end
  odd_elements
end
  
def oddities(array)
  array.select { |element| array.index(element).even? } 
end

p oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
p oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
p oddities(['abc', 'def']) == ['abc']
p oddities([123]) == [123]
p oddities([]) == []

# Write a method that returns true if the string passed as an argument is a palindrome, false otherwise.
# A palindrome reads the same forward and backward. For this exercise, case matters as does punctuation and spaces.

def palindrome?(string)
  string == string.reverse
end

p palindrome?('madam') == true
p palindrome?('Madam') == false          # (case matters)
p palindrome?("madam i'm adam") == false # (all characters matter)
p palindrome?('356653') == true

def palindrome?(array) # works for both anyways 
  array == array.reverse
end

p palindrome?([1, 3, 1]) == true
  
def real_palindrome?(string)
  string = string.downcase.delete('^a-z0-9')
  palindrome?(string)
end

puts


p real_palindrome?('madam') == true
p real_palindrome?('Madam') == true           # (case does not matter)
p real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
p real_palindrome?('356653') == true
p real_palindrome?('356a653') == true
p real_palindrome?('123ab321') == false

# Write a method that returns true if its integer argument is palindromic, false otherwise. A palindromic number reads the same forwards and backwards.

def palindromic_number?(int)
  int == int.digits.join.to_i
end

# LS Method
def palindromic_number?(number)
  palindrome?(number.to_s)
end

puts 

p palindromic_number?(34543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(5) == true


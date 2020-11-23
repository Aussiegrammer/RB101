# Sum of Sums
# Write a method that takes an Array of numbers and then returns the sum of the sums
# of each leading subsequence for that Array. You may assume that the Array always contains at least one number.

def sum_of_sums(arr)
  total = 0
  running_total = 0
  arr.each do |num|
    total += (running_total + num)
    running_total += num
  end
  total
end

p sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
p sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
p sum_of_sums([4]) == 4
p sum_of_sums([1, 2, 3, 4, 5]) == 35

puts

# Madlibs
# Create a simple mad-lib program that prompts for a noun, a verb, an adverb, and an adjective and injects those into a story that you create.

def madlibs
  puts "Enter a noun: "
  noun = gets.chomp
  puts "Enter a verb: "
  verb = gets.chomp
  puts "Enter an adjective: "
  adjective = gets.chomp
  puts "Enter an adverb: "
  adverb = gets.chomp

  puts "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"
end

# madlibs

# Leading Substrings
# Write a method that returns a list of all substrings of a string that start at the beginning of the original string.
# The return value should be arranged in order from shortest to longest substring.


def leading_substrings(string)
  substrings = []
  (0..string.length - 1).each do |index|
    substrings << string[0..index]
  end
  substrings
end

# LS Solution, many looping methods work. Upto is one of them. Similar to range

def leading_substrings(string)
  result = []
  0.upto(string.size - 1) do |index|
    result << string[0..index]
  end
  result
end

p leading_substrings('abc') == ['a', 'ab', 'abc']
p leading_substrings('a') == ['a']
p leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']

puts

# All Substrings
# Write a method that returns a list of all substrings of a string. The returned list should be ordered by where in the string the substring begins.

def substrings(string)
  result = []
  starting_index = 0
  (string.length).times do
    (starting_index..string.length - 1).each do |index|
      result << string[starting_index..index]
    end
  starting_index += 1
  end
  substrings
end

# Take two, use the method don't recreate it!

def substrings(string)
  result = []
  (0..string.length - 1).each do |start_index|
    result << leading_substrings(string[start_index..string.length])
  end
  result.flatten
end


p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]

puts

# Palindromic Substrings
# Write a method that returns a list of all substrings of a string that are palindromic. That is, each substring must consist of the same sequence of characters forwards as it does backwards.
# The return value should be arranged in the same sequence as the substrings appear in the string. Duplicate palindromes should be included multiple times.

def palindromes(string)
  substrings(string).select do |substring|
    true if palindrome?(substring)
  end
end

def palindrome?(string)
  string == string.reverse && string.size > 1
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
puts

# fizzbuzz
# Write a method that takes two arguments: the first is the starting number, and the second is the ending number.
# Print out all numbers between the two numbers, except if a number is divisible by 3, print "Fizz", if a number is divisible by 5, print "Buzz", and finally if a number is divisible by 3 and 5, print "FizzBuzz".


def fizzbuzz(first, last)
  result = []
  (first..last).each do |i|
    if i % 3 == 0 && i % 5 == 0
      result << "FizzBuzz"
    elsif i % 3 == 0
      result << "Fizz"
    elsif i % 5 == 0
      result << "Buzz"
    else
      result << i
    end
  end
  result.join(", ")
end

p fizzbuzz(1, 15)
puts

# Double Char (Part 1)
# Write a method that takes a string, and returns a new string in which every character is doubled.

def repeater(string)
  repeated_string = ""
  string.size.times do |index|
    repeated_string << string[index] * 2
  end
  repeated_string
end

p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''

puts

# Double Char (Part 2)

# Write a method that takes a string, and returns a new string in which every consonant character is doubled.
# Vowels (a,e,i,o,u), digits, punctuation, and whitespace should not be doubled.


def double_consonants(string)
  repeated_string = ""
  string.size.times do |index|
    if string[index].count("^aeiouAEIOU", "a-zA-Z") > 0
      repeated_string << string[index] * 2
    else
      repeated_string << string[index]
    end
  end
  repeated_string
end

# Proper Regex

def double_consonants(str)
  result = ''
  str.size.times do |idx|
    if str[idx] =~ /[a-z&&[^aeiou]]/i # consonants
      result << str[idx] * 2
    else
      result << str[idx]
    end
  end

  result
end

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""
puts

# Reverse the Digits In a Number

# Write a method that takes a positive integer as an argument and returns that number with its digits reversed. Examples:

def reversed_number(number)
  number.digits.join("").to_i
end

p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # No leading zeros in return value!
p reversed_number(12003) == 30021
p reversed_number(1) == 1
puts

# Get The Middle Character

# Write a method that takes a non-empty string argument, and returns the middle character or characters of the argument.
# If the argument has an odd length, you should return exactly one character.
# If the argument has an even length, you should return exactly two characters.

def center_of(string)
  center_index = string.size / 2
  if string.size % 2 == 0
    string[center_index - 1, 2]
  else
    string[center_index]
  end
end


p center_of('I love ruby') == 'e'
p center_of('Launch School') == ' '
p center_of('Launch') == 'un'
p center_of('Launchschool') == 'hs'
p center_of('x') == 'x'

#
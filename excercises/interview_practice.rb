# Given a non-empty string check if it can be constructed by taking a substring of it and appending multiple copies of the substring together.

# Input - String
# Output - Bool

# Rules - Explicit
  # => Lowercase input
  # => Must repeat at least twice
  #     - Implicit
  # => Repeat any amount of times

# Create a substring x letters long from the start of the given string
  # Return false if substring length exceeds string length / 2
# Increment i until substring length * i matches or exceeds the given string length
# Compare and see if they are the same
# If they are, return true

def repeated_substring_pattern(string)
  0.upto(string.length / 2) do |end_index|
    substring = string[0..end_index]
    i = 1
    i += 1 until (substring * i).length >= string.length
    return true if substring * i == string
  end
  false
end

p repeated_substring_pattern("abab") == true
p repeated_substring_pattern("aba") == false
p repeated_substring_pattern("aabaaba") == false
p repeated_substring_pattern("abaababaab")  == true
puts

# Given an array of strings made up from only lowercase letters, return an array of all characters that show up in all strings within the given array (including duplicates)

# Input - An array of lowercase strings
# Return - An array of every character that appears in all strings, array, seperately
  # If char appears twice in each string, return arr should include two

# Create a new empty array called 'results'
# Create a new empty hash called 'count'
# Iterate through the array of strings
  # Break down the first string into characters and check the following strings to see if they include the current character
  # If they all do, then add the character into results array
  # Also add the character to our count hash with the value of plus 1
    # If we check another character and it is included in our count hash, then only add the character to the results array if every substring has x + 1 count of the letter

def common_chars(arr)
  results = []
  count_hash = {}
  arr[0].chars.each do |char|
    if arr[1..arr.length].all? { |string| string.include?(char) }
      if count_hash.has_key?(char)
        results << char if arr[1..arr.length].all? { |string| string.count(char) >= count_hash[char] + 1 }
        count_hash[char] += 1
      else
        results << char
        count_hash[char] = 1
      end
    end
  end
  results
end

def common_chars(arr)
  arr = arr.map { |word| word.clone }

  arr.shift.chars.select do |char|
    arr.all? do |string|
      string.sub!(char, "")
    end
  end
end

arr = ['bella', 'label', 'roller']

p common_chars(arr)
p common_chars(['cool', 'lock', 'cook'])

p arr
puts


# You have to create a method that takes a positive integer number and returns the next bigger number formed by the same digits

# 12 ==> 21
# 513 ==> 531
# 2017 ==> 2071
# If no bigger number can be composed using those digits, return -1

# 9 ==> -1
# 111 ==> -1

# Input - Int
# Output - Next largest int with same digits, or -1

# Rules -
  # It is the NEXT biggest number, not the largest
  # Return -1 if it is already the max size of the digits

# Take the input number and determine the maximum possible number
  # => If the maximum possible == the input number, return -1

# Create a new integer 'max' which is the maximum possible number with the digits given
# Increment the given number by 1, and check if its max is the same as 'max'
  # If it is, return the number
  # Else, increment again

def next_biggest_num(n)
  max = n.digits.sort { |a,b| b <=> a }.join.to_i
  return -1 if n == max
  loop do
    n += 1
    return n if n.digits.sort { |a,b| b <=> a }.join.to_i == max
  end
end

p next_biggest_num(9)
p next_biggest_num(12)
p next_biggest_num(513)
p next_biggest_num(2017)
p next_biggest_num(111)
p next_biggest_num(531)
p next_biggest_num(123456789)
puts

# The maximum sum subaray problem consists in finding the maximum sum of a contiguous subsequence in an array of integers:

# maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# -- Should be 6: [4, -1, 2, 1]
# Easy case is when the array is made up of only positive numbers and the maximum sum is the sum of the whole array. If the array is made up of only negative numbers, return 0 instead.

# Empty array is considered to have zero greatest sum. Note that the empty array is also a valid sub array.


# Input - Array of numbers
# Output - Integer result. If all negative numbers return 0

# Rules - Explicit
  # => If empty array, return 0
  # => If ALL positive, add all numbers
  # => If ALL negative, return 0
# Rules - Implicit
  # => A sub array of negative numbers and one positive number could return the positive number

# Create a results variable of int 0
# Iterate through the array, creating a sub array starting at the first number as 'current number'
  # Sum all of the numbers in the sub array from first to last
  # If it is larger than our current result, assign the sum to result
  # Iterate from current number to last - 1, repeating the sum and assignment if it is larger
    # Move current_number +1 once we reach a sub_array size of 1

def max_sequence(arr)
  results = 0
  0.upto(arr.length) do |start_index|
    start_index.upto(arr.length) do |end_index|
      results = arr[start_index, end_index].sum if arr[start_index,  end_index].sum > results
    end
  end
  results
end

p max_sequence([]) == 0
p max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
p max_sequence([11]) == 11
p max_sequence([-32]) == 0
p max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12
puts

# Write a method to find the longest common prefix string among an array of strings

# If there is no common prefix, return an empty string "".

# Example 1:

# Input: ["flower, "flow", "flight"]
# Output: "fl"

# All inputs are lowercase letters a-z

# Initialize an empty string called results
# Iterate through the characters of the first string in the array with index position
  # Iterate through the rest of the strings in the array
  # => If the current character matches the character of each string in the array at the same index position, add the character to results

# Return results

def common_prefix(arr)
  results = ''
  arr[0].chars.each_with_index do |char, index|
    if arr[1..-1].all? { |string| string[index] == char }
      results << char
    else
      return results
    end
  end
end


p common_prefix(["flower", "flow", "fliwht"]) == "fl"
p common_prefix(["dog", "racecar", "car"]) == ""
p common_prefix(["interspecies", "interstellar", "interstate"]) == "inters"
puts

# Given 2 strings, your job is to find out if there is a substring
# that appears in both strings.
# Substrings more than one letter long


# Input - Two strings
# Output - Bool

# Rules -
# => Case insensitive
# => 2 characters or more, meaning we can just check with two character substrings

# Algo
# Taking both string1 and string2,
# Iterate over string2, taking the current and next character up to the 2nd last character
# Compare these substrings with string1
# If a match is found, return true
# If we get to the end of the iteration, return false

def substring_test(str1, str2)
  0.upto(str2.length-2) do |index|
    return true if str1.downcase.include?(str2[index..index+1].downcase)
  end
  false
end

p substring_test('Something', 'Fun')  == false
p substring_test('Something', 'Home')  == true
p substring_test('BANANA', 'banana')  == true
p substring_test('1234567', '541265')  == true
puts

# Write function scramble that returns true if a portion of str1 characters can be
# rearanted to match str2, otherwise returns false

# Example:
#str1 is 'rkqodlw' and str2 is 'world' == true
# str1 is cedewaraaossoqqyt' and str2 is codewars should return true
# str1 is 'katas' and str2 is 'steak' should return false

# Only lower case letters will be used, no punctuation or digits will be included

# Rules -
# Str1 must include the same characters as str2 in any order
# Str1 must also have as many as str2 needs = i.e., enough j's or s's if there's multiple
# Str1 can have extra characters left over

# Algo
# Initialize a copy of str2, called results
# Iterate through the characters of str1, comparing against results string
# Every time a matching character is found, delete it
# At the end of iteration if results is equal to '', return true
# Else, return false

def scramble(str1, str2)
  results = str2.clone
  str1.chars.each do |char|
    results.sub!(char, "")
  end
  results == ""
end

p scramble('javaass', 'jjss') == false
p scramble('rkqodlw', 'world') == true
p scramble('katas', 'steak') == false
p scramble('scriptjava', 'javascript') == true
p scramble('scriptingjava', 'javascript') == true


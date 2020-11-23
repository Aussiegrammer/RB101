# Combine Two Lists
# Write a method that combines two Arrays passed in as arguments, and returns a new Array that contains all elements from both Array arguments, with the elements taken in alternation.
# interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

# Output - New Array
# Create a new, empty array and start a loop
# Start with an index of 0
# Within the loop, add the index 0 of each input array into the new array
# Increment index by 1, and repeat
# End loop once new array's length is equal to the combined lengths of the input arrays

def interleave(a1, a2)
  new_arr = []
  index = 0
  loop do
    new_arr << a1[index]
    new_arr << a2[index]
    index += 1
    break if new_arr.length == a1.length + a2.length
  end
  p new_arr
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

def interleave(a1, a2)
  a1.zip(a2).flatten
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

puts

# Lettercase Counter
# Write a method that takes a string, and then returns a hash that contains 3 entries:
# one represents the number of characters in the string that are lowercase letters,
# one the number of characters that are uppercase letters,
# and one the number of characters that are neither.

# Create the hash with the three keys mentioned with a value of 0
# Split the string out into individual characters as an array
# Iterate through the array, inspecting each character and incrementing the appropriate value by 1

LOWERCASE = ('a'..'z').to_a
UPPERCASE = ('A'..'Z').to_a

def letter_case_count(string)
  count = { lowercase: 0, uppercase: 0, neither: 0 }
  string.split("").each do |letter|
    if LOWERCASE.include?(letter)
      count[:lowercase] += 1
    elsif UPPERCASE.include?(letter)
      count[:uppercase] += 1
    else
      count[:neither] += 1
    end
  end
  count
end


p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

puts

# Capitalize Words
# Write a method that takes a single String argument and returns a new string that contains the original value of the argument with the first character of every word capitalized and all other letters lowercase.
# You may assume that words are any sequence of non-blank characters.

# Create a new blank array
# Split the string into an array of seperate words
# Reduce each word to lowercase letters, and capitalize the first
# Add this modified word to the array
# Join the array of words into a string

def word_cap(string)
  new_string = []
  string.split(" ").each do |word|
    new_string << word.capitalize
  end
  new_string.join(" ")
end

# This is possible with #map


def word_cap(words)
  words_array = words.split.map do |word|
    word.capitalize
  end
  words_array.join(' ')
end

# Sugar:

def word_cap(words)
  words.split.map(&:capitalize).join(' ')
end

# No capitalize method 1:

def word_cap(words)
  words_array = words.split.map do |word|
    word.downcase
    word[0] = word[0].upcase
    word
  end
  p words_array.join(' ')
end

def word_cap(words)
  words_array = words.split.map do |word|
    new_word = ""
    word.chars.each_with_index do |letter, index|
      if index == 0
        new_word << letter.upcase
      else
        new_word << letter.downcase
      end
    end
    new_word
  end
  p words_array.join(' ')
end


p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

puts

# Swap Case
# Write a method that takes a string as an argument and returns a new string in which every uppercase
# letter is replaced by its lowercase version, and every lowercase letter by its uppercase version. All other characters should be unchanged.

# Input / Output Str

# Create a constant array consisting of uppercase and lowercase letters
# Create a new blank array
# Create an array of the characters within the string
# Iterate through the array and identify if the character is an uppercase or lowercase alphanumeric letter
# Invert them if so, and insert it into the blank array
# Otherwise, insert the character
# Join the new array and return it

# LOWERCASE = ('a'..'z').to_a
# UPPERCASE = ('A'..'Z').to_a

def swapcase(string)
  new_string = string.chars.map do |letter|
    if LOWERCASE.include?(letter)
      letter.upcase
    elsif UPPERCASE.include?(letter)
      letter.downcase
    else
      letter
    end
  end
  new_string.join("")
end

p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

puts

# Staggered Caps (Part 1)

# Write a method that takes a String as an argument, and returns a new String that contains the original value using a staggered capitalization scheme
# in which every other character is capitalized, and the remaining characters are lowercase.
# Characters that are not letters should not be changed, but count as characters when switching between upper and lowercase.

# Break the string down into an array of characters
# Create an index starting at 0
# Iterate through the array, incrementing index by 1 every iteration
# If index is even, return an uppercase letter
# If index is odd, return a lowercase letter
# Use regex!

def staggered_case(string)
  i = 0
  new_string = string.chars.map do |letter|
    if i.even?
      letter.upcase!
    elsif i.odd?
      letter.downcase!
    end
    i += 1
    letter
  end
  new_string.join("")
end

# LS Solution. !need_upper inverts false or true. They also use += to add to the string.

def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper
  end
  result
end

p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

puts

# Modify the method from the previous exercise so it ignores non-alphabetic characters when determining whether
# it should uppercase or lowercase each letter. The non-alphabetic characters should still be included in the return value; they just don't count when toggling the desired case.


def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if char =~ /[^A-Za-z]/
      result += char
    elsif need_upper
      result += char.upcase
      need_upper = !need_upper
    else
      result += char.downcase
      need_upper = !need_upper
    end
  end
  result
end

# LS Alt. Similar. Double if statement. /i ignores case

def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if char =~ /[a-z]/i
      if need_upper
        result += char.upcase
      else
        result += char.downcase
      end
      need_upper = !need_upper
    else
      result += char
    end
  end
  result
end

p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'

puts

# Multiplicative Average

# Write a method that takes an Array of integers as input, multiplies all the numbers together,
# divides the result by the number of entries in the Array, and then prints the result rounded to 3 decimal places. Assume the array is non-empty.

def show_multiplicative_average(array)
  result = 1
  array.each do |int|
    result *= int
  end
  result /= array.length.to_f
  puts "The Result is #{format('%.3f', result)}"
end

show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667

puts

# Multiply Lists

# Write a method that takes two Array arguments in which each Array contains a list of numbers,
# and returns a new Array that contains the product of each pair of numbers from the arguments that have the same index. You may assume that the arguments contain the same number of elements.

def multiply_list(arr1, arr2)
  i = -1
  arr1.map do |int|
    i += 1
    int * arr2[i]
  end
end

# Further Exploration, 1 line attempt with #zip

def multiply_list(arr1, arr2)
  arr1.zip(arr2).map { |arr| arr.reduce(:*) }
end

p multiply_list([3, 5, 7], [9, 10, 11]) # == [27, 50, 77]

puts

# Multiply All Pairs

# Write a method that takes two Array arguments in which each Array contains a list of numbers,
# and returns a new Array that contains the product of every pair of numbers that can be formed between the elements of the two Arrays. The results should be sorted by increasing value.

def multiply_all_pairs(arr1, arr2)
  arr1.product(arr2).map { |sub_arr| sub_arr[0] * sub_arr[1] }.sort
end

# Below also works

def multiply_all_pairs(array_1, array_2)
  array_1.product(array_2).map { |num1, num2| num1 * num2 }.sort
end

p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

puts

# The End Is Near But Not Here
# Write a method that returns the next to last word in the String passed to it as an argument.

def penultimate(string)
  string.split(" ")[-2]
end

p penultimate('last word') == 'last'
p penultimate('Launch School is great!') == 'is'
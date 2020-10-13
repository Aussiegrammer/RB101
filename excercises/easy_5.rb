#Write a method that determines and returns the ASCII string value of a string that is passed in as an argument.
#The ASCII string value is the sum of the ASCII values of every character in the string. (You may use String#ord to determine the ASCII value of a character.)

# PEDAC
# Input - String
# Output - integer

# Convert each individual ASCII character in a string to an Integer
# Add those integers up as a sum

# Implicit: If string is empty, 0.

# Algo
# Start with an empty result
# Convert first character in string to a number
# Add that number to result
# Repeat with all future characters
# Return the final sum

def ascii_value(string)
  result = 0
  string.chars.each do |character|
    result += character.ord
  end
  result
end

ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0

puts 

# The time of day can be represented as the number of minutes before or after midnight. 
# If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight.
# Write a method that takes a time using this minute-based format and returns the time of day in 24 hour format (hh:mm). Your method should work with any integer input.

# PEDAC
# Problem
# => Explicit: 
# =>  - Input: integer
# =>  - Output: String
# =>  - Rules: Cannot use Time or Date methods
# =>  - Positive int: Time after midnight in minutes
# =>  - Negative int: Time before midnight in minutes
# =>  - Output is in 24 hour format, hh:mm
# =>  - Disregard Daylight Savings and Standard Time and other complications. (Mercy!)
# => Implicit:
# =>  - After 1440 minutes, loop over to the next day (i.e. 1441 == 00:01)
# =>  - Hours and minutes are in "00:00", will need to add the extra 0's when needed.

# Examples

# time_of_day(0) == "00:00"
# time_of_day(-3) == "23:57"
# time_of_day(35) == "00:35"
# time_of_day(-1437) == "00:03"
# time_of_day(3000) == "02:00"
# time_of_day(800) == "13:20"
# time_of_day(-4231) == "01:29"

# Data Structures

# Start with a whole integer
# 1440 = One day
# Get seperate hours and minutes integers
# Output these to a final result string
# Return (or print) that string.

# Algorithm

# Take whole integer input
# Divide the whole integer by 60 to get hours
#   - If hours > 24, -24 to the hours to subtract a 'day'
#     - Repeat this until hours <= 24
# Modulo the whole integer by 60 to get the remaining minutes
# Determine if initial integer is positive or negative
#   - If negative, 'invert' the hours and minutes operations above
#     - For minutes, do 60 - minutes >>>> % modulo does this automatically for -integers!
#     - For hours, do 24 - hours >>> Ended up using + hours because negative number / 60 results in a negative
#       - Edge case: If hours == 0 and integer is negative, do not add 24. 
#   - If positive, proceed normally
# If hours or minutes are only 1 digit, add an extra digit.
# Concatenate final string result - "hours:minutes"

def get_hours(integer)
  hours = integer / 60
    loop do 
      if hours >= 24
        hours -= 24
      elsif hours <= -24 
        hours += 24
      else
        break
      end
    end
  hours
end

def get_minutes(integer)
  integer % 60
end

def convert_to_hhmm(hours, minutes)
  if hours.digits.length == 1
    hours = "0#{hours}"
  end
  if minutes.digits.length == 1
    minutes = "0#{minutes}"
  end
  "#{hours}:#{minutes}"
end

def time_of_day(integer)
  hours = get_hours(integer)
  minutes = get_minutes(integer)
  if integer < 0 && hours != 0
   hours = 24 + hours
  end
  convert_to_hhmm(hours, minutes)
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"

# Launch School Solution:

MINUTES_PER_HOUR = 60 # Use Static number variables to give more readability to random numbers throughout the code
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def time_of_day(delta_minutes)
  delta_minutes =  delta_minutes % MINUTES_PER_DAY # Integer / 1440 returns only one day's worth of ninutes
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR) # https://docs.ruby-lang.org/en/master/Numeric.html#method-i-divmod. Returns an array with n / x, and n % x >> [a, b]
  format('%02d:%02d', hours, minutes) # String#format. %02d = always 2 digits, hours, minutes. This adds the extra 0
end

p time_of_day(1000)

puts

# Given a string of words separated by spaces, write a method that takes this string of words and
# returns a string in which the first and last letters of every word are swapped.

def swap(string)
  swapped_string = ""
  string.split(" ").each do | word |
    current_word = word.chars
    first_char = current_word.first
    current_word[0] = current_word.last
    current_word[-1] = first_char
    swapped_string << current_word.join + " "
  end
  swapped_string.rstrip
end

p swap('Oh what a wonderful day it is')
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'

# LS Solution:

# def swap_first_last_characters(word)
#   word[0], word[-1] = word[-1], word[0] # a, b = b, a
#   word
# end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

# Test:

def swap_first_last_characters(a, b)
  a, b = b, a
end

puts

p swap_first_last_characters('a', 'b')

puts

# Write a method that takes a string with one or more space separated words and returns a hash that shows the number of words of different sizes.

# Seperate each word into an array by spaces
# Create an empty hash
# For each word, count the amount of characters into a counter
# If the counter doesn't exist in the hash as a key, create the key with the value of 1
# If the counter does exist in the hash as a key, increment the value by 1

def word_sizes(string)
  size_hash = {}
  string.split(" ").each do |word|
    count = word.size
    if size_hash.has_key?(count)
      size_hash[count] += 1
    else
      size_hash[count] = 1
    end
  end
  size_hash
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}


# LS Way: 

def word_sizes(words_string)
  counts = Hash.new(0) # Default value of non existing keys is now 0, allowing you to += 1
  words_string.split.each do |word|
    counts[word.size] += 1
  end
  counts
end

puts

# Given a string that consists of some words (all lowercased) and an assortment of non-alphabetic characters,
# write a method that returns that string with all of the non-alphabetic characters replaced by spaces. 
# If one or more non-alphabetic characters occur in a row, you should only have one space in the result (the result should never have consecutive spaces).

ALPHABET = ("a".."z").to_a

def cleanup(string)
  cleaned_string = []
  
  string.each_char do |character|
    if ALPHABET.include?(character)
      cleaned_string << character
    else
      cleaned_string << " " unless cleaned_string.last == " "
    end
  end
  cleaned_string.join
end

p cleanup("---what's my +*& line?")
p cleanup("---what's my +*& line?") == ' what s my line '

# Regexp

def cleanup(text)
  text.gsub(/[^a-z]/i, ' ').squeeze(' ') # Squeeze removes the duplicate spaces, the regexp turns anything that isn't a-z to a space
end


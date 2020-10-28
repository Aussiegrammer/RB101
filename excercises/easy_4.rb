# Write a method that takes two strings as arguments, determines the longest of the two strings,
# and then returns the result of concatenating the shorter string, the longer string, and the shorter string once again.

def short_long_short(str1, str2)
  if str1.length > str2.length
    "#{str2 + str1 + str2}"
  else
    "#{str1 + str2 + str1}"
  end
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"
puts

# Write a method that takes a year as input and returns the century.
# The return value should be a string that begins with the century number, and ends with st, nd, rd, or th as appropriate for that number.

# The below works, but I used LS's example. The logic is understood, but do better!

def century(year)
  century = year / 100 + 1
  century -= 1 if year % 100 == 0
  century.to_s + century_suffix(century)
end

def century_suffix(century)
  return 'th' if [11, 12, 13].include?(century % 100)
  last_digit = century % 10

  case last_digit
  when 1 then 'st'
  when 2 then 'nd'
  when 3 then 'rd'
  else 'th'
  end
end

p century(2000)
p century(2001)
p century(1052)

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'
puts


# In the modern era under the Gregorian Calendar,
# leap years occur in every year that is evenly divisible by 4,
# unless the year is also divisible by 100. If the year is evenly divisible by 100,
# then it is not a leap year unless the year is evenly divisible by 400.

def leap_year?(year)
  if year % 100 == 0 && year % 400 == 0
    true
  elsif year % 4 == 0 && year % 100 != 0
    true
  else
    false
  end
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == false
p leap_year?(1) == false
p leap_year?(100) == false
p leap_year?(400) == true

puts

# The British Empire adopted the Gregorian Calendar in 1752, which was a leap year.
# Prior to 1752, the Julian Calendar was used. Under the Julian Calendar, leap years occur in any year that is evenly divisible by 4.

def leap_year?(year)
  if year <= 1752 && year % 4 == 0
    true
  elsif year % 100 == 0 && year % 400 == 0
    true
  elsif year % 4 == 0 && year % 100 != 0
    true
  else
    false
  end
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == true
p leap_year?(1) == false
p leap_year?(100) == true
p leap_year?(400) == true

puts

# Write a method that searches for all multiples of 3 or 5 that lie between
# 1 and some other number, and then computes the sum of those multiples.
# For instance, if the supplied number is 20, the result should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).

def multisum(number)
  sum = 0
  (1..number).each do |n|
    sum += n if n % 3 == 0 || n % 5 == 0
  end
  sum
end

def multisum(number)
  numbers = []
  (1..number).each { |n| numbers << n }
  numbers.inject { |sum, n| n % 3 == 0 || n % 5 == 0 ? sum + n : sum } - 1
end

p (3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168
puts

# Write a method that takes an Array of numbers, and returns an Array with the same number of elements, and each element has the running total from the original Array.
def running_total(numbers)
  new_numbers = []
  total = 0
  numbers.each do |number|
    total += number
    new_numbers << total
  end
  new_numbers
end

# A neat array using map

def running_total(array)
  sum = 0
  array.map { |value| sum += value }
end

p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []
puts

# Write a method that takes a String of digits, and returns the appropriate number as an integer. You may not use any of the methods mentioned above.

DIGITS = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5,
           '6' => 6, '7' => 7, '8' => 8, '9' => 9, '0' => 0 }

def string_to_integer(number)
  numbers_as_integer = []
  number.split.each do |digit|
    numbers_as_integer << DIGITS[digit]
  end
  numbers_as_integer.join
end

# Alternative using base 10 instead of insertion

def string_to_integer(string)
  digits = string.chars.map { |char| DIGITS[char] }

  value = 0
  digits.each { |digit| value = 10 * value + digit }
  value
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570
puts

# A method that takes a String of digits, and returns the appropriate number as an integer. The String may have a leading + or - sign;
# if the first character is a +, your method should return a positive number; if it is a -, your method should return a negative number. If no sign is given, you should return a positive number.

def string_to_signed_integer(string)
  case string[0]
  when '-' then -string_to_integer(string[1..-1])
  when '+' then string_to_integer(string[1..-1])
  else          string_to_integer(string)
  end
end

p string_to_signed_integer('+4321') == 4321
p string_to_signed_integer('-570') == -570
puts
# Write a method that takes a positive integer or zero, and converts it to a string representation.

DIGITS_AS_STRING = { 1 => '1', 2 => '2', 3 => '3', 4 => '4', 5 => '5',
                     6 => '6', 7 => '7', 8 => '8', 9 => '9', 0 => '0' }

def integer_to_string(number)
  string = []
  number.digits.each do |digit|
    string << DIGITS_AS_STRING[digit]
  end
  string.reverse.join
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'
puts

#LS Alternative

DIGITS_AS_ARRAY = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def integer_to_string(number)
  result = ''
  loop do
    number, remainder = number.divmod(10)
    result.prepend(DIGITS_AS_ARRAY[remainder])
    break if number == 0
  end
  result
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'
puts

# In this exercise, you're going to extend that method by adding the ability to represent negative numbers as well.

def signed_integer_to_string(integer)
  string = ''
  case
  when integer > 0 then string = '+' + integer_to_string(integer)
  when integer < 0 then string = '-' + integer_to_string(integer * -1)
  else string = '0'
  end
  string
end


p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'

#Alt


def signed_integer_to_string(number)
  case number <=> 0 # Space ship comparison operator
  when -1 then "-#{integer_to_string(-number)}" #--number = +number
  when +1 then "+#{integer_to_string(number)}"
  else         integer_to_string(number)
  end
end


# Refactored into one line

def signed_integer_to_string(number)
  string = integer_to_string(number.abs)
  case number <=> 0
  when +1 then '+' + string
  when -1 then '-' + string
  else string end
end
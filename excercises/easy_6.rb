# Write a method that takes a floating point number that represents an angle between 0 and 360 degrees and returns a String that represents that angle in degrees, minutes and seconds.
DEGREE = "\xC2\xB0"

def dms(float)
  degrees = float.to_i % 360
  minutes = ((float % 360 - degrees) * 60).ceil(2)
  seconds = ((minutes - minutes.to_i) * 60).to_i
  format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)
end

p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360)  == %(360°00'00") || dms(360) == %(0°00'00")
p dms(400)  == %(40°00'00")
p dms(-40)  == %(320°00'00")
p dms(-420)  == %(300°00'00")
puts

# Write a method that takes an array of strings, and returns an array of the same string values, except with the vowels (a, e, i, o, u) removed.
VOWELS = "aeoiuAEIOU"
def remove_vowels(array)
  array.map do |string|
    string.delete(VOWELS)
  end
end

p remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
p remove_vowels(%w(green YELLOW black white))  == %w(grn YLLW blck wht)
p remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']
puts

# Write a method that calculates and returns the index of the first Fibonacci number that has the number of digits specified as an argument. (The first Fibonacci number has index 1.)

def find_fibonacci_index_by_length(digits)
  index = 1
  sequence_number = 0
  current_number = 1
  previous_number = 0
  until sequence_number.digits.length == digits
    index += 1
    sequence_number = current_number + previous_number
    previous_number = current_number
    current_number = sequence_number
  end
  index
end


#LS Alt:

def find_fibonacci_index_by_length(number_digits)
  first = 1
  second = 1
  index = 2 # Starting with 1 + 1 so start at index 2

  loop do
    index += 1
    fibonacci = first + second
    break if fibonacci.to_s.size >= number_digits

    first = second
    second = fibonacci
  end

  index
end

p find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
p find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
# p find_fibonacci_index_by_length(1000) == 4782
# p find_fibonacci_index_by_length(10000) == 47847
puts

# Write a method that takes an Array as an argument, and reverses its elements in place; that is, mutate the Array passed into this method. The return value should be the same Array object.

def reverse!(array)
  index = 0
  inverted_index = -1
  (array.length / 2).times do
    temp_object = array[index]
    array[index] = array[inverted_index]
    array[inverted_index] =  temp_object
    index += 1
    inverted_index -= 1
  end
  array
end

# LS Alternative. Note Line 101, you can assign multiple array items in a single line, eliminating the need for temp_object
# The rest is similar

def reverse!(array)
  left_index = 0
  right_index = -1

  while left_index < array.size / 2
    array[left_index], array[right_index] = array[right_index], array[left_index]
    left_index += 1
    right_index -= 1
  end

  array
end

list = %w(a b e d c)
p reverse!(list) == ["c", "d", "e", "b", "a"]
p list == ["c", "d", "e", "b", "a"]

list = [1,2,3,4]
result = reverse!(list)
p result == [4, 3, 2, 1]
p list == [4, 3, 2, 1]
p list.object_id == result.object_id

puts

# Write a method that takes an Array, and returns a new Array with the elements of the original list in reverse order. Do not modify the original list.

def reverse(array)
  reversed_array = []
  right_index = -1
  (array.size).times do
    reversed_array << array[right_index]
    right_index -= 1
  end
  reversed_array
end

def reverse(array)
  array.each_with_object([]) { |item, array| array.insert(0, item) }
end

p reverse([1,2,3,4]) == [4,3,2,1]          # => true
p reverse(%w(a b e d c)) == %w(c d e b a)  # => true
p reverse(['abc']) == ['abc']              # => true
p reverse([]) == []                        # => true

p list = [1, 3, 2]                      # => [1, 3, 2]
p new_list = reverse(list)              # => [2, 3, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 3, 2]                     # => true
p new_list == [2, 3, 1]                 # => true
puts

# Write a method that takes two Arrays as arguments,
# and returns an Array that contains all of the values from the argument Arrays.
# There should be no duplication of values in the returned Array, even if there are duplicates in the original Arrays.

def merge(a1, a2)
  merged_array = a1 + a2
  merged_array.uniq
end

# LS Alt, does it all in one method using Array#|

def merge(array_1, array_2)
  array_1 | array_2
end


p merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
puts

# Write a method that takes an Array as an argument, and returns two Arrays (as a pair of nested Arrays)
# that contain the first half and second half of the original Array, respectively.
# If the original array contains an odd number of elements, the middle element should be placed in the first half Array.

# Couldnt get this to work as on an even array it would add one more to the left side

def halvsies(array)
  new_array = [[], []]
  index = 0
  loop do
    break if index == array.length
    if index <= array.length / 2
      new_array[0] << array[index]
      index += 1
    else
      new_array[1] << array[index]
      index +=1
    end
  end
  new_array
end

# LS Solution:

def halvsies(array)
  middle = (array.size / 2.0).ceil # Float is used for odd numbers to get .5 which is rounded up with ceil.
  first_half = array.slice(0, middle)
  second_half = array.slice(middle, array.size - middle)
  [first_half, second_half]
end

p halvsies([1, 2, 3, 4]) # [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) # == [[1, 5, 2], [4, 3]]
p halvsies([5]) # == [[5], []]
p halvsies([]) # == [[], []]
puts

# Given an unordered array and the information that exactly one value in the array occurs twice (every other value occurs exactly once),
# how would you determine which value occurs twice? Write a method that will find and return the duplicate value that is known to be in the array.

def find_dup(array)
  array.each do |num|
    return num if array.count(num) == 2
  end
end

# LS Alternative uses Enumerable#find, which probably works a little better than iterating through every number individually

def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end

p find_dup([1, 5, 3, 1]) == 1
p find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73
puts

# Write a method named include? that takes an Array and a search value as arguments.
# This method should return true if the search value is in the array, false if it is not.
# You may not use the Array#include? method in your solution.
def include?(array, search)
  if array.count(search) > 0
    true
  else
    false
  end
end

p include?([1,2,3,4,5], 3) == true
p include?([1,2,3,4,5], 6) == false
p include?([], 3) == false
p include?([nil], nil) == true
p include?([], nil) == false
puts

# Write a method that takes a positive integer, n, as an argument, and displays a right triangle whose sides each have n stars.
# The hypotenuse of the triangle (the diagonal side in the images below) should have one end at the lower-left of the triangle, and the other end at the upper-right.


def triangle(size)
  space = size - 1
  stars = 1
  loop do
    puts "#{' ' * space}#{'*' * stars}"
    break if stars == size
    space -= 1
    stars += 1
  end
end

triangle(5)
triangle(9)
puts

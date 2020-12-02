# This limits the words you can spell with the blocks to just those words that do not use both letters from any given block. Each block can only be used once.

# Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, false otherwise.

# Input - String
# Output - Bool
# Rules - Can only use each letter 'block' once
#       - Not case sensitive
# Create an array called 'blocks' containing an entry for each block with letters
# Break the original string down into letters the same letter case as the block
# Iterate through each letter, comparing it against the blocks array to see if it is included
# -- Return false if it doesn't
# -- If true:
# Find the matching letter block. Remove it.
# Check the next letter, until done
# Return true after final iteration is true

BLOCKS = %w(B:O X:K D:Q C:P N:A
            G:T R:E F:S J:W H:U
            V:I L:Y Z:M)

def block_word?(string)
  current_blocks = BLOCKS.clone
  characters = string.upcase.chars
  matches_found = 0
  characters.each do |char|
    current_blocks.each_with_index do |block, index|
      if block.include?(char)
        current_blocks.delete_at(index)
        matches_found += 1
      end
    end
  end
  matches_found == string.length
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true
puts
# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the percentage
# of characters in the string that are lowercase letters, one the percentage of characters that are uppercase letters, and one the percentage of characters that are neither.

def letter_percentages(string)
  count_hash = { lowercase: string.count("a-z"),
                 uppercase: string.count("A-Z"),
                 neither: string.count("\^a-zA-Z") }
  total = count_hash.each_value.sum
  count_hash.map { |_, value| (value.fdiv(total)) * 100 }
end

p letter_percentages('abCdef 123') # == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef') # == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') # == { lowercase: 0, uppercase: 0, neither: 100 }
puts


# Write a method that takes a string as argument,
# and returns true if all parentheses in the string are properly balanced, false otherwise. To be properly balanced, parentheses must occur in matching '(' and ')' pairs.

=begin
Input: String
Output: Bool
Rules:
- Parenthesis must be in pairs, starting with ( and ending in )
- If there is no ) after a (, return false.
- If there is a ) with no preceding (, return false.

Algo:
- Break the string down into an array of characters
- Iterate through the characters array, counting parenthesis
  - Start at 0
  - +1 for (
  - -1 for )
    - If you EVER get to -1, return false
    - If it completes the iteration and the result isn't 0, return false
    - If the final result is 0, return true
=end


def balanced?(string)
  characters = string.chars
  i = 0
  characters.each do |char|
    if i <= -1
      return false
    elsif char == "("
      i += 1
    elsif char == ")"
      i -= 1
    end
  end
  i == 0
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
puts

# Write a method that takes the lengths of the 3 sides of a triangle as arguments,
# and returns a symbol :equilateral, :isosceles, :scalene, or :invalid depending on whether the triangle is equilateral, isosceles, scalene, or invalid.

def invalid?(sides)
  return true if sides.include?(0)
  return true if sides[0] + sides[1] < sides[2]
end

def equal?(sides)
  sides[0] == sides[1] && sides[0] == sides[2]
end

def scalene?(sides)
  sides[0] != sides[1] &&
  sides[0] != sides[2] &&
  sides[1] != sides[2]
end

def isosceles?(sides)
  sides[0] == sides[1] ||
  sides[0] == sides[2] ||
  sides[1] == sides[2]
end

def triangle(side1, side2, side3)
  sides_arr = side1, side2, side3
  sorted_sides = sides_arr.sort
  case
  when invalid?(sorted_sides) then :invalid
  when equal?(sorted_sides) then :equilateral
  when scalene?(sorted_sides) then :scalene
  when isosceles?(sorted_sides) then :isosceles
  end
end


p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid
puts

# LS Shorter method, all logic in one method - lame!
# Note the use of #reduce +

def triangle(side1, side2, side3)
  sides = [side1, side2, side3]
  largest_side = sides.max

  case
  when 2 * largest_side > sides.reduce(:+), sides.include?(0)
    :invalid
  when side1 == side2 && side2 == side3
    :equilateral
  when side1 == side2 || side1 == side3 || side2 == side3
    :isosceles
  else
    :scalene
  end
end

# Write a method that takes the 3 angles of a triangle as arguments,
# and returns a symbol :right, :acute, :obtuse, or :invalid depending on whether the triangle is a right, acute, obtuse, or invalid triangle.

def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3]

  case
  when angles.sum != 180 || angle1 <= 0 || angle2 <= 0 || angle3 <= 0
    :invalid
  when angle1 == 90 || angle2 == 90 || angle3 == 90
    :right
  when angle1 < 90 && angle2 < 90 && angle3 < 90
    :acute
  when angle1 > 90 || angle2 > 90 && angle3 > 90
    :obtuse
  end
end


# Little bit cleaner / smarter code from LS:

def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3]

  case
  when angles.reduce(:+) != 180, angles.include?(0)
    :invalid
  when angles.include?(90)
    :right
  when angles.all? { |angle| angle < 90 }
    :acute
  else
    :obtuse
  end
end


p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid
puts


require 'date'

def friday_13th(year)
  unlucky_count = 0
  thirteenth = Date.civil(year, 1, 13)
  12.times do
    unlucky_count += 1 if thirteenth.friday?
    thirteenth = thirteenth.next_month
  end
  unlucky_count
end


# A featured number (something unique to this exercise) is an odd number that is a multiple of 7,
# and whose digits occur exactly once each. So, for example, 49 is a featured number,
# but 98 is not (it is not odd), 97 is not (it is not a multiple of 7), and 133 is not (the digit 3 appears twice).

def uniq_digits?(num)
  num.digits.reverse.join == num.digits.reverse.uniq.join
end

def featured(num)
  featured = 7
  loop do
    return featured if featured.odd? && featured % 7 == 0 && featured > num && uniq_digits?(featured)
    featured += 7
    break if featured >= 9_876_543_210

  end
  "There is no possible number that fulfills those requirements."
end

p featured(1)
p featured(12) # == 21
p featured(20) # == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
# p featured(999_999) == 1_023_547
# p featured(999_999_987) == 1_023_456_987
puts

# Write a method that takes an Array as an argument, and sorts that Array using the bubble sort algorithm as just described.
# Note that your sort will be "in-place"; that is, you will mutate the Array passed as an argument. You may assume that the Array contains at least 2 elements.

def bubble_sort!(array)
  loop do
  swapped = false
    array.each_with_index do |item, index|
      next if index == 0
      if array[index-1] > array[index]
        array[index-1], array[index] = array[index], array[index-1]
        swapped = true
      end
    end
  break if swapped == false
  end
end


array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

puts

# Write a method that computes the difference between the square of the sum of the first n positive integers and the sum of the squares of the first n positive integers.

def sum_square_difference(n)
  upto_sum = (1..n).reduce(:+)
  upto_squaresum = 0
  n.times { |num| upto_squaresum += (num+1) ** 2 }
  # upto_sum ** 2 - upto_squaresum
  upto_sum ** 2 - upto_squaresum
end

p sum_square_difference(3) == 22 # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150
puts

# Write a program that reads the content of a text file and then prints the longest sentence in the file based on number of words.
# Sentences may end with periods (.), exclamation points (!), or question marks (?).

text = File.read('sample2.txt')
sentences = text.split(/\.|\?|!/)
largest_sentence = sentences.max_by { |sentence| sentence.split(" ").length }
p largest_sentence.split(" ").length


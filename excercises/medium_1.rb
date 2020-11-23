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
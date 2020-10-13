# What is the return value of the select method below? Why?
  # => [1, 2, 3], because 'hi' is truthy
[1, 2, 3].select do |num| 
  num > 5
  'hi'
end

# How does count treat the block's return value? How can we find out?
  # => Using Enumerable#count, it counts the truthy objects in the block and returns an integer
  # => The following is '1'
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# What is the return value of reject in the following code? Why?
  # => Reject creates an array for each block that returns false
  # => Because puts always returns nil, the return value is [1, 2, 3]
[1, 2, 3].reject do |num|
  puts num
end

# What is the return value of each_with_object in the following code? Why?
  # => Should return {'ant' => 'ant', 'bear' => 'bear', 'cat' => 'cat'}
  # => each_with_object is creating a hash with the key:value pair of value => value.
  # => ^^^^^ Incorrect, but close.
  # => it's {'a' => 'ant', ... ...} because value[0] is the first letter of the string 'ant'

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash| # => { "a" => "ant", "b" => "bear", "c" => "cat" }
  hash[value[0]] = value
end

# What does shift do in the following code? How can we find out?
  # => Found under Hash#shift, shift returns and removes the first entry.
  # => Return: [:a, 'ant'], final hash value: { :b => 'bear' }
hash = { a: 'ant', b: 'bear' }
hash.shift

# What is the return value of the following statement? Why?
  # => Return value => 11
  # => .pop method removes the last item (destructively), and returns it
  # => The amount of elements in the STRING 'caterpillar' that is returned, is 11
['ant', 'bear', 'caterpillar'].pop.size

# What is the block's return value in the following code? How is it determined? 
# Also, what is the return value of any? in this code and what does it output?
  # => True because 'any' of the objects return true in the block for num.odd?
  # => num.odd? is after puts num, which returns nil, but the block returns the last element.
[1, 2, 3].any? do |num|
  puts num  # => NOTE: Array#any? stops iterating after the first truthy statement it finds, so it only puts '1'.
  num.odd?
end

# How does take work? Is it destructive? How can we find out?
  # => Take returns n amount of elements from the first. It is non-destructive, and returns a new array.
  # => Found under Array#take documentation.
arr = [1, 2, 3, 4, 5]
arr.take(2) # => [1, 2]

# What is the return value of map in the following code? Why?
  # => Enumerable#map returns an ARRAY of the RETURN VALUES in the block
  # => Therefor, the return value = [nil, 'bear']
  # => NOTE: If statements return nil if there are no true statements
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# What is the return value of the following code? Why?
  # => Enumerable#map returns an ARRAY of the RETURN VALUES in the block
  # => #puts RETURN VALUE is nil
  # => Return value should be [1, nil, nil] (It will puts 2 and 3, though.)
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end
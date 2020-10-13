# Practice Problem 1
# How would you order this array of number strings by descending numeric value?
arr = ['10', '11', '9', '7', '8']

p arr.sort { |a, b| b.to_i <=> a.to_i }
puts 

# Practice Problem 2
# How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

p books.sort_by do |book|
  book[:published]
end
puts 

# Practice Problem 3
# For each of these collection objects demonstrate how you would reference the letter 'g'.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
p arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
p arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
p arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
p hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
p hsh2[:third].key(0)

# Practice Problem 4
# For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.

arr1 = [1, [2, 3], 4]
arr1[1][1] += 1 
p arr1

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] += 1 
p arr2

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] += 1
p hsh1 

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
p hsh2[['a']][:a][2] += 1 
p hsh2 
puts

# Practice Problem 5
# Given this nested Hash: figure out the total age of just the male members of the family.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

total_age = 0
munsters.each do |munster|
  if munster[1]['gender'] == "male"
    total_age += munster[1]['age']
  end
end

p total_age
# LS alternative, each.value selects the values of Herman, Lily etc. Also compressed into one line, as there is only one if
total_age = 0
munsters.each_value do |munster|
  total_age += munster['age'] if munster['gender'] == "male"
end

puts total_age

# Practice Problem 6
# Given this previously seen family hash, print out the name, age and gender of each family member:
# (Name) is a (age)-year-old (male or female).

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, details|
  puts "#{name} is a #{details['age']} year old #{details['gender']}."
end

# Practice Problem 7
# Given this code, what would be the final values of a and b? Try to work this out without running the code.

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a
# Guess: a = 4, b = [1, 8]
# Result: a = 2, b = [3, 8]

p a
p b
p arr

# Practice Problem 8
# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiou'
hsh.each do |_, value|
  value.each do |word|
    word.chars do |character|
      puts character if vowels.include?(character)
    end
  end
end


# Practice Problem 9
# Given this data structure, return a new array of the same
# structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map! do |arrays|
  arrays.sort do |a, b|
    b <=> a
  end
end
p arr
puts 

# Practice Problem 10
# Given the following data structure and without modifying the original array, use
# the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr.map! do |hashes|
  incremented_hash = {}
  hashes.map do |k, v|
    incremented_hash[k] = v += 1
  end
  incremented_hash
end
p arr
puts 
# Practice Problem 11
# Given the following data structure use a combination of methods, including either the select or reject method,
# to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map! do |sub_arrays|
  sub_arrays.select do |digit|
    digit % 3 == 0
  end
end
p arr
puts

# Practice Problem 12
# Given the following data structure, and without using 
# Array#to_h method, write some code that will return a hash where the key is the first item in each sub array and the value is the second item.

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
new_hash = {}
arr.map! do |sub_arrays|
  new_hash[sub_arrays[0]] = sub_arrays[1]
end
p new_hash
puts

# Practice Problem 13
# Given the following data structure, return a new array containing the
# same sub-arrays as the original but ordered logically by only taking into consideration the odd numbers they contain.

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

arr.sort_by! do |array|
  array.select do |digit|
    digit.odd?
  end
end
p arr
puts 

# Practice Problem 14
# Given this data structure write some code to return an array containing 
# the colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.
# [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map do |color|
      color.capitalize
    end
  elsif value[:type] == 'vegetable'
    value[:size].upcase
  end
end

# Practice Problem 15
# Given this data structure write some code to return an array which contains only the hashes where all the integers are even.

arr2 = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr2.select! do |hashes|
  hashes.all? do |_, array|
    array.all? do |digit|
      digit.even?
    end
  end
end
p arr2

# Practice Problem 16
# Write a method that returns one UUID when called with no parameters.

HEX = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']


def eight_chars(string)
  8.times do 
    string << HEX[rand(15)]
  end
  string
end

def four_chars(string)
  4.times do 
    string << HEX[rand(15)]
  end
  string
end

def twelve_chars(string)
  4.times do 
    string << HEX[rand(15)]
  end
  string
end

def uuid
  string = ''
  string << eight_chars(string)
  string << '-'
  3.times do 
    string << four_chars(string)
    string << '-'
  string << twelve_chars(string)
  string
  end
end

p uuid
# Practice Problem 1
# Turn this array into a hash where the names are the keys and the values are the positions in the array.
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = flintstones.each_with_object({}) do |n, hash|
  hash[n] = flintstones.index(n)
end
p flintstones_hash # => {"Fred"=>0, "Barney"=>1, "Wilma"=>2, "Betty"=>3, "Pebbles"=>4, "BamBam"=>5}

# LS Alternative uses Enumerable#each_with_index, and initializes an empty hash
# Typing manually: 

flintstones_hash = {}

flintstones.each_with_index do |value, index|
  flintstones_hash[value] = index
end

p flintstones_hash # => {"Fred"=>0, "Barney"=>1, "Wilma"=>2, "Betty"=>3, "Pebbles"=>4, "BamBam"=>5}

# Practice Problem 2
# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
age_total = 0

ages.each_value do |value|
  age_total += value
end
p age_total # => 6174

# Inject method works great here. 
# Hash#values creates an array with all the ages
# Enumberable#inject adds them up

age_total = ages.values.inject(:+)
p age_total # => 6174

# Practice Problem 3
# In the age hash remove people with age 100 and greater.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.select! { |k, v| v < 100 }
p ages # => {"Herman"=>32, "Lily"=>30, "Eddie"=>10}

# Keep.if is another choice here. select! returns nil if there's no changes. 
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.keep_if { |k, v| v < 100 }
p ages # => {"Herman"=>32, "Lily"=>30, "Eddie"=>10}

# Practice Problem 4
# Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
p ages.key(ages.values.sort.first)

# Question only called for the minimum age, not who. 
# Below is better. 

p ages.values.min 

# Practice Problem 5
# In the array: Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# Below works, but it's not very good. 
index_found = nil
flintstones.each_with_index do |name, index|
  if name.start_with?('Be')
    index_found = index
    break
  end
end
p index_found

# LS Alternative. Uses Array#index, selecting the first two letters of each name strings / collections
p flintstones.index { |name| name[0, 2] == "Be" }

# Practice Problem 6
# Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.each do |name|
  name.slice!(3, name.length-3)
end
p flintstones

flintstones.map! do |name|
  name[0, 3]
end
p flintstones

# Practice Problem 7
# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

statement_letters = {} 
statement.split(//).each do |letter|
  if statement_letters.has_key?(letter)
    statement_letters[letter] = statement_letters[letter] + 1
  else
    statement_letters[letter] = 1
  end
end
p statement_letters # Edge case: This counts spaces as well. 

# LS Solution: 

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

# Practice Problem 8
# What happens when we modify an array while we are iterating over it? What would be output by this code?
  # => Output should be: => 1 3
  # => You can modify an array as you iterate through it. In this case,
  # => index 0 is 1, the array is shifted, then index 1 is 3, the array is shifted, index 2 doesn't exist.
  
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# What would be output by this code?
  # => 1 2
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# In both cases we see that iterators DO NOT work on a copy of the original array or from stale meta-data 
# (length) about the array. They operate on the original array in real time.

# Practice Problem 9
# Titleize method

def titleize(string)
  title_string = string.split(" ").map { |word| word.capitalize }
  title_string.join(" ")
end

words = "the flintstones rock"
puts titleize(words)

# Practice Problem 10
# Given the munsters hash below
# Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values 
# describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below
# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily"=> { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

expected_output = { 
  "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
  
munsters.each do |k, v|
  case 
  when munsters[k]["age"] <= 17
    munsters[k]["age_group"] = "kid"
  when munsters[k]["age"] >= 18 && munsters[k]["age"] <= 64
    munsters[k]["age_group"] = "adult"
  when munsters[k]["age"] >= 65 
    munsters[k]["age_group"] = "senior"
  end
end

p munsters == expected_output # => true!

# Cleanup by LS: 

munsters.each do |k, v|
  case v["age"]
  when 0..18
    v["age_group"] = "kid"
  when 18..64
    v["age_group"] = "adult"
  else
    munsters[k]["age_group"] = "senior"
  end
end

p munsters == expected_output # => true

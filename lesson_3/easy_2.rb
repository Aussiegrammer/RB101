# Question 1
# In this hash of people and their age,
# see if "Spot" is present.
# Bonus: What are two other hash methods that would work just as well for this solution?

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.key?("Spot")

# Question 2
munsters_description = "The Munsters are creepy in a good way."

p munsters_description.swapcase
p munsters_description.capitalize
p munsters_description.downcase
p munsters_description.upcase

# Question 3
# We have most of the Munster family in our age hash:
# add ages for Marilyn and Spot to the existing hash

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
p ages.merge!(additional_ages)

# Question 4
# See if the name "Dino" appears in the string below:

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.match?('Dino')

# Question 5
# Show an easier way to write this array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Question 6
# How can we add the family pet "Dino" to our usual array:

flintstones << "Dino"
p flintstones

# Question 7
# How can we add multiple items to our array? (Dino and Hoppy)

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones.push("Dino", "Hoppy")
p flintstones

# Question 8
# Shorten this sentence:
advice = "Few things in life are as important as house training your pet dinosaur."
# ...remove everything starting from "house".
advice.slice!("Few things in life are as important as ")
p advice # => "house training your pet dinosaur."

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice(0, 39)

# Question 9
# Write a one-liner to count the number of lower-case 't' characters in the following string:

statement = "The Flintstones Rock!"
p statement.count "t"

title = "Flintstone Family Members"
p title.center(40) # https://docs.ruby-lang.org/en/master/String.html#method-i-center



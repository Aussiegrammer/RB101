=begin
Question 2
Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

what is != and where should you use it? # ==> NOT, for example 1 != 2 == true
put ! before something, like !user_name # ==> if user_name is true, flip it to false and vice versa.
put ! after something, like words.uniq! # ==> IF the method has a muteable version, it will mutate the caller. This is a seperate method. 
put ? before something # ==> ? : is the ternary operator for if...else
put ? after something # ==> Some methods have this, which returns true or false
put !! before something, like !!user_name # !! is used to turn any object into their boolean equivalent.

=end

# Question 3 
# Replace the word "important" with "urgent" in this string:


advice = "Few things in life are as important as house training your pet dinosaur."
advice = advice.split
advice[6] = 'urgent'
advice = advice.join(" ")
p advice

# Way better way
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')

=begin
Question 4
The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]
What do the following method calls do (assume we reset numbers to the original array between method calls)?

numbers.delete_at(1)
numbers.delete(1)
=end 
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) # numbers is now [1, 3, 4, 5]

numbers = [1, 2, 3, 4, 5]
numbers.delete(1) # numbers is now [2, 3, 4, 5]

# Question 5
# Programmatically determine if 42 lies between 10 and 100.
p (10..100).include?(42)

# Question 6
# Starting with the string:

# famous_words = "seven years ago..."
# show two different ways to put the expected "Four score and " in front of it.

famous_words = "seven years ago..."
other_words = "Four score and "

# Method 1:
p other_words + famous_words
p other_words

# Question 7
# Make this into an unnested Array
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!
p flintstones

# Question 8
# Turn this into an array containing only two elements: Barney's name and Barney's number

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

array = flintstones.assoc("Fred")
p array

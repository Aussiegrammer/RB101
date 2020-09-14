# Question 1
10.times {|i| puts "The Flintstones Rock!".rjust(i + 21)}
# Alternative
10.times { |number| puts (" " * number) + "The Flintstones Rock!" }

# Question 2
# The result of the following statement will be an error:
# puts "the value of 40 + 2 is " + (40 + 2)
# Why is this and what are two possible ways to fix this?

# Integers cannot be directly added to strings.
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}" 

# Question 3
# Alan wrote the following method, which was intended to show all of the factors of the input number:
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. 
# How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, 
# but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

def factors(number)
  divisor = number
  factors = []
  while divisor > 0 do
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

p factors(5)
p factors(10)
p factors(-1)
p factors(0)
# Bonus 1

# What is the purpose of the number % divisor == 0 ? >> When divided with a remainder of 0, it confirms the number is a factor. 

# Bonus 2
# What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)? >> This returns the final factors array as a result. 

# Question 5 - Fibonnacci calculator
# Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

limit = 15 # This was a local variable

def fib(first_num, second_num, limit) 
  while first_num + second_num < limit # This couldnt find the variable. 
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit) # Added limit as a parameter to fix.
puts "result is #{result}"


# Question 6
# What is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer) # ==> This equals 50, but new_answer isn't used. 

p answer - 8 # ==> 34 is the output because answer is unchanged

# Question 7
# One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

# After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:
mess_with_demographics(munsters)
# This should all be unaffected as the has passed into the method is a copy, and not the original information. 
p munsters
# {"Herman"=>{"age"=>74, "gender"=>"other"}, "Lily"=>{"age"=>72, "gender"=>"other"}, "Grandpa"=>{"age"=>444, "gender"=>"other"}, "Eddie"=>{"age"=>52, "gender"=>"other"}, "Marilyn"=>{"age"=>65, "gender"=>"other"}}
# Information was changed as the original munsters hash was passed in, and the object ids were affected with it. 
# Testing in IRB showed if it was + it would be unaffected but += does change the data. 


# Question 8
# Method calls can take expressions as arguments. Suppose we define a method called rps as follows, 
# which follows the classic rules of rock-paper-scissors game, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

# What is the result of the following call?

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock") #==> Paper

# Question 9
# Consider these two simple methods:

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# What would be the return value of the following method invocation?

p bar(foo)
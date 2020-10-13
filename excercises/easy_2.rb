# Build a program that randomly generates and prints Teddy's age. To get the age, you should generate a random number between 20 and 200.

puts "Teddy is #{rand(20..200)} years old!"

# Further Exploration
# Modify this program to ask for a name, and then print the age for that person. For an extra challenge, use "Teddy" as the name if no name is entered.

puts "Enter a name: "
# name = gets.chomp
name = 'Christian'

def age(name = "Teddy")
  puts "#{name} is #{rand(20..200)} years old!"
end

age(name)

# Build a program that asks a user for the length and width of a room in meters and then displays the area of the room in both square meters and square feet.


SQMETERS_TO_SQFEET = 10.7639

puts "Enter the length of the room in meters:"
# length = gets.to_f
length = 10
puts "Enter the width of the room in meters:"
# width = gets.to_f
width = 7

area = length*width
area_in_feet = area * SQMETERS_TO_SQFEET

puts "The area of the room is #{area} square meters. (#{area_in_feet} square feet)"

# Create a simple tip calculator. The program should prompt for a bill amount and a tip rate. The program must compute the tip and then display both the tip and the total amount of the bill.

puts "What is the bill?"
# bill = gets.to_f
bill = 200
puts "What is the tip percentage?"
# tip = gets.to_f
tip = 10

tip_as_percentage = tip / 100
tip_total = bill*tip_as_percentage

puts "The tip is #{tip_total}"
puts "The total is #{tip_total + bill}"

# Build a program that displays when the user will retire and how many years she has to work till retirement.

puts "What is your age?"
age = 25

puts "What age would you like to retire?"
retire_age = 50

difference = retire_age - age
current_year = Time.now.year

puts "It's currently #{current_year}, and you will retire in #{current_year + difference}!"
puts "You only have #{difference} years to go!"

# Write a program that will ask for user's name. The program will then greet the user. If the user writes "name!" then the computer yells back to the user.

def greeting(name)
  if name.include?("!")
    puts "HELLO #{name.upcase}! WHY ARE WE YELLING?"
  else
    puts "Hello #{name}."
  end
end

puts "What is your name?"

greeting("Bob")
greeting("Bob!")

# Print all odd numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.

(1..99).each { |i| puts i if i.odd? }

# Print the even numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.

(1..99).each { |i| puts i if i.even? }

# LS Provided Solution: 
value = 1
while value <= 99
  puts value if value.even?
  value += 1
end

# Write a program that asks the user to enter an integer greater than 0, then asks if the user wants to determine the sum or product of all numbers between 1 and the entered integer.

def compute_sum(number)
  (1..number).inject { |sum, n| sum + n }
end

def compute_product(number)
  (1..number).inject { |prod, n| prod * n } 
end

def number_prompt
  number = nil
  loop do
    puts "Please enter a whole integer above 0:"
    number = gets.to_i
    if number > 0 
      break
    else
      puts "Please enter a valid number."
    end
  end
  number
end

def calculation_prompt
  calculation = nil
  loop do
    puts "Would you like the product or sum?"
    calculation = gets.chomp.downcase
    if calculation == "s" || calculation == "p"
      break
    else
      puts "Error, please enter s or p"
    end
  end
  calculation
end

number = number_prompt
calculation = calculation_prompt

if calculation == 's'
  puts "The sum of the number between 1 and #{number} is #{compute_sum(number)}"
elsif calculation == 'p'
  puts "The product of the numbers between 1 and #{number} is #{compute_product(number)}"
end

# What will the following code print, and why? Don't run the code until you have tried to answer.

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2


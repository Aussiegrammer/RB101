require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(key) # Easily prompt from reference yml file
  message = MESSAGES[key]
  puts "=> #{message}"
end

def integer?(input) # Validates integers
  input.to_i.to_s == input && input.to_i > 0
end

def float?(input) # Validates floats
  input.to_f.to_s == input && input.to_f > 0
end

def number?(input) # Attempts both confirmations to check if a number is real
  integer?(input) || float?(input)
end

def retrieve_input(prompt, variable) # Main method for retrieving user data
  loop do
    prompt(prompt)
    variable = gets.chomp
    
    return variable if number?(variable)
    prompt('not_a_number')
  end
end

prompt('welcome')
loop do # Main loop
  loan = retrieve_input('loan_prompt', loan)
  interest = retrieve_input('interest_prompt', interest)
  years = retrieve_input('years_prompt', years)

  prompt('calculating')

  annual_interest = interest.to_f / 100 # Convert whole integer into decimal
  monthly_interest = annual_interest / 12 
  months = years.to_i * 12

  monthly_payment = loan.to_f * (monthly_interest / 
                    (1 - (1 + monthly_interest)**(-months)))

  total_loan      = monthly_payment * months
  total_payment   = monthly_payment * months - loan.to_f # Total loan payment

  puts "=> Per month, you will owe $#{monthly_payment.ceil(2)}"
  puts "=> The total of all payments will be $#{total_loan.ceil(2)}"
  puts "=> The total cost of your loan's interest is $#{total_payment.ceil(2)}"

  prompt('another')
  answer = gets.chomp

  break unless answer.downcase == "y" || answer.downcase == "yes"
end

prompt('goodbye')

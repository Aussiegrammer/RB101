require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(key) # Easily prompt from reference yml file
  message = MESSAGES[key]
  puts "=> #{message}"
end

def integer?(input) # Validates integers
  input.to_i.to_s == input && input.to_i > 0
end

def float?(input) # Same as above but for floats
  input.to_f.to_s == input && input.to_i > 0
end

def number?(input) # Attempts both methods to confirm if a number is real
  integer?(input) || float?(input)
end

prompt('welcome')
loop do # Main loop
  loan = nil # Loan amount loop
  loop do
    prompt('loan_amount')
    loan = gets.chomp

    break if number?(loan)
    prompt('not_a_number')
  end

  interest = nil
  loop do # Interest amount loop
    prompt('interest_amount')
    interest = gets.chomp

    break if number?(interest)
    prompt('not_a_number')
  end

  years = nil
  loop do # Monthly duration loop
    prompt('duration_amount')
    years = gets.chomp

    break if number?(years)
    prompt('not_a_number')
  end

  prompt('calculating')

  annual_interest = interest.to_f / 100 # Convert whole integer into decimal
  monthly_interest = annual_interest / 12
  months = years.to_i * 12

  monthly_payment = loan.to_i * (monthly_interest / 
                    (1 - (1 + monthly_interest)**(-months)))

  total_loan      = monthly_payment * months
  total_payment   = monthly_payment * months - loan.to_i # Total loan payment

  puts "=> Per month, you will owe $#{monthly_payment.ceil(2)}"
  puts "=> The total of all payments will be $#{total_loan.ceil(2)}"
  puts "=> The total cost of your loan's interest is $#{total_payment.ceil(2)}"

  prompt('another')
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt('goodbye')

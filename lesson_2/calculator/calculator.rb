# Ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# return the result
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts "=> #{message}"
end

def valid_number?(input)
  input.to_i.to_s == input
end
prompt(MESSAGES['welcome'])

def operation_to_message(op)
  case op
  when '1' then 'Adding'
  when '2' then 'Subracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end
name = nil
loop do
  name = Kernel.gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do # main loop
  number1 = nil
  loop do
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  number2 = nil
  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end
  operator_prompt = <<-MSG
Finally, what operation would you like to perform?
1) Add
2) Subtract
3) Multiply
4) Divide
MSG

  prompt(operator_prompt)
  operator = nil
  loop do
    operator = Kernel.gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES[invalid_operator])
    end
  end

  result = case operator
           when '1' then number1.to_i + number2.to_i
           when '2' then number1.to_i - number2.to_i
           when '3' then number1.to_i * number2.to_i
           when '4' then number1.to_f / number2.to_f
           end

  prompt("#{operation_to_message(operator)} the two numbers...")
  prompt("The result is #{result}")
  prompt(MESSAGES['again_prompt'])

  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])

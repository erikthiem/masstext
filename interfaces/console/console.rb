# This file contains the console-based (text-based) interface.

# Load functions from backend.rb file
require_relative "../../backend/backend.rb"

i = 0 # Counter variable for the following while loop
number = 1  # Variable that the user's input is immediately stored to
numbers = Array.new

# Instruction message
puts <<INSTRUCTIONAL_MESSAGE

Please enter each cell phone number in the format 1234567890
After each phone number, hit enter. After you have entered the
final number, type in 0 (zero) and press enter.

INSTRUCTIONAL_MESSAGE

# Record the numbers until the user enters 0. Only records 10 digit numbers
while number != "0"
	print "> "
	number = gets.chomp
	if number != "0" 
		numbers[i] = number
		i += 1
	end
end

# This only allows 10-digit numbers to continue in the program
numbers = validateNumbers(numbers)

# Confirm the numbers to which the message will be sent
puts "The message will be sent to the following numbers:\n"
puts numbers

puts "If this is incorrect, please press Ctrl-C to stop MassText and start over."
puts "If this is correct, press enter to continue."

gets # Waits to continue until the user presses enter

print "Please enter the subject: "
subject = gets.chomp

print "Please enter the message: "
message = gets.chomp

print "Please enter a gmail account in the format name@gmail.com: "
email = gets.chomp

print "Please enter the password associated with this account: "
# This uses the highline library to obfuscate the password
password = ask("") { |q| q.echo = "*" }

# Send the message
sortAndSend(numbers, subject, message, email, password) 

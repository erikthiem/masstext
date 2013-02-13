# MassText v2.0 - A rewrite of MassText but this time using Ruby!
# by Erik Thiem

# These are here for downloading and parsing the html
require 'nokogiri'
require 'open-uri'

# This is required for sending the message
require 'net/smtp'

# This is required for making the password appear as asterisks
require 'highline/import'

# Given a number, this function returns a string containing the carrier name 
# if the number is a valid, US cell phone number. Otherwise it returns nothing.
def carrierName(number)
	webpage = "http://www.whitepages.com/phone/#{number}"

	# Get a Nokogiri::HTML::Document for the page we're interested in...
	html_doc = Nokogiri::HTML(open(webpage))

	carrier_name = String.new
	# Look for the 'description' class because this contains the carrier name
	html_doc.xpath('//span[@class="description"]').each do |method_span|
		carrier_name =  method_span.content
	end

	# Convert to lowercase to make it easier to determine the carrier
	carrier_name = carrier_name.downcase

	# Split string into arrays by word to make it easier to determine the carrier
	carrier_name_word_array = carrier_name.split(' ')

	# The carrier name is the first element of the array
	return carrier_name_word_array[0]
end


# Given a carrier name, this function returns a string containing the carrier
# name with the @company.com attached to the end. For example, verizon has
# 8888888888@vext.com for the number 888-888-8888
def carrierEmail(carrier)
	if carrier == 'verizon'
		ending = '@vtext.com'
	elsif carrier == 'at&t'
		ending = '@txt.att.net'
	elsif carrier == 't-mobile'
		ending = '@tmomail.net'
	elsif carrier == 'sprint'
		ending = '@messaging.sprintpcs.com'
	elsif carrier == 'alltel'
		ending = '@message.alltel.com'
	elsif carrier == 'virgin'
		ending = '@vmobl.com'
	elsif carrier == 'cellular'
		ending = '@mobile.celloneusa.com'
	elsif carrier == 'nextel'
		ending = '@messaging.sprintpcs.com' #nextel was acquired by spring
	else
		return false
	end

	return ending
end

# Given a gmail account, this function sends a message to an address
# using the gmail account
def sendMessage(subject, message, googleAccountName, googlePassword, toAddress)
	complete_message = "Subject: #{subject}\n\n#{message}."
	smtp = Net::SMTP.new 'smtp.gmail.com', 587
	smtp.enable_starttls
	smtp.start('gmail.com', googleAccountName, googlePassword, :login) do
		smtp.send_message(complete_message, 'MassText', toAddress)
	end
end


# Set arrays that will hold later information
numbers = Array.new # Used to store the entered phone numbers
carriers = Array.new # Used to store the determined carrier names
endings = Array.new # Used to store the "@carrier.com" endings
complete_addresses = Array.new # for ex, "4445556666@vtext.com"

# Request information from user with the following "gets"

i = 0; # Counter variable for the following while loop
number = 1
while number != "0"
	print "Please enter the cell phone number in the format 1234567890: "
	number = gets.chomp
	if number != "0"
		numbers[i] = number
	end
end

print "Please enter the subject: "
subject = gets.chomp

print "Please enter the message: "
message = gets.chomp

print "Please enter a gmail account in the format name@gmail.com: "
email = gets.chomp

print "Please enter the password associated with this account: "
# This uses the highline library to obfuscate the password
password = ask("") { |q| q.echo = "*" }


# Determine the carrier
for i in 0..numbers.length-1
	carriers[i] = carrierName(numbers[i])
end

# Determine the ending
for i in 0..carriers.length-1
	endings[i] = carrierEmail(carriers[i])
end

# Set the complete addresses
for i in 0..endings.length-1
	complete_addresses[i] = numbers[i] + endings[i]
end

# Send the message
for i in 0..complete_addresses.length-1
	sendMessage(subject, message, email, password, complete_addresses[i])
end

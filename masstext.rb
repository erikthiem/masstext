# MassText v2.0 - A rewrite of MassText but this time using Ruby!
# by Erik Thiem

require 'nokogiri'
require 'open-uri'

def carrierName(number)
# Given a number, this function returns a string containing the carrier name if the number is a valid, US cell phone number. Otherwise it returns nothing.
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

def randoNum(number_of_nums)
	numbers = Array.new

	i = 0 # counter variable
	
	while (i < number_of_nums)
		# Generate a random 10-digit number
		randnum = rand(10 ** 10)

		# Check to make sure that the number is actually 10 digits
		if randnum.to_s.length == 10
			numbers[i] = randnum
			i++
		end
	end

	return numbers
end

puts randoNum(5)

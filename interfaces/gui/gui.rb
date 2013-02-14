# NOT WORKING, USE CONSOLE INTERFACE

Shoes.app :width => 400, :height => 400 do
	background "#F0F0F0"
	stack do
		title "MassText\n"
	end
		
	stack do
		flow do
			para "Number:\t\t\t"
			number = edit_line
		end

		flow do
			para "Gmail username:\t\t"
			username = edit_line
		end

		flow do
			para "Gmail password:\t\t"
			password = edit_line :secret => true
		end

		flow do
			para "Subject:\t\t\t\t"
			subject = edit_line
		end

		flow do
			para "Message:\t\t\t"
			message = edit_box
		end

	end

	stack do
		flow do
			@submit = button "Send" 
		end
	end

	stack do
		@submit.click do
		# TODO: Add in code that does something when the submit button is clicked	

		end
	end

end

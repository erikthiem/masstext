# NOT WORKING, USE CONSOLE INTERFACE

Shoes.app do
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
			message = edit_line
		end

		flow do
			button "Send"
		end
	end

end

require 'colorize'
module Actions

	def lines
  		puts "*" * 55
  	end

  	def confirm
  		puts "-" * 65
  	end

  	def space
  		puts ""
  	end

  	def user_input_decor
  		space
  		print "> ".cyan
  	end

  	def error_message_sorry
  		puts "sorry I didn't get that, try again please".red
  	end

  	def good_bye
  		space
    	lines
    	puts "Thank you for using Wyncode's Voting Simulator Good Bye!!".cyan
    	lines
    	space
    	puts `clear`
  	end

end

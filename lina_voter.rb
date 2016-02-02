#great work! - Sean

puts `clear`

require "./actions"
require 'colorize'

class World
include Actions # methods: lines, space, error_message_sorry, good_bye,
	def initialize
		@voters_list = []
		@politicians_list = []
	end
#___________________________________________WELCOME
def welcome
	lines
	lines
	space
	puts "\tWelcome to Wyncode's Voting Simulator".upcase.yellow
	space
	lines
	lines
	space
	(sleep 1)
    	main_menu #start menu
    end
#___________________________________________MENU

def main_menu
	space
	puts "What would you you like to do?:".green
	puts "(C)reate, (L)ist, (U)pdate, or (D)elete (E)xit".green
	user_input_decor
	@menu = gets.chomp.capitalize
	case @menu
	when "C", "Create"
      create # start create
    when "L","List"
    	list
    when "U", "Update"
    	update
    when "D", "Delete"
    	delete
    when "E", "Exit"
    	good_bye
    else
    	space
    	error_message_sorry
    	space
    	main_menu
    end
  end
#___________________________________________CREATE

def create
	space
	puts "Would you like to create a: (P)olitician or (V)oter".cyan
	user_input_decor
	choice = gets.chomp.capitalize.strip
	case choice
	when "P"
		create_politician
	when "V"
		create_voter
	else
		space
		error_message_sorry
		space
		create
	end
end
#___________________________________________CREATE(POLITICIAN)

def create_politician
	space
	puts "What is your politician's name?".cyan
	user_input_decor
	politician_name = gets.chomp.capitalize.strip

	space
	puts "is #{politician_name} name correct? (Y)es or (N)o".cyan
	user_input_decor
	correct_p = gets.chomp.capitalize.strip

#________confirm name is correct

case correct_p
when "Y","Yes"
	space
	puts "Ok, Please choose a party for #{politician_name}: (D)emocract or (R)epublican".cyan
	user_input_decor
	politician_party = gets.chomp.capitalize.strip

	if politician_party == "D"
		politician_party = "Democrat"
	elsif  politician_party == "R"
		politician_party ="Republican"
	else
		space
		error_message_sorry
		space
		create_politician
	end

when "N","No"
	space
	puts "No problem, lets try again!".yellow
	create_politician
else
	space
	error_message_sorry
	space
	create_politician
end
#_______adding politician to list

new_politician = Politician.new(politician_name, politician_party)
@politicians_list << new_politician
space
puts "::Great! #{politician_name} has been added to the #{politician_party} party list::".yellow
confirm
main_menu
end
#___________________________________________CREATE(VOTER)

def create_voter
	space
	puts "What is your voter's name?".cyan
	user_input_decor
	voter_name = gets.chomp.capitalize.strip
	space
	puts "Name: #{voter_name} is this correct? (Y)es or (N)o?".cyan
	user_input_decor
	correct_v = gets.chomp.capitalize.strip

	#________confirm name is correct
	case correct_v
	when "Y", "Yes"
		space
		puts "Ok, Please choose a party for #{voter_name}:".cyan
		puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral".cyan
		user_input_decor
		voter_party = gets.chomp.capitalize.strip

		case voter_party
		when "L"
			voter_party = "Liberal Party"
		when "C"
			voter_party = "Conservative Party"
		when "T"
			voter_party = "Tea Party"
		when "S"
			voter_party = "Socialist Party"
		when "N"
			voter_party = "Neutral"
		else
			space
			error_message_sorry
			space
			create_voter
		end
	when "N","No"
		space
		puts "No problem, lets try again!".yellow
		create_voter
	else
		space
		error_message_sorry
		space
		create_voter
	end

	#_______adding voter to list
	new_voter = Voter.new(voter_name, voter_party)
	@voters_list << new_voter
	space
	puts "::#{voter_name} has been added to the #{voter_party} list::".yellow
	confirm
	main_menu
end
#___________________________________________PRINT BOTH LIST

def voter_list
	@voters_list.each do |x|
		puts " * #{x.voter_name}: #{x.voter_party}".yellow
	end
end

def politician_list
	@politicians_list.each do |x|
		puts " * #{x.politician_name}: #{x.politician_party}".yellow
	end
end

#___________________________________________LIST
def list

	space
	puts "What list would you like to see?:".cyan
	puts "(V)oters or (P)oliticians?".cyan
	user_input_decor
	display_list = gets.chomp.capitalize

	case display_list
	when "V", "Voter"
		space
		puts "Voter list:".yellow
		confirm
		voter_list
		main_menu
	when "P","Politician"
		space
		puts "Politician list:".yellow
		confirm
		politician_list
		main_menu
	else
		space
		error_message_sorry
		space
		main_menu
	end
end
#___________________________________________UPDATE

def update
	space
	puts "Update (P)oliticians or (V)oters list?".cyan
	user_input_decor
	update_choice = gets.chomp.capitalize.strip
	case update_choice
	when "V"
		update_voter
	when "P"
		update_politician
	else
		space
		error_message_sorry
		update
	end
end
#___________________________________________UPDATE POLITICIAN

def update_politician
	space
	politician_list
	puts "From the list above, who do you want to update?".cyan
	user_input_decor
	politician_update = gets.chomp.capitalize.strip
	@politicians_list.each do |change|
		if change.politician_name == politician_update
			puts "Update (N)ame or (P)arty?".cyan
			user_input_decor
			name_or_party = gets.chomp.capitalize.strip
			if name_or_party == "N"
				puts "What is the updated name?".cyan
				user_input_decor
				updated_name = gets.chomp.capitalize.strip
				change.politician_name = updated_name
				space
				puts "Thank you! The name has been changed to #{updated_name}.".cyan
				confirm
			elsif name_or_party == "P"
				puts "What is the updated party? (R)epublican or (D)emocrat?".cyan
				user_input_decor
				updated_party = gets.chomp.capitalize.strip

				if updated_party == "D"
					updated_party = "Democrat"
				elsif  updated_party == "R"
					updated_party ="Republican"
				else
					space
					error_message_sorry
					space
					update_politician
				end

				change.politician_party = updated_party
				space
				puts "Party change was made.".cyan
				confirm
			else
				space
				error_message_sorry
				update_politician
			end
			main_menu
		else
			puts "Sorry but we don't have that name in our list.".red
			main_menu
		end
	end
end
#___________________________________________UPDATE VOTER

def update_voter
	space
	voter_list
	puts "From the list above, who do you want to update?".cyan
	user_input_decor
	voter_update = gets.chomp.capitalize.strip
	@voters_list.each do |change|
		if change.voter_name == voter_update
			puts "Update (N)ame or (P)arty?".cyan
			user_input_decor
			name_or_party = gets.chomp.capitalize.strip
			if name_or_party == "N"
				puts "What is the updated name?".cyan
				user_input_decor
				updated_name = gets.chomp.capitalize.strip
				change.voter_name = updated_name
				space
				puts "Thank you! The name has been changed to #{updated_name}.".yellow
				confirm
			elsif name_or_party == "P"
				puts "What is the updated party?".cyan
				puts "(L)iberal, (C)onservative, (T)ea Party,(S)ocialist, or (N)eutral".cyan
				user_input_decor
				updated_party = gets.chomp.capitalize.strip

				case updated_party
				when "L"
					updated_party = "Liberal Party"
				when "C"
					updated_party = "Conservative Party"
				when "T"
					updated_party = "Tea Party"
				when "S"
					updated_party = "Socialist Party"
				when "N"
					updated_party = "Neutral"
				else
					space
					error_message_sorry
					space
					update_voter
				end

				change.voter_party = updated_party
				space
				puts "Party change was made.".yellow
				confirm
			else
				space
				error_message_sorry
				update_politician
			end
			main_menu
		else
			puts "Sorry but we don't have that name in our list.".red
			main_menu
		end
	end
end

#___________________________________________DELETE

def delete
	space
	puts "Delete (P)oliticians or (V)oters list?".cyan
	user_input_decor
	delete_choice = gets.chomp.capitalize.strip

	case delete_choice
	when "V"
		space
		voter_list
		space
		puts "Ok, our voter list above, who do you want to delete?".cyan
		user_input_decor
		name_deleting = gets.chomp.capitalize.strip
		@voters_list.delete_if do |voter|
			if voter.voter_name == name_deleting
				puts "#{name_deleting} has been deleted".yellow
				confirm
		   true
        else
        false
        end
      end
	when "P"
		space
		politician_list
		space
		puts "Ok our politician list is above, Who do you want to delete?".cyan
		user_input_decor
		name_deleting = gets.chomp.capitalize.strip
		@politicians_list.delete_if do |politician|
			if politician.politician_name == name_deleting
				puts "#{name_deleting} has been deleted".yellow
				confirm
		   true
        else
        false
        end
      end
		main_menu
	else
		delete
		error_message_sorry
		update
	end
	main_menu
end
end #world's end


class Voter < World
	attr_accessor :voter_name, :voter_party
	def initialize(voter_name, voter_party)
		@voter_name = voter_name
		@voter_party = voter_party
	end
end #voter's end


class Politician < World
	attr_accessor :politician_name, :politician_party
	def initialize(politician_name, politician_party)
		@politician_name = politician_name
		@politician_party = politician_party
	end
end #politician's end

launch = World.new
launch.welcome

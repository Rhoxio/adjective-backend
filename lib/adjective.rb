class MainDisplay

	def initialize(person)
		@person = person
		p @person.currently_earned_skills
		display_ui
	end

	def display_ui

		puts "You can do these skills:"
		@person.print_skills
		puts " "
		puts 'Or, you can:'
		@person.print_actions
		puts " "
		puts "Enter one option to continue:"

		input = gets.chomp.downcase
		if input == 'eat'
			puts "What would you like to feed #{@person.name}?"
			food = gets.chomp.downcase
			@person.eat_food(food)
			display_ui
		elsif input == 'sleep'
			puts "How many hours would you like to sleep?"
			hours = gets.chomp.downcase
			hours = hours.tr(',','').to_i
			@person.sleep(hours)
			display_ui
		end

	end
end

require 'adjective/person'

# bill = Person.new("Bill", 45, 168, "5'8", 10)

# 5.times do 
# 	bill.throw_ball
# end

# bill.hunger_level

# main = MainDisplay.new(bill)
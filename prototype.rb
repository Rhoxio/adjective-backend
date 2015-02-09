class MainDisplay

	def initialize(person)
		@person = person
		p @person.currently_earned_skills
		display_ui
	end

	def display_ui

		puts "~Welcome to the Shitshow!"
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
			@person.sleep(8)
			display_ui
		elsif input == 'shit'
			@person.take_a_shit
			display_ui
		end

	end
end


class Person

	attr_accessor :name, :age, :height, :weight, :currently_earned_skills, :actions, :hunger

	def initialize(name, age, weight, height, skill)
		@name = name
		@age = age
		@weight = weight
		@height = height
		@skill = skill
		@hunger = 1
		@actions = ['eat', 'sleep', 'shit']
		@currently_earned_skills = ["Archery", "Swordplay", "Defense"]
	end

# Display 
	def print_skills
		@currently_earned_skills.each do |skill|
			puts skill
		end
	end

	def print_actions
		@actions.each do |action|
		puts action
		end
	end

	def hunger_level
		case @hunger 
			when 1..4
				puts "#{@name} is starving."
			when 5..7
				puts "#{@name} is feeling fairly full."
			when 8..10
				puts "#{@name} is extremely full."
			end
	end

# Actions 
	def throw_ball
		throw_distance = (@skill * 3).to_s
		# puts @name + " threw the ball #{throw_distance} feet."
		@skill += 1
	end

	def take_a_shit
		puts ""
		puts @name + " took a big ol' shit."
		puts ""
	end

	def sleep(hours)
		puts ""
		puts @name + " slept for #{hours} hours."
		puts ""
	end

	def eat_food(food)
		puts 'hitting'
		puts @hunger
		@hunger += food.length
		puts @hunger
		if @hunger > 10
			@hunger = 10
			@skill -= 1
			puts "#{@name} barfed a little... (-1 Skill)" 
		end
	end

end

bill = Person.new("Bill", 45, 168, "5'8", 10)

# 5.times do 
# 	bill.throw_ball
# end

# bill.hunger_level

main = MainDisplay.new(bill)
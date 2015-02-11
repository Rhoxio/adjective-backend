class Person

	attr_accessor :name, :age, :height, :weight, :currently_earned_skills, :actions, :hunger

	def initialize(name, age, weight, height, skill)
		@name = name
		@age = age
		@weight = weight
		@height = height
		@skill = skill
		@hunger = 1
		@actions = ['eat', 'sleep']
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

class Thing 

	def self.print_stuff
		puts "Stuff"
	end
	
end
# class MainDisplay

# 	def initialize(person)
# 		@person = person
# 		p @person.currently_earned_skills
# 		display_ui
# 	end

# 	def display_ui

# 		puts "You can do these skills:"
# 		@person.print_skills
# 		puts " "
# 		puts 'Or, you can:'
# 		@person.print_actions
# 		puts " "
# 		puts "Enter one option to continue:"

# 		input = gets.chomp.downcase
# 		if input == 'eat'
# 			puts "What would you like to feed #{@person.name}?"
# 			food = gets.chomp.downcase
# 			@person.eat_food(food)
# 			display_ui
# 		elsif input == 'sleep'
# 			puts "How many hours would you like to sleep?"
# 			hours = gets.chomp.downcase
# 			hours = hours.tr(',','').to_i
# 			@person.sleep(hours)
# 			display_ui
# 		end

# 	end
# end

module Adjective

	class BuildModel

		def self.create_character(path, name)
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
		      class #{name} < ActiveRecord::Base
		        # Model methods get generated here.

		        def level_up
		          level_table = {1 => 10, 2 => 50, 3 => 100, 4 => 175, 5 => 260, 6 => 365, 7 => 480, 8 => 630, 9 => 830, 10 => 1010}

		          # Need to make this class-specific. 

		          if self.exp >= level_table[self.level]
		            self.exp = self.exp - level_table[self.level]
		            self.level += 1
		            self.max_hp += 20
		            self.defense += 1
		            self.initiative += 1
		            self.attack_rating += 2
		            self.current_hp = self.max_hp
		            self.save!
		            return true
		          else
		            return false
		          end
		        end

		        def give_currency(amount) 
		          if self.currency >= amount
		            self.currency -= amount
		          else
		            return "Not enough currency..."
		          end
		        end

		        def acquire_currency(amount)
		          self.currency += amount
		          self.save!
		        end

		        def dead?
		          if self.current_hp <= 0
		            return true
		          else
		            return false
		          end
		        end

		        def heal(healing)
		          if self.dead? == false
		            self.current_hp += healing
		            self.save!
		            if self.current_hp > self.max_hp
		              diff = self.current_hp - self.max_hp
		              self.current_hp = self.current_hp - diff
		              self.save!
		            end
		          return self.current_hp

		          else
		            return false
		          end

		        end

		        def located?
		          self.location
		        end
		      end
		      # End of File
		    EOF
		  end
		  puts "Created template Active Record model for #{name}"
		end

		def self.create_enemy(path, name)
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
		      class #{name} < ActiveRecord::Base
		        # Model methods get generated here.

		          def enemy_currency
		            self.currency = (self.level * 2) + rand(-2..5)
		          end

		          def dead? 
		            if self.current_hp <= 0
		              return true
		            else
		              return false
		            end
		          end

		          def heal(healing)
		            if self.dead? == false
		              self.current_hp += healing
		              if self.current_hp > self.max_hp
		                diff = self.current_hp - self.max_hp
		                self.current_hp = self.current_hp - diff
		              end
		            else
		              return false
		            end
		          end

		      end
		      # End of File
		    EOF
		  end
		  puts "Created template Active Record enemy model for #{name}"
		end

		def self.create_user(path, name)
			File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
		      class #{name} < ActiveRecord::Base
		    
		      	  has_many :characters

						  include BCrypt

						  validates :email, uniqueness: true

						  validates :name, :password_hash, presence: true

						  validates :email, presence: true, :format => { :with => /\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}/}

						  def password
						    @password ||= Password.new(password_hash)
						  end

						  def password=(new_password)
						    @password = Password.create(new_password)
						    self.password_hash = @password
						  end

					end
		      # End of File
		    EOF
		  end
		  puts "Created template Active Record model for #{name}"
		end

		def self.create_location(path, name)
			File.open(path, 'w+') do |f|
				f.write(<<-EOF.strip_heredoc)
					class #{name} < ActiveRecord::Base

					end
					# End of File
				EOF
			end
			puts "Created template Active Record model for #{name}"
		end

	end

	class BuildMigration

		def self.create_character_migration(name, path)
		  name = name[6..-1]
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
		      class #{name} < ActiveRecord::Migration
		        def change

		          create_table :characters do |t|
		            t.string :name
		            t.string :player_class
		            t.string :gender
		            t.integer :currency

		            t.integer :level
		            t.integer :exp

		            t.integer :max_hp
		            t.integer :current_hp

		            t.integer :skill
		            t.integer :skill_exp
		            
		            t.integer :attack_rating
		            t.integer :initiative
		            t.integer :defense

		            t.string :avatar            
		            t.string :headshot

		            t.integer :location, :array => true

		            t.integer :weapon_id
		            t.integer :shield_id

		            t.string :user_id

		            t.timestamps
		          end

		        end
		      end
		    EOF
		  end
		  puts "Created template Active Record migration for #{name}"
		end

		def self.create_enemy_migration(name, path)
		  name = name[6..-1]
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
		      class #{name} < ActiveRecord::Migration
		        def change
		        create_table :enemys do |t|
		        t.string :name
		        t.string :enemy_class
		        t.string :avatar

		        t.integer :level
		        t.integer :exp

		        t.integer :max_hp
		        t.integer :current_hp
		         
		        t.integer :skill

		        t.integer :attack_rating
		        t.integer :initiative
		        t.integer :defense

		        t.integer :currency

		        t.timestamps
		        end
		      end
		    end
		    EOF
		  end
		  puts "Created template Active Record migration for #{name}"
		end

		def self.create_user_migration(name, path)
			name = name[6..-1]
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
			      class #{name} < ActiveRecord::Migration
						  def change 
						  	create_table :users do |t|
						  		t.string :name
						  		t.string :email
						  		t.string :password_hash

						  		t.integer :current_character

						  		t.timestamps
						  	end
						  end
			      end
		    EOF
		  end
		  puts "Created template Active Record migration for #{name}"
		end

		def self.create_location_migration(name, path)
			name = name[6..-1]
		  File.open(path, 'w+') do |f|
		    f.write(<<-EOF.strip_heredoc)
			      class #{name} < ActiveRecord::Migration
						  def change
						  	create_table :locations do |t|
						  		t.string :name

						  		t.string :js_view
						  		t.string :js_controller
						  		t.string :js_battle

						  		t.string :battle_background

						  		t.integer :enemy_types, :array => true

						  		t.string :coordinates
						    end
						  end
			      end
		    EOF
		  end
		  puts "Created template Active Record migration for #{name}"
		end

	end

end

# bill = Person.new("Bill", 45, 168, "5'8", 10)

# 5.times do 
# 	bill.throw_ball
# end

# bill.hunger_level

# main = MainDisplay.new(bill)








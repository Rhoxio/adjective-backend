require 'rake'

require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support/core_ext'

def create_character(model_path, model_name)
  File.open(model_path, 'w+') do |f|
    f.write(<<-EOF.strip_heredoc)
      class #{model_name} < ActiveRecord::Base
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
  puts "Created template Active Record model for #{model_name}"
end

def create_migration(migration_name, migration_path)
  name = migration_name[6..-1]
  File.open(migration_path, 'w+') do |f|
    f.write(<<-EOF.strip_heredoc)
      class #{migration_name} < ActiveRecord::Migration
        def change
        end
      end
    EOF
  end
  puts "Created template Active Record migration for #{name}"
end


namespace :generate do
  desc "rake generate:model NAME=User"
  task :character do

    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:character NAME=character"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path     = APP_ROOT.join('app', 'models', model_filename)

    migration_name = "Create" + ENV['NAME'].capitalize
    filename       = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), "create_" + ENV['NAME'].underscore]
    migration_path = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    create_character(model_path, model_name)
    create_migration(migration_name, migration_path)

  end








  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks"
  task :migration do

  end








  desc "Create an empty model spec in spec, e.g., rake generate:spec NAME=user"
  task :spec do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:spec NAME=user"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_spec.rb" % ENV['NAME'].underscore
    path     = APP_ROOT.join('spec', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        require 'spec_helper'

        describe #{name} do
          pending "add some examples to (or delete) #{__FILE__}"
        end
      EOF
    end
  end

end

namespace :db do
  desc "Drop, create, and migrate the database"
  task :reset => [:drop, :create, :migrate]

  desc "Create the databases at #{DB_NAME}"
  task :create do
    puts "Creating development and test databases if they don't exist..."
    system("createdb #{APP_NAME}_development && createdb #{APP_NAME}_test")
  end

  desc "Drop the database at #{DB_NAME}"
  task :drop do
    puts "Dropping development and test databases..."
    system("dropdb #{APP_NAME}_development && dropdb #{APP_NAME}_test")
  end

  desc "Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
  end

  desc "rollback your migration--use STEP=number to step back multiple times"
  task :rollback do
    step = (ENV['STEP'] || 1).to_i
    ActiveRecord::Migrator.rollback('db/migrate', step)
    Rake::Task['db:version'].invoke if Rake::Task['db:version']
  end

  desc "Populate the database with dummy data by running db/seeds.rb"
  task :seed do
    require APP_ROOT.join('db', 'seeds.rb')
  end

  desc "Returns the current schema version number"
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end

  namespace :test do
    desc "Migrate test database"
    task :prepare do
      system "rake db:migrate RACK_ENV=test"
    end
  end
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end

task :default  => :spec

require 'rake'

# Requiring the files in the environment folder... 
require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support/core_ext'

namespace :generate do

# Character Template Generator
  desc "rake generate:character NAME=User"
  task :character do

    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:character NAME=character"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    # APP_ROOT is defined in /config/environment.rb
    model_path     = APP_ROOT.join('app', 'models', model_filename)

    migration_name = "Create" + ENV['NAME'].capitalize
    filename       = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), "create_" + ENV['NAME'].underscore]
    migration_path = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    Adjective::BuildModel.create_character(model_path, model_name)
    Adjective::BuildMigration.create_migration(migration_name, migration_path)

  end

# --Enemy Template Generator--
  desc "rake generate:enemy NAME=enemy"
  task :enemy do

    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:character NAME=character"
    end

    enemy_name     = ENV['NAME'].camelize
    enemy_filename = ENV['NAME'].underscore + '.rb'
    enemy_path     = APP_ROOT.join('app', 'models', enemy_filename)

    migration_name = "Create" + ENV['NAME'].capitalize
    filename       = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), "create_" + ENV['NAME'].underscore]
    migration_path = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(enemy_path)
      raise "ERROR: Model file '#{enemy_path}' already exists"
    end

    Adjective::BuildModel.create_enemy(enemy_path, enemy_name)
    Adjective::BuildMigration.create_enemy_migration(migration_name, migration_path)

  end

  desc "Create a template user model. Includes BCrypt"
  task :users do

    user_model_path = APP_ROOT.join('app', 'models', 'user.rb')

    user = "User"
    filename       = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), "create_user"]
    path = APP_ROOT.join('db', 'migrate', filename)


    Adjective::BuildModel.create_user(user_model_path, "User")
    Adjective::BuildMigration.create_user_migration("CreateUser", path)
  end


# Empty Migration Generator
  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=tasks"
  task :empty_migration do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:migration NAME=create_tasks"
    end

    migration_name = "Create" + ENV['NAME'].capitalize
    filename       = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), "create_" + ENV['NAME'].underscore]
    migration_path = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(migration_path)
      raise "ERROR: File '#{migration_path}' already exists"
    end

    puts "Creating #{migration_path}"
    File.open(migration_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{migration_name} < ActiveRecord::Migration
          def change
          end
        end
      EOF
    end
  end

# Empty Model Generator
  desc "Create an empty model in app/models, e.g., rake generate:model NAME=User"
  task :empty_model do
    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:model NAME=User"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path = APP_ROOT.join('app', 'models', model_filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    puts "Creating #{model_path}"
    File.open(model_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{model_name} < ActiveRecord::Base
          # Remember to create a migration!
        end
      EOF
    end
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

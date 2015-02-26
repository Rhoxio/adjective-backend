configure do 
	enable :cross_origin
end

before do
  cross_origin :allow_origin => '*',
  :allow_methods => [:get, :post, :options],
  :allow_credentials => false,
  :max_age => "172000"
end

set :protection, false


# Post Options
options '/characters' do
    200
end

options '/users' do
    200
end

# options '/enemies' do
# 	200
# end

# options '/upload' do
# 	200
# end

get '/' do 
	erb :index
end

get '/character/:id' do
	@character = Character.find(params[:id])
	@character.to_json
end

get '/characters' do
	@characters = Character.all
	@characters.to_json
end

get '/characters/:users_characters' do
	# Once I get character associations cleaned up, this will be trivial. 
	character_list = []

	character_ids = params[:users_characters].split(',')

	character_ids.each do |character_id|
		@character = Character.find(character_id)
		character_list.push(@character)
	end

	return character_list.to_json

end

get '/enemies' do
	@enemies = Enemy.all 
	@enemies.to_json
end

get '/enemy/:id' do
	@enemy = Enemy.find(params[:id])
	@enemy.to_json
end

post '/characters' do

	begin
		params.merge! JSON.parse(request.env["rack.input"].read)
	rescue JSON::ParserError
		logger.error "Cannot parse response body."
	end

	@new_character = Character.new(name: params[:name], player_class: params[:player_class])
	if @new_character.save
		puts 'Success!'
		{result: params[:name], seen:true}.to_json
	else
		puts "Failed to create character"
	end
	
end

post '/users' do 

	begin
		params.merge! JSON.parse(request.env["rack.input"].read)
	rescue JSON::ParserError
		logger.error "Cannot parse response body."
	end

	@new_user = User.new(name: params[:name], email: params[:email])
	@new_user.password = params[:password]
	if @new_user.save
		puts 'Success!'
		{result: params[:name], seen:true}.to_json
	else
		puts "Failed to create user"
	end

end

post '/upload' do

	File.open('public/images/' + params['file'][:filename], 'w') do |f|
		f.write(params['file'][:tempfile].read)
	end

	return 'The file was successfully uploaded!'
end

post '/location' do 

	@new_location = Location.new(params[:name], params[:background_path], params[:battle_background], params[:coordinates], params[:enemy_types]) 

end	

get '/picture/:img' do
	content_type 'image/png'
	send_file File.join('public', 'images', params[:img])
end
	


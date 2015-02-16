before do
	content_type :json

	cors_set_access_control_headers

end

set :protection, false

options '/characters' do
    200
end

options '/users' do
    200
end

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
	


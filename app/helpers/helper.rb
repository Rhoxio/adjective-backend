helpers do
	def cors_set_access_control_headers
	  headers['Access-Control-Allow-Origin'] = '*'
	  headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, HEAD, DELETE,'
	  headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
	  headers['Access-Control-Max-Age'] = "1728000"
	end
end
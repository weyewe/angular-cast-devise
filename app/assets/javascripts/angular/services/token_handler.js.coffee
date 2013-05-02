@app.factory 'TokenHandler', ->
	tokenHandler = {}
	token = null
	
	tokenHandler.set = (newToken) -> 
		console.log("in setting the new token: #{newToken}")
		token = newToken 
	
	tokenHandler.get = ->
		token 

	tokenHandler.wrapActions = (resource, actions) ->
		wrappedResource = resource 
		for action in actions
			tokenWrapper( wrappedResource, action)
			
		wrappedResource

	tokenWrapper = (resource, action) ->
		resource['_' + action] = resource[action]
		resource[action] = (data, success, error) -> 
		# modify newData
			newData = angular.extend( {}, data || {}, { auth_token: tokenHandler.get() })
			
		# call the old function with new data
			resource['_' + action]( newData, success, error) 
			
	tokenHandler

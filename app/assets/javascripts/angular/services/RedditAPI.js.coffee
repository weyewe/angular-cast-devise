@app.factory 'RedditAPI',
	[
		'$resource',
		($resource) ->
			
			baseUrl = 'http://www.reddit.com/r' 
			# subRedditName = subReddit.name;
			limit = 100 ;
			# recordsDirection = '' 
			#       
			# finalUrl = 	baseUrl + '/' + 
			# 								subRedditName + '/' + 
			# 									'hot.json' + '?' + 
			# 									'limit=' + limit + '&' + 
			# 									'jsonp=JSON_CALLBACK' + '&' + 
			# 									'format=json'
			
			# $http.jsonp( finalUrl)
			# 	.success (result, status, headers, config) -> 
			# 		angular.forEach result.data.children, (value) -> 
			# 			$scope.posts.push value.data
						
			url = "#{baseUrl}/:subRedditName/hot.json"
			
			resource = $resource url, 
				{},
				{
					index: {
						method:'JSONP', 
						params:	{
							limit: limit,
							jsonp: 'JSON_CALLBACK',
							format: 'json'
						}
					}
				}
	
			resource
	]


@app.controller "PostsCtrl",
	[
		'$scope',
		'$http',
		'$resource',
		'$rootScope',
		($scope, $http, $resource, $rootScope) -> 
			$scope.posts = []
			$scope.selectedSubReddit = null
			$scope.selectedPost = null 
			
			$scope.$on 'subRedditSelected', 
				(event, args) -> 
					if $scope.selectedSubReddit != args.subReddit
						if $scope.posts
							delete $scope.posts 
							$scope.posts = null
							$scope.posts = []
						
						$scope.selectedPost = null
						$scope.selectedSubReddit = args.subReddit
						loadPosts( args.subReddit )
						
					
			
			$scope.updateSelectedPostFromKeyboard = (keyCode) ->
				arrowUp = 38
				arrowDown = 40
				
				if $scope.selectedPost != null && $scope.posts != null 
					currentIndex = $scope.posts.indexOf( $scope.selectedPost )
					postsLength = $scope.posts.length 
					
					if keyCode == arrowDown && currentIndex < postsLength
						$scope.selectedPost = $scope.posts[ currentIndex + 1 ]
						
					if keyCode == arrowUp && currentIndex > 0 
						$scope.selectedPost = $scope.posts[ currentIndex - 1 ]
						
					$scope.showPictures( $scope.selectedPost ) 
					
			
					
			$scope.showPictures = (post) -> 
				pictureArray =[] 
				$scope.selectedPost = post 
				if isNormalImageLink( post.url ) == true 
					pictureArray.push post.url  
					$rootScope.$broadcast 'showPictures', 
						{
							pictures : pictureArray,
							post : post 
						}
				else
					$http.post( 
							'/extract_images.json', 
							{
								url: post.url
							}
						)
						.success (data, status, headers, config) ->
							angular.forEach data.images, (value) -> 
								pictureArray.push value 
							
							$rootScope.$broadcast 'showPictures', 
								{
									pictures: pictureArray, 
									post : post 
								}
								
			
		 
 
		
			$scope.isSelected = (post) -> 
				'active' if $scope.selectedPost == post 
				
			isNormalImageLink = (url) -> 
				matching = url.match(/\.(svg|jpe?g|png|gif)(?:[?#].*)?$|(?:imgur\.com|www.quickmeme\.com\/meme|qkme\.me)\/([^?#\/.]*)(?:[?#].*)?(?:\/)?$/)
				
				return '' if !matching 
				
				if matching[1]
					return true
				else
					return false 
					
		
	 
		
			loadPosts = (subReddit) -> 
				baseUrl = 'http://www.reddit.com/r'; 
				subRedditName = subReddit.name;
				limit = 100 ;
				recordsDirection = '' 
        
				finalUrl = 	baseUrl + '/' + 
												subRedditName + '/' + 
													'hot.json' + '?' + 
													'limit=' + limit + '&' + 
													'jsonp=JSON_CALLBACK' + '&' + 
													'format=json'
				
				$http.jsonp( finalUrl)
					.success (result, status, headers, config) -> 
						angular.forEach result.data.children, (value) -> 
							$scope.posts.push value.data 
	]


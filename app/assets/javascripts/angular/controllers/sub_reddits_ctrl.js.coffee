@app.controller 'SubRedditsCtrl',
	[
		'$scope',
		'$http',
		'$rootScope',
		'SubReddit',
		($scope, $http, $rootScope, SubReddit) ->
			$scope.subReddits = []
			$scope.selectedSubReddit = null
			$scope.subRedditCreateMode = false 
			$scope.newSubReddit = {}
			
			$scope.showForm = ->
				$scope.subRedditCreateMode = true 
			
			$scope.cancelForm = ->
				$scope.subRedditCreateMode = false 
				
			$scope.createSubReddit = (newSubReddit) ->
				SubReddit.create( newSubReddit, (data) -> 
					if data.success == true 
						$scope.subReddits.push newSubReddit
						$scope.newSubReddit = {}
						$scope.subRedditCreateMode = false 
						$scope.selectedSubReddit = newSubReddit 
				)
			
	 
			$scope.showPosts = (subReddit)  -> 
				$scope.selectedSubReddit = subReddit
			
			$scope.isSelected = (subReddit) -> 
				'active' if $scope.selectedSubReddit == subReddit
				
		 
			$scope.destroy = ->
				if $scope.selectedSubReddit == null
					return 
				
				indexOfSelectedSubReddit = $scope.subReddits.indexOf( $scope.selectedSubReddit ) 
				
				SubReddit.destroy( $scope.selectedSubReddit, (data) -> 
					if data.success == true 
						$scope.subReddits.splice indexOfSelectedSubReddit, 1 
						$scope.selectedSubReddit = $scope.subReddits[0]
					
				)
				
		 
			$scope.$watch 'selectedSubReddit', (newValue, oldValue) ->
				if newValue != oldValue && newValue != null && newValue != undefined
					$rootScope.$broadcast( 'subRedditSelected', { subReddit : newValue})
				
				
				
			 
					# can we change this with SubReddit.query 
			loadSubReddits = -> 
				# SubReddit.query
				SubReddit.index {}, 
					(data  ) ->
						angular.forEach data, (value) ->
							$scope.subReddits.push value 
	
			
			loadSubReddits() 
		
			console.log("subreddit ctrl is ready")
	]


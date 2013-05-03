@app.controller 'SubRedditsCtrl',
	[
		'$scope',
		'$http',
		'$rootScope',
		'SubReddit',
		($scope, $http, $rootScope, SubReddit) ->
			$scope.subReddits =  null
			$scope.subRedditCreateMode = false 
			$scope.newSubReddit = {}
			
			
			
			$scope.showForm = ->
				$scope.subRedditCreateMode = true 
			
			$scope.cancelForm = ->
				$scope.subRedditCreateMode = false 
				
			$scope.createSubReddit = (newSubReddit) ->
				SubReddit.create( newSubReddit, (data) -> 
					if data.success == true 
						# $scope.subReddits.push newSubReddit
						# $scope.updateSubReddits()
						
						SubReddit.objects.push( data.sub_reddit )
						$scope.newSubReddit = {}
						$scope.subRedditCreateMode = false 
						# $scope.selectedSubReddit = newSubReddit 
						SubReddit.setSelectedObject( data.sub_reddit )
				)
				
			$scope.anySelectedObject = () -> 
				SubReddit.selectedObject
			
	 
			$scope.selectSubReddit = (subReddit)  -> 
				SubReddit.setSelectedObject( subReddit ) 
				# $rootScope.$broadcast( 'subRedditSelected', { subReddit : subReddit})
			
			$scope.isSelected = (subReddit) -> 
				'active' if SubReddit.selectedObject == subReddit
				
		 
			$scope.destroy = ->
				if $scope.selectedSubReddit == null
					return 
				
				indexOfSelectedSubReddit = $scope.subReddits.indexOf( $scope.selectedSubReddit ) 
				SubReddit.deleteSelectedObject()
				# SubReddit.destroy( $, (data) -> 
				# 	if data.success == true 
				# 		$scope.subReddits.splice indexOfSelectedSubReddit, 1 
				# 		$scope.selectedSubReddit = $scope.subReddits[0]
				# 	
				# )
				

				
			$scope.updateSubReddits = () -> 
				$scope.subReddits = SubReddit.objects
	 
			$scope.$watch 'subRedditModelFeedPopulated' , () ->
				$scope.updateSubReddits() 
			
			$scope.autoSelectSubReddit = () ->
				console.log("Gonna autoSelect subreddit")
				selected = $scope.subReddits.last 
				SubReddit.setSelectedObject( selected ) 
			
			$scope.$watch 'subRedditModelDestroy' , () ->
				console.log("In watch subRedditModelDestroy")
				$scope.updateSubReddits()
				$scope.autoSelectSubReddit()
			
			loadSubReddits = -> 
				SubReddit.loadObjectsFromServer() 
	
			
			loadSubReddits() 
	]


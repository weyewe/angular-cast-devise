
@app.controller 'PostViewerCtrl', 
	[
		'$scope',
		'$http',
		'$resource',
		($scope, $http, $resource, $rootScope) -> 
			$scope.pictureArray = null
			$scope.selectedPost = null
			
			$scope.noImages = -> 
				$scope.pictureArray == null or $scope.pictureArray.length == 0 
			
			$scope.$on('showPictures', 
				(event, args) -> 
					if $scope.selectedPost != args.post 
						$scope.selectedPost = args.post
						$scope.pictureArray = args.pictures
			)
					
	]

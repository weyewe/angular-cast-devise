
@app.controller "EpisodesCtrl",
	[
		'$scope',
		'$http',
		($scope, $http) -> 
			$scope.episodes = []
			$scope.selectedEpisode = null 
			
			$scope.showEpisode = (episode) -> 
				$scope.selectedEpisode = episode
				loadVideo( episode )
			
			$scope.isSelected = (episode) ->
				'active' if $scope.selectedEpisode == episode
			
			loadEpisodes = -> 
				$http.get("/episodes.json")
					.success (data, status, headers, config) -> 
						angular.forEach(
							data,
							(value) -> 
								$scope.episodes.push value 
						)
			
			loadEpisodes() 
	]


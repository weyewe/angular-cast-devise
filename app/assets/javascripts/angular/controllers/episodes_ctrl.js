// # app/assets/javascripts/angular/controllers/episodes_ctrl.js.coffee
// 
// @EpisodesCtrl = @app.controller 'EpisodesCtrl', [
// 	"$scope", "$http", ($scope, $http) ->
//   $scope.episodes = []
// 
//   loadEpisodes = ->
//     $http.get("/episodes.json").success((data, status, headers, config) ->
//       angular.forEach data, (value) ->
//         $scope.episodes.push value.episode
//     )
// 
//   loadEpisodes()
// 	
// 	
// ]

app.controller('EpisodesCtrl', [ '$scope', '$http', function($scope, $http){
	$scope.episodes = [] ;
	$scope.selectedEpisode = null ;  
	
	
	
	$scope.showEpisode = function(episode){
		// console.log(" showEpisode is called");
		$scope.selectedEpisode = episode;
		// console.log("The video_url: " + episode.video_url) ;
		loadVideo(episode);
	};
	
	$scope.isSelected = function(episode){
		if( $scope.selectedEpisode == episode ){
			return 'active' ;
		}
	};
	
	loadEpisodes = function(){
		$http.get("/episodes.json").success( function(data,status,headers, config){
			// console.log("The data: " + data);
			angular.forEach( data, function(value){
				// $scope.episodes.push( value.episode ) ;
				$scope.episodes.push( value );
				// console.log( value ) ;
			});
		});
	};
	
	loadVideo = function(episode){
		$("#player").flowplayer({
			playlist: [
				{mp4: '"' + episode.video_url + '"'}
			],
			ratio   : 9/14
		});
	};
	
	loadEpisodes(); 
}]);


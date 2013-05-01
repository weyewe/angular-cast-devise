
// angular.module( 'AngularCasts')
app.controller('SubRedditsCtrl', [ '$scope', '$http', '$rootScope', 'SubReddit',
		function($scope, $http, $rootScope, SubReddit){
	$scope.subReddits = [] ;
	$scope.selectedSubReddit = null ;  
	
	$scope.subRedditCreateMode = false;
	
	$scope.newSubReddit = {};
	
	
	$scope.showForm = function(){
		// console.log("The form is shown");
		$scope.subRedditCreateMode = true; 
		// console.log("The subRedditCreateMode: " + $scope.subRedditCreateMode);
	};
	
	$scope.cancelForm = function(){
		$scope.subRedditCreateMode = false;
	};
	
	$scope.createSubReddit = function(newSubReddit){
		// t = new SubReddits(newSubReddit);
		// console.log("gonna create sub reddit");
		// console.log( newSubReddit );
		
		SubReddit.create( newSubReddit, function(data){
			// console.log("The return value:");
			// console.log( data ) ;
			if( data.success === true ) {
				
				$scope.subReddits.push( newSubReddit );
				$scope.newSubReddit = {}; 
				$scope.subRedditCreateMode = false ; 
				$scope.selectedSubReddit = newSubReddit;
			}
		} ) ;
		
		
		
		// t.$create(function(newSubReddit) {
		// 	// $location.path('/tasks/'+task.id);
		// });
	};
	
	
	
	// related with Posts
	
	
	$scope.showPosts = function(subReddit){
		// console.log(" showEpisode is called");
		$scope.selectedSubReddit = subReddit; 
	};
 
	
	$scope.isSelected = function(subReddit){
		if( $scope.selectedSubReddit == subReddit ){
			return 'active' ;
		}
	};
	
	$scope.destroy = function(){
		if( $scope.selectedSubReddit === null ){return;}
		
		var indexOfSelectedSubReddit = $scope.subReddits.indexOf(   $scope.selectedSubReddit  );
		
		SubReddit.destroy( $scope.selectedSubReddit  , function( data ){
			// console.log("destroy result");
			// console.log( data ) ;
			if( data.success === true ) {
				console.log( 'it is destroyed');
				$scope.subReddits.splice(indexOfSelectedSubReddit, 1);
				
				$scope.selectedSubReddit = $scope.subReddits[0]; 
				console.log("The new selected SubReddit: "  );
				console.log( $scope.selectedSubReddit );
			}else{
				console.log(" it is not destroyed. safe haven here");
			}
		})
	};
	
	$scope.$watch("selectedSubReddit", function(newValue, oldValue) { 
		if( ( newValue !== oldValue) && (newValue !== null) && ( newValue !== undefined)){
			console.log("Gonna load the posts");
			$rootScope.$broadcast('subRedditSelected', { subReddit: newValue});
		}
	});
	
	
	loadSubReddits = function(){
		$http.get("/sub_reddits.json").success( function(data,status,headers, config){
			// console.log("The data: " + data);
			angular.forEach( data, function(value){
				// $scope.episodes.push( value.episode ) ;
				$scope.subReddits.push( value );
				// console.log( value ) ;
			});
		});
	};
	 
	
	loadSubReddits(); 
}]);


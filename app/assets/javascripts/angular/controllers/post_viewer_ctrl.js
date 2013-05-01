
app.controller('PostViewerCtrl', [ '$scope', '$http', '$resource', 
 			function($scope, $http, $resource, $rootScope){
	$scope.pictureArray = null ;
	$scope.selectedPost = null  ;
	
	
	$scope.noImages = function(){
		if( ( $scope.pictureArray === null) || 
				($scope.pictureArray.length === 0 )
		){
			return true;
		}
		
		return false; 
		
	}
	
	
	$scope.$on('showPictures', function (event, args) {
		if( $scope.selectedPost !== args.post ){
			$scope.selectedPost = args.post;
			$scope.pictureArray = args.pictures; 
		}
 		
		
	});
	
	 
}]);


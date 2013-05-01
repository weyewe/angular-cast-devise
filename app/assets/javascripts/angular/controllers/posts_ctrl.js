

app.controller('PostsCtrl', [ '$scope', '$http', '$resource', '$rootScope',
 			function($scope, $http, $resource, $rootScope){
	$scope.posts = [] ;
	$scope.selectedSubReddit = null ;  
	$scope.selectedPost = null ;  
	
	
	$scope.$on('subRedditSelected', function (event, args) {
		if( $scope.selectedSubReddit !== args.subReddit ){
			
			if( $scope.posts ){
				delete $scope.posts;
				$scope.posts = null;
				$scope.posts = [] ;
			}
			$scope.selectedPost = null ;  
			$scope.selectedSubReddit = args.subReddit;
			loadPosts( args.subReddit );
		}
	});
	
	$scope.$on('my:keyup', function(event, keyEvent) {
	  alert("Banzai");
	});
	
	$scope.updateSelectedPostFromKeyboard = function(keyCode){
		var arrowUp = 38; 
		var arrowDown = 40; 
		
		// fruits.indexOf("Apple");
		
		
		if(($scope.selectedPost !== null) && ($scope.posts !== null )) {
			var currentIndex = $scope.posts.indexOf( $scope.selectedPost );
			var postsLength = $scope.posts.length 
			
			if(( keyCode === arrowDown ) && ( currentIndex < postsLength )){
				$scope.selectedPost = $scope.posts[ currentIndex +  1];
			}
			
			if(( keyCode === arrowUp ) && ( currentIndex > 0  )){
				$scope.selectedPost = $scope.posts[ currentIndex -  1];
			}
			
			$scope.showPictures( $scope.selectedPost );
	 
		}

	};
	
	
	$scope.showPictures = function( post ){
		var pictureArray = [];
		$scope.selectedPost = post; 
		if( isNormalImageLink(post.url) === true ){
			// console.log("It was normal imge link");
			pictureArray.push( post.url );
			$rootScope.$broadcast('showPictures', { pictures: pictureArray, post: post  });
		}else{
			// console.log("Gonna extract images");
			$http.post("/extract_images.json", {
				url : post.url 
			}).success( function(data,status,headers, config){
				angular.forEach( data.images, function(value){
					pictureArray.push( value );
				});
				
				// console.log("the pictureArray: " );
				// console.log(pictureArray);
				$rootScope.$broadcast('showPictures', { pictures: pictureArray, post: post });
			});
		}
	};
	
	$scope.isSelected = function(post){
		if( $scope.selectedPost == post ){
			return 'active' ;
		}
	};
	
	isNormalImageLink = function(url) {
      var matching = url.match(/\.(svg|jpe?g|png|gif)(?:[?#].*)?$|(?:imgur\.com|www.quickmeme\.com\/meme|qkme\.me)\/([^?#\/.]*)(?:[?#].*)?(?:\/)?$/);
      if (!matching) return '';
      if (matching[1]) { // normal image link
          return true;
      }else{
					return false ;
			}	

  }
	
	
  
	
	
	loadPosts = function(subReddit){
		var baseUrl = 'http://www.reddit.com/r'; 
		var subRedditName = subReddit.name;
		var limit = 100 ;
		var recordsDirection = '' 
		
		var finalUrl = 	baseUrl + '/' + 
										subRedditName + '/' + 
											'hot.json' + '?' + 
											'limit=' + limit + '&' + 
											'jsonp=JSON_CALLBACK' + '&' + 
											'format=json'
		
		
		$http.jsonp(	finalUrl ).success( function(result,status,headers, config){
			// console.log("The data: " + data);
			// console.log( result ) ;
			// console.log("The success case");
			angular.forEach( result.data.children, function(value){
				// $scope.episodes.push( value.episode ) ;
				// console.log("the value")
				// console.log( value.data  );
				$scope.posts.push( value.data );
				// console.log( value ) ;
			});
			// console.log("Total posts length: " + $scope.posts.length );
			
			angular.forEach( $scope.posts, function(post){
				// console.log( post ) ;
			});
		});
	};
	 
	
	// loadSubReddits(); 
}]);


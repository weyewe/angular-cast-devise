
@app.controller "HeaderCtrl",
	[
		'$scope',
		'$rootScope',
		'TokenHandler',
		'$http',
		($scope, $rootScope, TokenHandler, $http) -> 
			
			
			$scope.showLoginForm = ->
				console.log 'showing login form' 
				$rootScope.showLogin() 
				$rootScope.isLoggedIn = true 
				
			$scope.showProtectedContent = ->
				console.log 'showing protected content'
				$rootScope.showProtectedContent()
				$rootScope.isLoggedIn = false 
				
			$scope.destroySession = -> 
				$http( 
						{
							method : "DELETE",
							url : '/api/users/sign_out',
							params 	: { auth_token : TokenHandler.get() }
						}
					)
					.success (data, status, headers, config) ->
						if data.success == true 
							console.log( data ) 
							$rootScope.email = null
							$rootScope.auth_token =  null
							$rootScope.isLoggedIn = false 
							# $rootScope.showLogin()
							console.log("The value of isProtectedContent: #{$rootScope.isProtectedContentShown}")
							console.log( "The value of isLoginFormShown: #{$rootScope.isLoginFormShown}")
						
		
			console.log "HeaderCtrl is ready"
	]


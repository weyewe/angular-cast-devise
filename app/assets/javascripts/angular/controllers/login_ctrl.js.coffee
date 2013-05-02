
@app.controller "LoginCtrl",
	[
		'$scope',
		'$rootScope',
		'$http',
		'TokenHandler',
		($scope, $rootScope, $http, TokenHandler) -> 
			
			$scope.password = null 
			$scope.email = null 
			
			
			$scope.createSession = ->
				$http.post( 
						'/api/users/sign_in', 
						{
							user_login : {
								email : $scope.email,
								password : $scope.password
							}
						}
					)
					.success (data, status, headers, config) ->
						if data.success == true 
							console.log( data ) 
							TokenHandler.set( data.auth_token )
							$rootScope.email = data.email 
							$rootScope.auth_token = data.auth_token
							$rootScope.isLoggedIn = true 
							$rootScope.showProtectedContent()
							console.log "logged in successfully"
						else
							$rootScope.email = null
							$rootScope.auth_token = null
							$rootScope.isLoggedIn = false 
							console.log( "fail to login")
				
			console.log("login is ready")
	]


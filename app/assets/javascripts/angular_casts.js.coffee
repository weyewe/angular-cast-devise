@app = angular.module "AngularCasts", ['ngResource'] 
 
# include the X-csrf 
@app.config [
		'$httpProvider',
		($httpProvider) -> 
			$httpProvider.defaults.headers.common['X-CSRF-Token'] =  $('meta[name=csrf-token]').attr('content')
	]
 


@app.run [
		'$rootScope', 
		'$http',
		($rootScope, $http) -> 
		# rootScope will be handling the basic authentication
			$rootScope.email = null;
			
		
			$rootScope.isLoggedIn = false 
			$rootScope.auth_token = null 
			
			# basic feature: show the data, no login form
			$rootScope.isProtectedContentShown = null 
			$rootScope.isLoginFormShown = null 
			
			$rootScope.showLogin = -> 
				$rootScope.isProtectedContentShown = false 
				$rootScope.isLoginFormShown = true 
			
			$rootScope.showProtectedContent = ->
				$rootScope.isProtectedContentShown = true 
				$rootScope.isLoginFormShown = false	
		
			
			checkAuthentication =  -> 
				$http.post(
					'/authenticate_auth_token',
					{
						auth_token : $rootScope.auth_token
					}
				).success(
					(data, status, headers, config) -> 
						if data.success != true 
							$rootScope.isLoggedIn = false
							$rootScope.auth_token = null
						else
							$rootScope.isLoggedIn = true 
				).error(
					(data, status, headers, config) ->
						$rootScope.isLoggedIn = false
						$rootScope.auth_token = null
				)
			
			
			# methods to initiate the whole magic
			if $rootScope.auth_token == null
				$rootScope.isLoggedIn = false
			else
				checkAuthentication() 
				
			$rootScope.showProtectedContent() 
	]


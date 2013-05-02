@app = angular.module "AngularCasts", ['ngResource'] 
 
@app.config [
		'$httpProvider',
		($httpProvider) -> 
			$httpProvider.defaults.headers.common['X-CSRF-Token'] =  $('meta[name=csrf-token]').attr('content')
	]


@app.run [
		'$rootScope', 
		'$http',
		($rootScope, $http) -> 
			$rootScope.isLoggedIn = true 
			$rootScope.auth_token = null 
			
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
			
			if $rootScope.auth_token == null
				$rootScope.isLoggedIn = false
			else
				checkAuthentication() 
	]


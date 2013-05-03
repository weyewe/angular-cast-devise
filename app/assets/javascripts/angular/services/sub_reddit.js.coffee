@app.factory 'SubReddit',
	[
		'$resource',
		'TokenHandler',
		'$rootScope',
		($resource, TokenHandler, $rootScope) ->
			resource = $resource '/sub_reddits/:id', 
				{ id: "@id"},
				{
					'create' : { method : "POST"},
					'index'  : { method : 'GET', isArray : true },
					'show'		: {method : 'GET', isArray : false},
					'update' 	: {method : "PUT"},
					'destroy' : { method : "DELETE"}
				}
			
			resource = TokenHandler.wrapActions( resource, 
				['create' , 'index', 'show', 'update' , 'destroy'])
				
			resource.objects = []
			resource.selectedObject = null 
			
			resource.setSelectedObject = ( object ) ->
				return null if !object 
				resource.selectedObject = object 
				$rootScope.$broadcast( 'subRedditSelected', { subReddit : object})
				console.log("called set selected object in SubReddit")
				
			resource.loadObjectsFromServer = () -> 
				resource.objects = [] 
				resource.index {}, 
					(data  ) ->
						angular.forEach data, (value) ->
							resource.objects.push value
						
						$rootScope.$broadcast('subRedditModelFeedPopulated' )
			
			resource.prevObject = () -> 
				null if resource.objects.length == 0 
				
				currentIndex = resource.objects.indexOf( resource.selectedObject  ) 
				if currentIndex > 0 
					currentIndex - 1
				else
					0
					
				
			resource.deleteSelectedObject = ( ) -> 
				object = resource.selectedObject 
				console.log("The object to be destroyed: #{object}")
				console.log object
				return null if not object
				console.log "Gonna send the destroy to the server"
				resource.destroy object, (data) ->
					if data.success == true
						objectIndex = resource.objects.indexOf( object )
						resource.objects.splice objectIndex, 1
						console.log ">>>SUccessful in destroying shite"
						$rootScope.$broadcast('subRedditModelDestroy')  
						console.log("After broadcast")
				
			
			
			resource 
	]

 
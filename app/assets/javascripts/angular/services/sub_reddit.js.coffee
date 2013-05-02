@app.factory 'SubReddit',
	[
		'$resource',
		'TokenHandler',
		($resource, TokenHandler) ->
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
				
			resource
	]

 
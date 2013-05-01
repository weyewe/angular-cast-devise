app.factory("SubReddit", ['$resource',function($resource){
	return $resource("/sub_reddits/:id", {id : "@id"},
		{
			'create' : { method : "POST"},
			'index'  : { method : 'GET', isArray : true },
			'show'		: {method : 'GET', isArray : false},
			'update' 	: {method : "PUT"},
			'destroy' : { method : "DELETE"}
		}
	);
} ]







);
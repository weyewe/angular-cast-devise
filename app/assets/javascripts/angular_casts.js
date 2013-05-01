var app = angular.module("AngularCasts", ['ngResource']);


app.config(['$httpProvider', function($httpProvider){
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = 
	$('meta[name=csrf-token]').attr('content'); 
}]
);



// 
// 
// 37 - left
// 
// 38 - up
// 
// 39 - right
// 
// 40 - down
// 

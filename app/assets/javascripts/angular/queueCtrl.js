queueApp.controller('queueCtrl', [
			'$scope', 'Post',
	function($scope, Post){

		$scope.posts = {};

		Post.query(function(json){
			$scope.posts = json;
		});
}]);

queueApp.controller('queueCtrl', [
			'$scope', 'Post',
	function($scope, Post){

		$scope.posts = {};

		$scope.newPost = new Post();

		Post.query(function(json){
			$scope.posts = json;
		});

		$scope.addPost = function(){
			$scope.newPost.$save(function(){
				$scope.posts.push($scope.newPost);
				$scope.newPost = new Post();
			});
		};

		$scope.destroyPost = function( post ){
			console.log(post);
			post.$delete(function(){
				var position = $scope.posts.indexOf(post);
				$scope.posts.splice(position, 1);
			});
		};


}]);





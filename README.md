#Setup for AngularJS on Rails

## This app is for queuing up posts for instagram.

## Create

1. ```rails _4.0.4_ new <appname> -T -d=postgresql``` 
	

## Remove bad useless gems in Gemfile.rb:

	1. Remove Turbolinks (gemfile, app/views/layouts/application.html.erb, application.js)

	2. Remove JBuilder gem

## Add good gems in Gemfile.rb:
	
```
			
	#for angularjs to work nicely on rails
	gem 'angularjs-rails' 
	gem 'angular-rails-templates'
	
	#for json APIs
	gem 'active_model_serializers'
	
	# debugging tools
	group :development do
	  gem 'meta_request' #rails inspector
	  gem "better_errors" #rails errorpage
	  gem "binding_of_caller" #rails errorpage
	end
	
	# testing
	group :development, :test do
	  gem 'rspec-rails', '~> 3.0.0'
	  gem 'guard-rspec', require: false #automatic rspec runner
	  gem 'shoulda-matchers'
	
	  gem "jasmine", github: "pivotal/jasmine-gem" #js testing
	end
	
```

## *Add in this to the applicationController:

```
	  def default_serializer_options
	    {root: false}
	  end
```


## Convert your controller to an API controller--
	
* add “defaults: {format: :json}” to routes
	
* use respond_to :json, respond_with in the controller
	

	## Generate a serializer, edit it:

	* rails g serializer modelname
	add attributes that should be part of the json

	## Generate a static controller:
	
	* rails g controller static index

	## Load up angular in application.js manifest
	
```
	//= require angular
	//= require angular-resource
	
	// If you want to include view templates:
	//= require angular-rails-templates
	//= require_tree ../templates

	(you can now put angular partial templates in app/assets/templates)
	
```


## Creating angular app

-  In app/views/dynamic/index.html.erb: 

```
	<div ng-app=”yourappname”>
		<insert either an div with an ng-controller put rest of main template here (like in class), or use a ui-view/ng-view for multi-view app>
	</div>
```

- In app.js (or where you create your angular module) :

```
	var yourAppName = angular.module('yourappname', ['ngResource']).config(
		['$httpProvider', function($httpProvider) {
		var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
		var defaults = $httpProvider.defaults.headers;
		defaults.common["X-CSRF-TOKEN"] = authToken;
		defaults.patch = defaults.patch || {};
		defaults.patch['Content-Type'] = 'application/json';
	}]);
```

- For each resource endpoint you’ve defined on the backend,
  you want to use a service so that you can then use it in your controller to stay DRY and for good practice:

```
	yourAppName.factory('Model', ['$resource', function($resource) {
	  return $resource('/model/:id',
   		 {id: '@id'},
   		 {update: { method: 'PATCH'}});
		}])
```

- For controller that uses that model:

```
	yourAppName.controller('ModelCtrl', [‘Model', '$scope', function(Model, $scope) {
	  	$scope.models= [];

	  Model.query(function(modesl) {
    	$scope.models = models;
	  });

	}])
	
```

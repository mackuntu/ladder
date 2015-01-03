'use strict'
var ladderApp = angular.module('ladderApp', [
    'ngRoute', 
    'ngResource', 
    'ladderControllers',
    'ngAnimate'
    ]);

ladderApp.config(['$routeProvider', '$locationProvider', '$httpProvider', 
    function ($routeProvider, $locationProvider, $httpProvider) {
        
        var checkLoggedin = function($q, $timeout, $http, $location, $rootScope){
            // Initialize a new promise
            var deferred = $q.defer();

            // Make an AJAX call to check if the user is logged in
            $http.get('/loggedin').success(function(user){
                // Authenticated
                if (user !== '0') {
                    $timeout(deferred.resolve, 0);
                    $rootScope.user = user.name;
                }
                // Not Authenticated
                else {
                    $rootScope.message = 'You need to log in.';
                    $timeout(function(){deferred.reject();}, 0);
                    $location.url('/login');
                }
            });

            return deferred.promise;
        };

        //================================================
        // Add an interceptor for AJAX errors
        //================================================
        $httpProvider.interceptors.push(function($q, $location) {
          return function(promise) {
            return promise.then(
              // Success: just return the response
              function(response){
                return response;
              }, 
              // Error: check the error status to get only the 401
              function(response) {
                if (response.status === 401)
                  $location.url('/login');
                return $q.reject(response);
              }
            );
          }
        });

        $routeProvider.
            when('/standings', {
                templateUrl: 'partials/standing-list',
                controller: 'PlayerListCtrl',
            })
            .when('/players', {
                templateUrl: 'partials/player-list',
                controller: 'PlayerListCtrl',
                resolve: {
                  loggedin: checkLoggedin
                }
            })
            .when('/players/:playerId', {
                templateUrl: 'partials/player-detail',
                controller: 'PlayerDetailCtrl'
            })
            .when('/login', {
                templateUrl: './login',
                controller: 'LoginCtrl'
            })
            .when('/register', {
                templateUrl: './register',
                controller: 'RegistrationCtrl'
            })
            .otherwise({
                redirectTo: '/standings'
            });
    }]);
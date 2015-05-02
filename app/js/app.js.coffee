'use strict'
ladderApp = angular.module('ladderApp', [
  'ngRoute'
  'ngResource'
  'ladderControllers'
  'ngAnimate'
])
ladderApp.config [
  '$routeProvider'
  '$locationProvider'
  '$httpProvider'
  ($routeProvider, $locationProvider, $httpProvider) ->

    checkLoggedin = ($q, $timeout, $http, $location, $rootScope) ->
      # Initialize a new promise
      deferred = $q.defer()
      # Make an AJAX call to check if the user is logged in
      $http.get('/loggedin').success (user) ->
        # Authenticated
        if user != '0'
          $timeout deferred.resolve, 0
          $rootScope.user = user.name
        else
          $rootScope.message = 'You need to log in.'
          $timeout (->
            deferred.reject()
            return
          ), 0
          $location.url '/login'
        return
      deferred.promise

    #================================================
    # Add an interceptor for AJAX errors
    #================================================
    $httpProvider.interceptors.push ($q, $location) ->
      (promise) ->
        promise.then ((response) ->
          response
        ), (response) ->
          if response.status == 401
            $location.url '/login'
          $q.reject response
    $routeProvider.when('/standings',
      templateUrl: 'partials/standing-list'
      controller: 'PlayerListCtrl').when('/players',
      templateUrl: 'partials/player-list'
      controller: 'PlayerListCtrl'
      resolve: loggedin: checkLoggedin).when('/players/:playerId',
      templateUrl: 'partials/player-detail'
      controller: 'PlayerDetailCtrl').when('/login',
      templateUrl: './login'
      controller: 'LoginCtrl').when('/register',
      templateUrl: './register'
      controller: 'RegistrationCtrl').otherwise redirectTo: '/standings'
    return
]
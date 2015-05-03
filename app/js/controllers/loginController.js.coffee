'use strict'
m = angular.module 'loginController', []

m.controller 'LoginCtrl', ($scope, $rootScope, $http, $location) ->
  $scope.user = {}

  $scope.login = ->
    console.log 'Called login'
    $http.post('/login',
      username: $scope.user.username
      password: $scope.user.password).success((user) ->
      $rootScope.message = 'Authentication successfull'
      $location.url '/admin'
    ).error ->
      console.log 'We had an error'
      $rootScope.message = 'Authentication failed'
      $location.url '/login'


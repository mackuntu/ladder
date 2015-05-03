'use strict'
m = angular.module 'playerDetailController', []

m.controller 'PlayerDetailCtrl', [
  '$scope'
  '$routeParams'
  ($scope, $routeParams) ->
    $scope.player = $routeParams.playerId
]
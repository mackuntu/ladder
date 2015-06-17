'use strict'
m = angular.module 'playerListController', ['ladderFactories']

m.controller 'PlayerListCtrl', [
  '$scope'
  '$http'
  'focus'
  ($scope, $http, focus) ->
    angular.extend $scope,
      players : []
      myRank : 0
      canChallenge : (rank) ->
        if $scope.myRank == -1
          false
        else if Math.abs(rank - $scope.myRank) <= 2
          true
        else
          false


    $scope.turnon = (id) ->
      console.log 'called turnon'
      focus id

    console.log 'called this controller'
    $scope.getPlayers()
    $scope.orderProp = 'rank'
]
'use strict'
m = angular.module 'playerListController', ['ladderServices']

m.controller 'PlayerListCtrl', [
  '$scope'
  '$http'
  'focus'
  'playerService'
  ($scope, $http, focus, playerService) ->
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
      getPlayers : ->
        playersPromise = playerService.getPlayers()
        playersPromise.then (playerList) ->
          $scope.players = playerList
          console.log(playerList)
      # This is a test method
      addRandom : ->
        console.log('called add random')
        randomPlayer =
          firstName: "Martin"
          lastName: Math.random().toString(36).substring(7)
          alias: Math.random().toString(36).substring(7)
          company: "Amazon"
          group: "ihm"
          suffix: String
          email: "mackuntu@gmail.com"
        playerService.createPlayer(randomPlayer)
        $scope.players.push(randomPlayer)

    $scope.turnon = (id) ->
      console.log 'called turnon'
      focus id

    console.log 'called this controller'
    $scope.getPlayers()
    $scope.orderProp = 'rank'
]
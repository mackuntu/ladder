'use strict'
m = angular.module 'playerListController', []

m.controller 'PlayerListCtrl', [
  '$scope'
  '$http'
  'focus'
  ($scope, $http, focus) ->
    $scope.players = []

    $scope.getPlayers = ->
      $http.get('/players').success((data, status, headers, config) ->
        console.log data
        if data
          i = 0
          while i < data.length
            $scope.players.push data[i]
            i++
      ).error (data, status, headers, config) ->
        console.log status

    $scope.addPlayer = ->
      if $scope.newPlayer
        maxRank = 0
        console.log $scope.players
        $http.post('/player',
          name: $scope.newPlayer
          alias: $scope.newPlayer
          company: 'amazon'
          group: 'ihm').success((data, status, headers, config) ->
          console.log data
        ).error (data, status, headers, config) ->
          console.log 'post to new player returned error'
          console.log status

    $scope.turnon = (id) ->
      console.log 'called turnon'
      focus id

    console.log 'called this controller'
    $scope.getPlayers()
    $scope.orderProp = 'rank'
]
'use strict'
m = angular.module 'ladderService', []

m.factory 'ladderService', [
  '$http'
  ($http) ->
    getPlayers : ->
      $http.get('/players').success (data, status, headers, config) ->
        console.log data
        if data
          i = 0
          while i < data.length
            $scope.players.push data[i]
            i++
      .error (data, status, headers, config) ->
        console.log status
    getGames : ->
      $http.get('/games').success (data, status, headers, config) ->
        console.log(data)
      .error (data, status, headers, config) ->

    addPlayer : (newPlayer)->
      for attribute in ['name', 'alias', 'company', 'group']
      if newPlayer
        maxRank = 0
        console.log $scope.players
        $http.post('/player',
          name: newPlayer
          alias: newPlayer
          company: 'amazon'
          group: 'ihm').success((data, status, headers, config) ->
          console.log data
        ).error (data, status, headers, config) ->
          console.log 'post to new player returned error'
          console.log status
]
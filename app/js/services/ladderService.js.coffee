'use strict'
m = angular.module 'ladderServices', []

m.factory 'playerService', [
  '$http'
  '$q'
  ($http, $q) ->
    getPlayers : ->
      deferred = $q.defer()
      $http.get '/players'
      .success (data) ->
        deferred.resolve(data)
      .error (data, status) ->
        deferred.reject(status)
      deferred.promise
    getPlayer : (email) ->
      deferred = $q.defer()
      $http.get 'player',
        email: email
      .success (data) ->
        console.log(data)

    createPlayer : (newPlayer) ->
      $http.put '/player',
        firstName: newPlayer.firstName
        lastName: newPlayer.lastName
        alias: newPlayer.alias
        company: newPlayer.company
        group: newPlayer.group
      .success (data) ->
        @getPlayer(newPlayer.alias)
      .error (data, status) ->
        console.log 'post to new player returned error'
        console.log status
]

m.factory 'tournamentService', [
  '$http'
  '$q'
  ($http, $q) ->
    createTournament : (newTournament) ->
      deferred = $q.defer()
      $http.put '/tournament',
        company: newTournament.company
        group: newTournament.group
        duration: newTournament.duration
        primaryOwner: newTournament.primaryOwner
        secondaryOwner: newTournament.secondaryOwner
        completed: newTournament.completed
        maxPlayers: newTournament.maxPlayers
      .success (data, status, headers, config) ->
        deferred.resolve(data)
      .error (data, status, headers, config) ->
        console.log(status)
        console.log(data)
        deferred.reject(status)
      deferred.promise
]

m.factory 'gameService', [
  '$http'
  '$q'
  ($http, $q) ->
    getGames : ->
      deferred = $q.defer()
      $http.get '/games'
      .success (data, status, headers, config) ->
        deferred.resolve(data)
      .error (data, status, headers, config) ->
        deferred.reject(status)
      deferred.promise
]
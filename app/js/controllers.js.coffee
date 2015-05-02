'use strict'
ladderControllers = angular.module('ladderControllers', [
  'ladderFactories'
  'ngSanitize'
])
ladderControllers.controller 'PlayerListCtrl', [
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
        return
      ).error (data, status, headers, config) ->
        console.log status
        return
      return

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
          return
        ).error (data, status, headers, config) ->
          console.log 'post to new player returned error'
          console.log status
          return
      return

    $scope.turnon = (id) ->
      console.log 'called turnon'
      focus id
      return

    console.log 'called this controller'
    $scope.getPlayers()
    $scope.orderProp = 'rank'
    return
]
ladderControllers.controller 'PlayerDetailCtrl', [
  '$scope'
  '$routeParams'
  ($scope, $routeParams) ->
    $scope.player = $routeParams.playerId
    return
]
ladderControllers.controller 'RegistrationCtrl', ($scope, $rootScope, $http, $location) ->
  $scope.user = {}

  $scope.register = ->
    if $scope.newPlayer
      maxRank = 0
      console.log $scope.players
      angular.forEach $scope.players, (player) ->
        if player.rank > maxRank
          maxRank = player.rank
          console.log maxRank
        return
      newPlayer = new Player(
        name: $scope.newPlayer
        rank: maxRank + 1)
      newPlayer.save ((err, result) ->

        ###* result is undefined since model.save() does not return value ###

        console.log newPlayer._id
        # print out: _id value
        newPlayer.remove()
        # remove this user from database
        return
      ), (err) ->

        ###* if something went wrong ###

        console.log err
        return
      $scope.players.push newPlayer
    return

  return
ladderControllers.controller 'LoginCtrl', ($scope, $rootScope, $http, $location) ->
  $scope.user = {}

  $scope.login = ->
    console.log 'Called login'
    $http.post('/login',
      username: $scope.user.username
      password: $scope.user.password).success((user) ->
      $rootScope.message = 'Authentication successfull'
      $location.url '/admin'
      return
    ).error ->
      console.log 'We had an error'
      $rootScope.message = 'Authentication failed'
      $location.url '/login'
      return
    return

  return
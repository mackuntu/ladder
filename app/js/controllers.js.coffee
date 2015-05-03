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
ladderControllers.controller 'PlayerDetailCtrl', [
  '$scope'
  '$routeParams'
  ($scope, $routeParams) ->
    $scope.player = $routeParams.playerId
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
      newPlayer = new Player(
        name: $scope.newPlayer
        rank: maxRank + 1)
      newPlayer.save ((err, result) ->


        console.log newPlayer._id
        # print out: _id value
        newPlayer.remove()
        # remove this user from database
      ), (err) ->

        ###* if something went wrong ###

        console.log err
      $scope.players.push newPlayer

ladderControllers.controller 'LoginCtrl', ($scope, $rootScope, $http, $location) ->
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


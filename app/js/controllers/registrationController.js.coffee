'use strict'
m = angular.module 'registrationController', []

m.controller 'RegistrationCtrl', ($scope, $rootScope, $http, $location) ->
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

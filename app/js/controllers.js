'use strict'

var ladderControllers = angular.module('ladderControllers', ['angoose.client']);

ladderControllers.controller('PlayerListCtrl', ['$scope', '$http', 'Player',
    function ($scope, $http, Player) {
        //$http.get('players/players.json').success(function(data) {
        //    $scope.players = data;
        //})
        
        $scope.players = Player.$query()

        $scope.addPlayer = function() {
            if ($scope.newPlayer){
                var maxRank = 0;
                console.log($scope.players);
                angular.forEach($scope.players, function (player) {
                    if (player.rank > maxRank) {
                        maxRank = player.rank;
                        console.log(maxRank);
                    }
                });
                var newPlayer = new Player({
                    name: $scope.newPlayer,
                    rank: maxRank + 1
                });
                newPlayer.save(function(err, result){
                    /** result is undefined since model.save() does not return value */
                    console.log(newPlayer._id);  // print out: _id value
                    newPlayer.remove(); // remove this user from database
                }, function(err){
                    /** if something went wrong */
                    console.log(err)
                });
                $scope.players.push(newPlayer);
            }
        };

        $scope.orderProp = 'rank';
    }]);

ladderControllers.controller('PlayerDetailCtrl', ['$scope', '$routeParams', 
    function ($scope, $routeParams) {
        $scope.player = $routeParams.playerId;
    }]);


ladderControllers.controller('RegistrationCtrl', function($scope, $rootScope, $http, $location) {
    $scope.user = {};
    $scope.register = function() {
        if ($scope.newPlayer){
            var maxRank = 0;
            console.log($scope.players);
            angular.forEach($scope.players, function (player) {
                if (player.rank > maxRank) {
                    maxRank = player.rank;
                    console.log(maxRank);
                }
            });
            var newPlayer = new Player({
                name: $scope.newPlayer,
                rank: maxRank + 1
            });
            newPlayer.save(function(err, result){
                /** result is undefined since model.save() does not return value */
                console.log(newPlayer._id);  // print out: _id value
                newPlayer.remove(); // remove this user from database
            }, function(err){
                /** if something went wrong */
                console.log(err)
            });
            $scope.players.push(newPlayer);
        };
    };
});

ladderControllers.controller('LoginCtrl', function($scope, $rootScope, $http, $location) {
    $scope.user = {};
    $scope.login = function() {
        $http.post('/login', {
            username: $scope.user.username,
            password: $scope.user.password,
        })
        .success(function(user) {
            $rootScope.message = 'Authentication successfull';
            $location.url('/admin');
        })
        .error(function() {
            $rootScope.messaage = 'Authentication failed';
            $location.url('/login');
        });
    };
});
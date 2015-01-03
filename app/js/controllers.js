'use strict'

var ladderControllers = angular.module('ladderControllers', ['ladderFactories', 'ngSanitize']);

ladderControllers.controller('PlayerListCtrl', ['$scope', '$http', 'focus', 
    function ($scope, $http, focus) {
        $scope.players = [];
        $scope.getPlayers = function() {
            $http.get("/players").success(function(data, status, headers, config){
                console.log(data);
                if (data) {
                    for (var i = 0; i < data.length; i++){
                        $scope.players.push(data[i]);
                    }
                }
            })
            .error(function(data, status, headers, config){
                console.log(status);
            });
        };

        $scope.addPlayer = function() {
            if ($scope.newPlayer){
                var maxRank = 0;
                console.log($scope.players);
                $http.post("/player", 
                    {
                        name: $scope.newPlayer,
                        alias: $scope.newPlayer,
                        company: "amazon",
                        group: "ihm" 
                    })
                    .success(function(data, status, headers, config){
                        console.log(data);
                    })
                    .error(function(data, status, headers, config){
                        console.log("post to new player returned error");
                        console.log(status);
                    });
            }
        };

        $scope.turnon = function(id) {
            console.log('called turnon');
            focus(id);
        };
        console.log('called this controller');
        $scope.getPlayers();
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
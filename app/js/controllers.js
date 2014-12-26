var ladderApp = angular.module('ladderApp', []);

ladderApp.controller('LadderAppCtrl', ['$scope', '$http', 
    function ($scope, $http) {
        $http.get('players/players.json').success(function(data) {
            $scope.players = data;
        })

        $scope.orderProp = 'rank';
    }]);


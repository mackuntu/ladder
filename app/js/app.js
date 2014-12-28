'use strict'
var ladderApp = angular.module('ladderApp', [
    'ngRoute', 
    'ladderControllers'
    ]);

ladderApp.config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.
            when('/players', {
                templateUrl: 'partials/player-list.html',
                controller: 'PlayerListCtrl'
            }).
            when('/players/:playerId', {
                templateUrl: 'partials/player-detail.html',
                controller: 'PlayerDetailCtrl'
            }).
            otherwise({
                redirectTo: '/players'
            });
    }]);
'use strict';

var utils = require('../utils');

describe('LadderApp Controller', function(){

    describe('PlayerListCtrl', function() {
        var scope, ctrl, $httpBackend;

        beforeEach(module('ladderApp'));

        beforeEach(inject(function( $rootScope, _$httpBackend_, $controller) {
            $httpBackend = _$httpBackend_;
            $httpBackend.expectGET('players/players.json').
                respond([
                    {
                        "name" : "Martin Qian",
                        "rank" : 1 
                    },

                    {
                        "name" : "Ben Hamming",
                        "rank" : 2 
                    },
                    
                    {
                        "name" : "Justin Krohn",
                        "rank" : 3 
                    }
                ]);
            scope = $rootScope.$new();
            ctrl = $controller('PlayerListCtrl', {$scope:scope})
        }));

        it('should create 3 "players" model with 3 players fetched from xhr', function() {
            expect(scope.players).toBeUndefined();
            $httpBackend.flush();
            expect(scope.players.length).toBe(3);
        });

        it('should set default value of orderProp model', function() {
            expect(scope.orderProp).toBe('rank');
        });
    });
});
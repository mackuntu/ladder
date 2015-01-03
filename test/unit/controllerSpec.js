'use strict';

describe('LadderApp Controller', function(){

    describe('PlayerListCtrl', function() {
        var scope, ctrl, $httpBackend;

        beforeEach(module('ladderApp'));

        beforeEach(inject(function( $rootScope, _$httpBackend_, $controller) {
            $httpBackend = _$httpBackend_;
            $httpBackend.expectGET('/players').
                respond([
                    {
                        "name" : "Martin Qian",
                        "rank" : 1
                    },

                    {
                        "name" : "Ben Hamming",
                        "rank" : 2 
                    }
                ]);
            scope = $rootScope.$new();
            ctrl = $controller('PlayerListCtrl', {$scope:scope})
        })); 

        it('should create 2 "players" model with 2 players fetched from xhr', function() {
            $httpBackend.flush();
            expect(scope.players.length).to.equal(2);
        });

        it('should set default value of orderProp model', function() {
            expect(scope.orderProp).to.equal('rank');
        });
    });

    describe('LoginCtrl', function() {
        var scope, ctrl, $httpBackend;

        beforeEach(module('ladderApp'));

        beforeEach(inject(function( $rootScope, _$httpBackend_, $controller) {
            $httpBackend = _$httpBackend_;
            scope = $rootScope.$new();
            ctrl = $controller('LoginCtrl', {$scope:scope})
        })); 

    });
});
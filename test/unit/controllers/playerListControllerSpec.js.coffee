'use strict'
describe 'LadderApp Controller', ->
  describe 'PlayerListCtrl', ->
    scope = undefined
    ctrl = undefined
    $httpBackend = undefined
    beforeEach module('playerListController')
    beforeEach inject(($rootScope, _$httpBackend_, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET('/players').respond [
        'name': 'Martin Qian'
        'rank': 1
      ,
        'name': 'Ben Hamming'
        'rank': 2
      ]
      scope = $rootScope.$new()
      ctrl = $controller('PlayerListCtrl', $scope: scope)
    )
    it 'should create 2 "players" model with 2 players fetched from xhr', ->
      $httpBackend.flush()
      expect(scope.players.length).to.equal 2

    it 'should set default value of orderProp model', ->
      expect(scope.orderProp).to.equal 'rank'

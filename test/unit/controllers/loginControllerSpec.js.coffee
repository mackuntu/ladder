describe 'LoginCtrl', ->
  scope = undefined
  ctrl = undefined
  $httpBackend = undefined
  beforeEach module('ladderApp')
  beforeEach inject(($rootScope, _$httpBackend_, $controller) ->
    $httpBackend = _$httpBackend_
    scope = $rootScope.$new()
    ctrl = $controller('LoginCtrl', $scope: scope)
  )
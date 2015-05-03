'use strict'

describe 'Route tests', ->
  # declare dependency variables for injection
  $route = null
  $location = null
  $rootScope = null
  $httpBackend = null

  # Initialize ladderRoutes module
  beforeEach module 'ladderRoutes'

  # Inject all needed dependencies
  ###
    $route will be used to unit test all route configurations
    $location will be used to simulate browser locations
    $rootScope is needed because we need to trigger $digest cycles if location changes is
      to be applied to route
  ###
  beforeEach inject (_$route_, _$location_, _$rootScope_, _$httpBackend_) ->
    $route = _$route_
    $location = _$location_
    $rootScope = _$rootScope_
    $httpBackend = _$httpBackend_
  it 'should initialize controllers correctly', ->
    expect($route.routes['/standings'].controller).to.equal 'PlayerListCtrl'
    expect($route.routes['/players'].controller).to.equal 'PlayerListCtrl'
    expect($route.routes['/login'].controller).to.equal 'LoginCtrl'
    expect($route.routes['/register'].controller).to.equal 'RegistrationCtrl'
    expect($route.routes[null].redirectTo).to.equal '/standings'

  it 'should initialize templates correctly', ->
    expect($route.routes['/standings'].templateUrl).to.equal 'partials/standing-list'
    expect($route.routes['/players'].templateUrl).to.equal 'partials/player-list'
    expect($route.routes['/players/:playerId'].templateUrl).to.equal 'partials/player-detail'
    expect($route.routes['/login'].templateUrl).to.equal './login'
    expect($route.routes['/register'].templateUrl).to.equal './register'

  it 'should route standings route as expected', ->
    expect($route.current).to.not.exist
    $httpBackend.expectGET('partials/standing-list').respond(200)
    # test routing to default route
    $location.path('/standings')
    $rootScope.$digest()
    expect($route.current.templateUrl).to.equal 'partials/standing-list'

  it 'should route player list as expected', ->
    $httpBackend.when('GET', 'partials/player-list').respond(200)
    $httpBackend.when('GET', '/loggedin').respond(200)
    # test routing to default route
    $location.path('/players')
    $rootScope.$digest()
    expect($route.current.templateUrl).to.equal 'partials/player-list'

  it 'should route player detail page as expected', ->
    $httpBackend.when('GET', 'partials/player-detail').respond(200)
    # test routing to default route
    $location.path('/players/123')
    $rootScope.$digest()
    expect($route.current.templateUrl).to.equal 'partials/player-detail'

  it 'should route login page as expected', ->
    $httpBackend.expectGET('./login').respond(200)
    # test routing to default route
    $location.path('/login')
    $rootScope.$digest()
    expect($route.current.templateUrl).to.equal './login'

  it 'should redirect to default route on not found', ->
    expect($route.current).to.not.exist
    $httpBackend.expectGET('partials/standing-list').respond(200)
    # test routing to fake error route also redirects to real route
    $location.path('/fake')
    $rootScope.$digest()
    expect($route.current.templateUrl).to.equal 'partials/standing-list'

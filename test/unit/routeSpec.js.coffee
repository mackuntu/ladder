'use strict'

describe 'Route tests', ->
  beforeEach module 'ladderRoutes'

  it 'should initialize routes correctly', ->
    inject ($route) ->
      expect($route.routes['/standings'].controller).to.equal 'PlayerListCtrl'
      expect($route.routes['/players'].controller).to.equal 'PlayerListCtrl'
      expect($route.routes['/login'].controller).to.equal 'LoginCtrl'
      expect($route.routes['/register'].controller).to.equal 'RegistrationCtrl'
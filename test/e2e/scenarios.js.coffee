describe 'Simple Ladder Tournament App', ->
  describe 'Player list view', ->
    beforeEach ->
      browser.get '/'
      return
    it 'should redirect index.html to index.html#/players', ->
      browser.get '/'
      browser.getLocationAbsUrl().then (url) ->
        expect(url.split('#')[1]).toBe '/players'
        return
      return
    it 'should filter the players by name as a user types into the search box', ->
      playerList = element.all(by.repeater('player in players'))
      query = element(by.model('query'))
      expect(playerList.count()).toBe 3
      query.sendKeys 'martin'
      expect(playerList.count()).toBe 1
      query.clear()
      query.sendKeys 'm'
      expect(playerList.count()).toBe 2
      return
    it 'should be possible to control player order via the drop down select box', ->
      playerNameColumn = element.all(by.repeater('player in players').column('player.name'))
      query = element(by.model('query'))

      getNames = ->
        playerNameColumn.map (elm) ->
          elm.getText()

      expect(getNames()).toEqual [
        'Martin Qian'
        'Ben Hamming'
        'Justin Krohn'
      ]
      element(by.model('orderProp')).element(by.css('option[value="name"]')).click()
      expect(getNames()).toEqual [
        'Ben Hamming'
        'Justin Krohn'
        'Martin Qian'
      ]
      return
    return
  return
describe('Simple Ladder Tournament App', function() {
    describe('Player list view', function() {
        beforeEach(function() {
            browser.get('/');
        });

        it('should redirect index.html to index.html#/players', function () {
            browser.get('/');
            browser.getLocationAbsUrl().then(function(url) {
                expect(url.split('#')[1]).toBe('/players');
            });
        });

        it('should filter the players by name as a user types into the search box', function() {
            var playerList = element.all(by.repeater('player in players'));
            var query = element(by.model('query'));

            expect(playerList.count()).toBe(3);

            query.sendKeys('martin');
            expect(playerList.count()).toBe(1);

            query.clear();
            query.sendKeys('m');
            expect(playerList.count()).toBe(2);
        });

        it('should be possible to control player order via the drop down select box', function() {

            var playerNameColumn = element.all(by.repeater('player in players').column('player.name'));
            var query = element(by.model('query'));

            function getNames() {
                return playerNameColumn.map(function(elm) {
                    return elm.getText();
                });
            }

            expect(getNames()).toEqual([
                "Martin Qian",
                "Ben Hamming",
                "Justin Krohn"
            ]);

            element(by.model('orderProp')).element(by.css('option[value="name"]')).click();

            expect(getNames()).toEqual([
                "Ben Hamming",
                "Justin Krohn",
                "Martin Qian"
            ]);
        });
    });


});
Models = ->
  Player : require('./player.js').Player
  Game : require('./game.js').Game
  Tournament : require('./tournament.js.coffee').Tournament

module.exports.Models = new Models()
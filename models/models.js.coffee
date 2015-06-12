Models = ->
  Player : require('./player.js').Player
  Game : require('./game.js').Game

module.exports.Models = new Models()
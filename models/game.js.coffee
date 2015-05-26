mongoose = require 'mongoose'
Schema = mongoose.Schema

GameSchema = new Schema(
  challenger:
    type: Schema.Types.ObjectId
    ref: 'Player'
  challengerRank: Number
  defender:
    type: Schema.Types.ObjectId
    ref: 'Player'
  defenderRank: Number
  winner:
    type: Schema.Types.ObjectId
    ref: 'Player'
  timeCreated:
    type: Date
    default: Date.now
  timeCompleted:
    type: Date
  completed: Boolean
  location: String
  duration: Number
  )

module.exports = mongoose.model('Game', GameSchema)